import csv
import json
import logging
import os
import re
import subprocess
from collections import defaultdict
from pathlib import Path
import shlex
from pprint import pformat

import pexpect
from django.core.management.base import BaseCommand, CommandError

import datalog
import ringapp
from datalog.souffle_utils import DL_DIR, TEMPLATES, write_ring_properties, write_ring_dims
from ringapp.constants import sidetype_choices
from ringapp.models import Ring, RingDimension, Dimension

logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Session you can use to process rings'

    def add_arguments(self, parser):
        parser.add_argument('ring_id', type=int)
        parser.add_argument('--record', action='store_true')

    def handle(self, *args, **options):
        try:
            os.remove(DL_DIR / 'ringlogic.dl')
        except FileNotFoundError:
            pass

        os.makedirs(Path(DL_DIR / 'inputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR / 'inputs')):
            os.remove(fn.path)

        os.makedirs(Path(DL_DIR / 'outputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR / 'outputs')):
            os.remove(fn.path)

        standardfacts = (TEMPLATES / 'rings' / 'standardfacts.tmpl').read_text()

        logger.info('building ringlogic.dl')
        with open(DL_DIR / 'ringlogic.dl', 'w') as f:
            f.write(standardfacts)
            logics_to_write = ringapp.models.Logic.objects.filter(active=True)
            for logic in logics_to_write:
                lines = map(lambda x: x + '\n', logic.to_souffle())
                f.writelines(lines)
            f.write(f'/* Wrote {logics_to_write.count()} active logic entries */')

        ring = ringapp.models.Ring.objects.get(pk=options['ring_id'])
        logger.info('building ring_known.facts')
        write_ring_properties(ring, complete=True)
        write_ring_dims(ring, complete=True)

        logger.info('running ringlogic.dl')
        os.chdir(datalog.__path__[0])
        subprocess.check_call(shlex.split('souffle -D./outputs -F./inputs ringlogic.dl'))
        try:
            assert os.path.getsize('outputs/ring_contradictions.csv') == 0, 'Contradiction encountered in ring properties'
            assert os.path.getsize('outputs/ring_dim_contradictions.csv') == 0, 'Contradiction encountered in ring dimensions'

        except AssertionError as exc:
            raise CommandError(exc)
        logger.info('enumerating logic lines')
        logic_enumeration = {}
        with open(DL_DIR / 'ringlogic.dl') as f:
            for line in f.readlines():
                if '  // logic ' in line:
                    key, value = line.split('  // logic ')
                    logic_enumeration[key.replace(' ', '')] = value.strip()
                elif '// ' in line:
                    key, value = line.split('// ')
                    logic_enumeration[key.replace(' ', '')] = value.strip()

        with open(DL_DIR / 'outputs' / 'ring_discovered.csv') as f:
            reader = csv.reader(f, delimiter='\t')
            content_rings = list(reader)

        with open(DL_DIR / 'outputs' / 'ring_dim_discovered.csv') as f:
            reader = csv.reader(f, delimiter='\t')
            content_ring_dims = list(reader)

        logger.info('starting explain session')
        proc = pexpect.spawn('souffle -D./outputs -F./inputs ringlogic.dl -t explain -j4', encoding='utf8', timeout=360)

        proc.expect('Enter command.+')
        logger.debug('explain ready')

        proc.sendline('format json')
        proc.expect('.+\nEnter command.+')

        rules = {}
        reasons = {}
        for mode, side, id in content_rings:
            logger.debug(f'explaining {mode}, {side}, {id}')
            command = f'explain ring_deduced("{mode}",{side}, {id})'
            proc.sendline(command)
            proc.expect(f'{re.escape(command)}\r\n(.+)\r\nEnter command.+')
            data = json.loads(proc.match.group(1))
            if not rules:
                rules = data['rules']
            reasons[data['proof']['premises']] = data['proof']['rule-number']

        for value, side, id in content_ring_dims:
            logger.debug(f'explaining {value}, {side}, {id}')
            command = f'explain ring_dim_deduced("{value}",{side}, {id})'
            proc.sendline(command)
            proc.expect(f'{re.escape(command)}\r\n(.+)\r\nEnter command.+')
            data = json.loads(proc.match.group(1))
            if not rules:
                rules = data['rules']
            reasons[data['proof']['premises']] = data['proof']['rule-number']

        proc.terminate()
        logger.info('creating rule lookup')
        rule_lookup = defaultdict(dict)
        for rule in rules:
            relation = re.match("^([\+_a-z0-9]+)\(.+", rule['rule']).group(1)
            rule_lookup[relation][rule['rule-number']] = rule['rule'].replace('\n   ', '')

        logger.info('annotating ring_discovered.csv')
        for triple in content_rings:
            number = reasons[f'ring_deduced("{triple[0]}", {triple[1]}, {triple[2]})']
            rule = rule_lookup['ring_deduced'][number]
            try:
                logic_id = logic_enumeration[rule.replace(' ', '')]
            except KeyError:
                logger.error(f"key {rule.replace(' ', '')} not found in logic_enumeration")
                logic_id = '?'

            for mode, side, _id in re.findall(re.compile('ring_deduced\("(has|lacks)",([0-9]+),([0-9]+)\)'), rule):
                property = ringapp.models.Property.objects.get(pk=int(_id)).name
                if side == '0':
                    sidestr = ''
                else:
                    sidestr = 'on the ' + dict(sidetype_choices)[int(side)]

                pat = re.compile(fr'ring_deduced\(\"{mode}\",{side},{_id}\)')
                replacement = f'\({"NOT" if mode=="lacks" else ""} \"PROPERTY\" {sidestr}\)'
                rule = re.sub(pat, replacement, rule)
                rule = rule.replace('PROPERTY', property)

            rule = re.sub(re.compile('\),'), ') AND ', rule)
            rule = re.sub(re.compile(':-'), '<===', rule)
            if rule.startswith('logical AND'):
                rule = 'logical AND'
            elif rule.startswith('logical OR'):
                rule = 'logical OR'
            elif rule.startswith('commutativity'):
                rule = 'commutativity'
            elif rule.startswith('asymmetry'):
                rule = 'asymmetry of a two-sided condition'
            triple.append(f'Logic (rings) {logic_id}: ' + rule)

        # logger.info('annotating ring_dim_discovered.csv')
        # for triple in content_ring_dims:???
        #     number = reasons[f'ring_deduced("{triple[0]}", {triple[1]}, {triple[2]})']
        #     rule = rule_lookup['ring_deduced'][number]
        #     try:
        #         logic_id = logic_enumeration[rule.replace(' ', '')]
        #     except KeyError:
        #         logger.error(f"key {rule.replace(' ', '')} not found in logic_enumeration")
        #         logic_id = '?'
        #
        #     for mode, side, _id in re.findall(re.compile('ring_deduced\("(has|lacks)",([0-9]+),([0-9]+)\)'), rule):
        #         property = ringapp.models.Property.objects.get(pk=int(_id)).name
        #         if side == '0':
        #             sidestr = ''
        #         else:
        #             sidestr = 'on the ' + dict(sidetype_choices)[int(side)]
        #
        #         pat = re.compile(fr'ring_deduced\(\"{mode}\",{side},{_id}\)')
        #         replacement = f'\({"NOT" if mode=="lacks" else ""} \"PROPERTY\" {sidestr}\)'
        #         rule = re.sub(pat, replacement, rule)
        #         rule = rule.replace('PROPERTY', property)
        #
        #     rule = re.sub(re.compile('\),'), ') AND ', rule)
        #     rule = re.sub(re.compile(':-'), '<===', rule)
        #     if rule.startswith('logical AND'):
        #         rule = 'logical AND'
        #     elif rule.startswith('logical OR'):
        #         rule = 'logical OR'
        #     elif rule.startswith('commutativity'):
        #         rule = 'commutativity'
        #     elif rule.startswith('asymmetry'):
        #         rule = 'asymmetry of a two-sided condition'
        #     triple.append(f'Logic (rings) {logic_id}: ' + rule)

        if options['record'] is True:
            logger.info('Recording discoveries')
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

            for value, side, pk in content_ring_dims:
                dimension = Dimension.objects.get(pk=pk)
                rd, created = ringapp.models.RingDimension.objects.get_or_create(
                    ring=ring,
                    dimension_type=dimension,
                )
                if side == '2':
                    rd.left_dimension = value
                    # rd.reason_left =
                elif side == '3':
                    rd.right_dimension = value
                    # rd.reason_right =
                elif side == '0':
                    rd.left_dimension = rd.right_dimension = value
                    # rd.reason_left = rd.reason_right =
                else:
                    raise CommandError(f"{side} is not a valid side indicator for a ring dimension")
                rd.save()
        else:
            logger.info("This would be recorded if you used the --record option")
            logger.info(pformat(content_rings))
