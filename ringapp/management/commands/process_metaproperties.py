import csv
import logging
import os
import shutil
import subprocess

import sys
from pathlib import Path
import shlex
from pprint import pformat

from django.core.management.base import BaseCommand, CommandError

import datalog
import ringapp
from datalog.souffle_utils import DL_DIR, TEMPLATES
from ringapp.models import Ring

logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Session you can use to process metaproperty data'

    def add_arguments(self, parser):
        parser.add_argument('--record', action='store_true')

    def handle(self, *args, **options):

        os.makedirs(Path(DL_DIR / 'inputs'), exist_ok=True)
        # for fn in os.scandir(Path(DL_DIR / 'inputs')):
        #     os.remove(fn.path)
        #
        # os.makedirs(Path(DL_DIR / 'outputs'), exist_ok=True)
        # for fn in os.scandir(Path(DL_DIR / 'outputs')):
        #     os.remove(fn.path)

        standardfacts = (TEMPLATES / 'rings' / 'metaproplogic.dl')
        shutil.copy(standardfacts, Path(DL_DIR))

        logger.debug('building ring_metaprop_known.facts')
        with open(DL_DIR / 'inputs' / 'ring_metaprop_known.facts', 'w') as f:
            for pmp in ringapp.models.PropertyMetaproperty.objects.all():
                if pmp.has_metaproperty is True:
                    f.write(f'has\t{pmp.metaproperty_id}\t{pmp.property_id}\n')
                elif pmp.has_metaproperty is False:
                    f.write(f'lacks\t{pmp.metaproperty_id}\t{pmp.property_id}\n')
                else:
                    logger.error(f"Invalid has_metaproperty: {pmp.has_metaproperty}")


        logger.info('running metaproplogic.dl')
        os.chdir(datalog.__path__[0])
        subprocess.check_call(shlex.split('souffle -D./outputs -F./inputs metaproplogic.dl'))
        for pth in Path(DL_DIR / 'outputs').iterdir():
            if pth.name.endswith('ring_metaprop_contradictions.csv'):
                try:
                    assert pth.stat().st_size == 0, f'Contradiction in {pth.name}'
                except AssertionError as exc:
                    raise CommandError(exc)


        with open(DL_DIR / 'outputs' / 'ring_metaprop_discovered.csv') as f:
            reader = csv.reader(f, delimiter='\t')
            content_metaprops = list(reader)


        if options['record'] is True:
            if not content_metaprops:
                logger.info("Nothing new discovered...")
                sys.exit(0)

            logger.info('Recording discoveries')
            for mode, metaprop_pk, prop_pk in content_metaprops:
                prop = ringapp.models.Property.objects.get(pk=prop_pk)
                metaprop = ringapp.models.Metaproperty.objects.get(pk=metaprop_pk)
                obj, created = ringapp.models.PropertyMetaproperty.objects.get_or_create(
                    metaproperty=metaprop,
                    property=prop,
                )
                if mode == "has":
                    obj.has_metaproperty = True
                elif mode == "lacks":
                    obj.has_metaproperty = False
                else:
                    logger.error(f"Invalid mode: {mode}")
                    continue
                obj.save()

        else:
            logger.info("This would be recorded if you used the --record option")
            logger.info(pformat(content_metaprops))
