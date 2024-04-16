import logging
import os
import subprocess
from dataclasses import dataclass
from pathlib import Path
import shlex

from django.db import transaction
from django.template.loader import render_to_string

import datalog
import ringapp
from datalog.souffle_utils import DL_DIR

from django.core.management import BaseCommand, CommandError

from ringapp.models import RingProperty

logger = logging.getLogger(__name__)


def diffiterator(iter1, iter2):
    item1 = next(iter1)
    item2 = next(iter2)
    while True:
        try:
            if item1 == item2:
                item1 = next(iter1)
                item2 = next(iter2)
                continue
            else:
                yield item2
                item2 = next(iter2)
                continue

        except StopIteration:
            return


def explain(ring_id, mode, property_id, side, second_ring_id, relation_type):
    if side == '2':
        side_str = "on the left "
    elif side == '3':
        side_str = "on the right "
    else:
        side_str = ""

    if mode == 'has':
        return f"ring={ring_id} has property={property_id} {side_str}" \
                           f"because it is {relation_type} ring={second_ring_id} " \
                           f"which has property={property_id}"
    else:
        return f"ring={ring_id} lacks property={property_id} {side_str}" \
                           f"because ring={second_ring_id} lacks property={property_id} {side_str}" \
                           f"and is {relation_type} ring={ring_id}"


class Command(BaseCommand):
    help = 'Session you can use to process ring relations to deduce properties'

    def add_arguments(self, parser):
        parser.add_argument('--record', action='store_true')

    def handle(self, *args, **options):
        os.makedirs(Path(DL_DIR / 'inputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR / 'inputs')):
            os.remove(fn.path)

        os.makedirs(Path(DL_DIR / 'outputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR / 'outputs')):
            os.remove(fn.path)

        logger.debug('building ring_relation.facts')
        with open(DL_DIR / 'inputs' / 'ring_relation.facts', 'w') as f:
            for rel in ringapp.models.Relation.objects.all():
                f.write(f'{rel.first_id}\t{rel.relation_type}\t{rel.second_id}\n')

        logger.debug('building property_metaproperty.facts')
        with open(DL_DIR / 'inputs' / 'property_metaproperty.facts', 'w') as f:
            for pmp in ringapp.models.PropertyMetaproperty.objects.all():
                if pmp.has_metaproperty:
                    f.write(f'{pmp.property_id}\thas\t{pmp.metaproperty.relation_type}\n')
                else:
                    f.write(f'{pmp.property_id}\tlacks\t{pmp.metaproperty.relation_type}\n')

        logger.debug('building ring_property.facts')
        with open(DL_DIR / 'inputs' / 'ring_property.facts', 'w') as f:
            for prp in ringapp.models.RingProperty.objects.all():
                if prp.property.symmetric:
                    if prp.has_on_left:
                        f.write(f'{prp.ring_id}\thas\t{prp.property_id}\t0\t0\t\n')
                    else:
                        f.write(f'{prp.ring_id}\tlacks\t{prp.property_id}\t0\t0\t\n')
                else:
                    if prp.has_on_left is None:
                        pass
                    elif prp.has_on_left:
                        f.write(f'{prp.ring_id}\thas\t{prp.property_id}\t2\t0\t\n')
                    else:
                        f.write(f'{prp.ring_id}\tlacks\t{prp.property_id}\t2\t0\t\n')

                    if prp.has_on_right is None:
                        pass
                    elif prp.has_on_right:
                        f.write(f'{prp.ring_id}\thas\t{prp.property_id}\t3\t0\t\n')
                    else:
                        f.write(f'{prp.ring_id}\tlacks\t{prp.property_id}\t3\t0\t\n')

        data = [
            ('SUBRING_OF', True, False),
            ('IMAGE_OF', True, False),
            ('MORITA_EQ_TO', True, True),
        ]
        progfile = 'relationlogic.dl'
        try:
            os.remove(DL_DIR / progfile)
        except FileNotFoundError:
            pass

        souffleprogram = render_to_string('ringapp/relationlogic.tmpl', {"data": data})
        with open(DL_DIR / progfile, 'w') as f:
            f.write(souffleprogram)

        logger.debug(f'running relationlogic.dl')
        os.chdir(datalog.__path__[0])
        subprocess.check_call(shlex.split(f'souffle -D./outputs -F./inputs {progfile}'))

        for pth in Path(DL_DIR / 'outputs').iterdir():
            if pth.name.endswith('contradictions.csv'):
                try:
                    assert pth.stat().st_size == 0, f'Contradiction in {pth.name}'
                except AssertionError as exc:
                    raise CommandError(exc)

        with open('outputs/output_ring_property.csv') as found:
            discovered = [line.strip() for line in found.readlines()]

        reasons = []
        if options['record'] is True:
            logger.info('Recording discoveries')
            with transaction.atomic():
                for line in discovered:
                    line = line.split('\t')
                    reason = explain(*line)
                    reasons.append(reason)
                    ring_id, mode, property_id, side, _, _ = line
                    mode = True if mode == "has" else False
                    rp, created = RingProperty.objects.get_or_create(ring_id=ring_id, property_id=property_id)
                    if side == "0":
                        if rp.has_on_left is None:
                            rp.has_on_left = mode
                            rp.reason_left = reason

                    elif side == "2":
                        if rp.has_on_left is None:
                            rp.has_on_left = mode
                            rp.reason_left = reason

                    elif side == "3":
                        if rp.has_on_right is None:
                            rp.has_on_right = mode
                            rp.reason_right = reason

                    rp.save()

        else:
            for reason in reasons:
                print(reason)
