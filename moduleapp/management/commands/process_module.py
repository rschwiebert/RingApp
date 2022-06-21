import csv
import json
import logging
import os
import re
import shlex
import subprocess
from collections import defaultdict
from pathlib import Path
from pprint import pformat

import pexpect

import datalog


from django.core.management.base import BaseCommand, CommandError
import ringapp
import moduleapp
from moduleapp.models import ModuleProperty
from ringapp.constants import sidetype_choices
from datalog.souffle_utils import write_ring_properties, write_module_properties, DL_DIR, TEMPLATES


logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Session you can use to process rings'

    def add_arguments(self, parser):
        parser.add_argument('module_id', type=int)
        parser.add_argument('--record', action='store_true')

    def handle(self, *args, **options):
        try:
            os.remove(DL_DIR / 'modulelogic.dl')
        except FileNotFoundError:
            pass

        os.makedirs(Path(DL_DIR/'inputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR/'inputs')):
            os.remove(fn.path)

        os.makedirs(Path(DL_DIR/'outputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR/'outputs')):
            os.remove(fn.path)

        standardfacts = (TEMPLATES/'modules'/'standardfacts.tmpl').read_text()

        logger.info('building modulelogic.dl')
        with open(DL_DIR/'modulelogic.dl', 'w') as f:
            f.write(standardfacts)
            logics_to_write = moduleapp.models.Logic.objects.filter(active=True)
            for logic in logics_to_write:
                lines = map(lambda x: x + '\n', logic.to_souffle())
                f.writelines(lines)
            f.write(f'/* Wrote {logics_to_write.count()} active logic entries */')

        module = moduleapp.models.Module.objects.get(pk=options['module_id'])
        logger.info('building ring_known.facts')
        write_ring_properties(module.ring, complete=True)
        logger.info('building module_known.facts')
        write_module_properties(module)

        logger.info('running modulelogic.dl')
        os.chdir(datalog.__path__[0])
        subprocess.check_call(shlex.split('souffle -D./outputs -F./inputs modulelogic.dl'))
        try:
            assert os.path.getsize('outputs/module_contradictions.csv') == 0, \
                'Contradiction encountered in module properties'
            assert os.path.getsize('outputs/ring_contradictions.csv') == 0, \
                'Contradiction encountered in ring properties'
        except AssertionError as exc:
            raise CommandError(exc)
        logger.info('enumerating logic lines')
        logic_enumeration = {}
        with open(DL_DIR/'modulelogic.dl') as f:
            for line in f.readlines():
                if '  // logic ' not in line:
                    continue
                key, value = line.split('  // logic ')
                logic_enumeration[key.replace(' ', '')] = value.strip()

        with open(DL_DIR/'outputs'/'module_discovered.csv') as f:
            reader = csv.reader(f, delimiter='\t')
            content_modules = list(reader)

        with open(DL_DIR/'outputs'/'ring_discovered.csv') as f:
            reader = csv.reader(f, delimiter='\t')
            content_rings = list(reader)

        # Begin souffle interaction
        logger.info('starting explain session')
        proc = pexpect.spawn('souffle -D./outputs -F./inputs modulelogic.dl -t explain', encoding='utf8')
        proc.expect('Enter command.+')
        proc.sendline('format json')
        proc.expect('.+\nEnter command.+')

        rules = {}
        reasons = {}
        for mode, _id in content_modules:
            logger.debug(f'explaining {mode}, {_id}')
            command = f'explain module_deduced("{mode}", {_id})'
            proc.sendline(command)
            proc.expect(f'{re.escape(command)}\r\n(.+)\r\nEnter command.+')
            data = json.loads(proc.match.group(1))
            if not rules:
                rules = data['rules']
            reasons[data['proof']['premises']] = data['proof']['rule-number']

        for mode, side, _id in content_rings:
            logger.debug(f'explaining {mode}, {side}, {_id}')
            command = f'explain ring_deduced("{mode}",{side}, {_id})'
            proc.sendline(command)
            proc.expect(f'{re.escape(command)}\r\n(.+)\r\nEnter command.+')
            data = json.loads(proc.match.group(1))
            if not rules:
                rules = data['rules']
            reasons[data['proof']['premises']] = data['proof']['rule-number']
        proc.terminate()
        # souffle interaction done

        logger.info('creating rule lookup')
        rule_lookup = defaultdict(dict)
        for rule in rules:
            relation = re.match("^([_a-z0-9]+)\(.+", rule['rule']).group(1)
            rule_lookup[relation][rule['rule-number']] = rule['rule'].replace('\n   ', '')

        logger.info('annotating module_discovered.csv')
        for pair in content_modules:
            number = reasons[f'module_deduced("{pair[0]}", {pair[1]})']
            rule = rule_lookup['module_deduced'][number]
            logic_id = logic_enumeration[rule.replace(' ', '')]
            for mode, _id in re.findall(re.compile('module_deduced\("(has|lacks)",([0-9]+)\)'), rule):
                property = moduleapp.models.Property.objects.get(pk=int(_id)).name
                rule = re.sub(re.compile(f'module_deduced\("{mode}",{_id}\)'), f'module({mode} \'{property}\')', rule)

            for mode, side, _id in re.findall(re.compile('ring_deduced\("(has|lacks)",([0-9]+),([0-9]+)\)'), rule):
                property = ringapp.models.Property.objects.get(pk=int(_id)).name
                if side == '0':
                    sidestr = ''
                else:
                    sidestr = 'on the ' + dict(sidetype_choices)[int(side)]
                rule = re.sub(re.compile(f'ring_deduced\("{mode}",{side},{_id}\)'),
                              f'ring({mode} \'{property}\' {sidestr})', rule)

            rule = re.sub(re.compile('\),'), ') AND ', rule)
            rule = re.sub(re.compile(':-'), '<===', rule)
            pair.append(f'Logic (modules) {logic_id}: ' + rule)

        logger.info('annotating ring_discovered.csv')
        for triple in content_rings:
            number = reasons[f'ring_deduced("{triple[0]}", {triple[1]}, {triple[2]})']
            rule = rule_lookup['ring_deduced'][number]
            logic_id = logic_enumeration[rule.replace(' ', '')]
            for mode, _id in re.findall(re.compile('module_deduced\("(has|lacks)",([0-9]+)\)'), rule):
                property = moduleapp.models.Property.objects.get(pk=int(_id)).name
                rule = re.sub(re.compile(f'module_deduced\("{mode}",{_id}\)'), f'module({mode} \'{property}\')', rule)

            for mode, side, _id in re.findall(re.compile('ring_deduced\("(has|lacks)",([0-9]+),([0-9]+)\)'), rule):
                property = ringapp.models.Property.objects.get(pk=int(_id)).name
                if side == '0':
                    sidestr = ''
                else:
                    sidestr = 'on the ' + dict(sidetype_choices)[int(side)]
                rule = re.sub(re.compile(f'ring_deduced\("{mode}",{side},{_id}\)'),
                              f'ring({mode} \'{property}\' {sidestr})', rule)

            rule = re.sub(re.compile('\),'), ') AND ', rule)
            rule = re.sub(re.compile(':-'), '<===', rule)
            triple.append(f'Logic (modules) {logic_id}: ' + rule)

        logger.info('Recording discoveries')
        if options['record'] is True:
            mod = moduleapp.models.Module.objects.get(pk=options['module_id'])
            ring = mod.ring
            for mode, pk, reason in content_modules:
                prop = moduleapp.models.Property.objects.get(pk=pk)
                mp, created = ModuleProperty.objects.get_or_create(
                    module=mod,
                    property=prop,
                )
                mp.has = True if mode == 'has' else False
                mp.reason = reason
                mp.save()

            for mode, side, pk, reason in content_rings:
                prop = ringapp.models.Property.objects.get(pk=pk)
                rp, created = ringapp.models.RingProperty.objects.get_or_create(
                    ring=ring,
                    property=prop,
                )
                if side == '0':
                    rp.has_on_left = True if mode == 'has' else False
                    rp.has_on_right = True if mode == 'has' else False
                    rp.reason_left = reason
                    rp.reason_right = reason
                elif side == '1':
                    continue
                elif side == '2':
                    rp.has_on_left = True if mode == 'has' else False
                    rp.reason_left = reason

                elif side == '3':
                    rp.has_on_right = True if mode == 'has' else False
                    rp.reason_right = reason
                else:
                    continue
                rp.save()

        else:
            logger.info("This is what would be recorded with --record")
            logger.info("for the module")
            logger.info(pformat(content_modules))
            logger.info("for the ring")
            logger.info(pformat(content_rings))
