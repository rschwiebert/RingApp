import logging
import os
import shlex
import subprocess
from pathlib import Path

from django.core.management import BaseCommand

import datalog
import ringapp
from datalog.souffle_utils import DL_DIR, term_to_fact, TEMPLATES

logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Given the stored theorems, are the given conditions consistent?'

    def add_arguments(self, parser):
        parser.add_argument('--prop-term', nargs='+')
        parser.add_argument('--dim-term', nargs='*')
        parser.add_argument('--reload-logic', action='store_true')

    def handle(self, *args, **options):
        if options['reload_logic']:
            try:
                os.remove(DL_DIR / 'ringlogic.dl')
            except FileNotFoundError:
                pass

        os.makedirs(Path(DL_DIR / 'inputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR / 'inputs')):
            os.remove(fn.path)
            Path(fn.path).touch()

        os.makedirs(Path(DL_DIR / 'outputs'), exist_ok=True)
        for fn in os.scandir(Path(DL_DIR / 'outputs')):
            os.remove(fn.path)

        standardfacts = (TEMPLATES / 'rings' / 'standardfacts.tmpl').read_text()
        if options['reload_logic']:
            logger.debug('building ringlogic.dl')
            with open(DL_DIR / 'ringlogic.dl', 'w') as f:
                f.write(standardfacts)
                logics_to_write = ringapp.models.Logic.objects.filter(active=True)
                for logic in logics_to_write:
                    lines = map(lambda x: x + '\n', logic.to_souffle())
                    f.writelines(lines)
                f.write(f'/* Wrote {logics_to_write.count()} active logic entries */')

        with open(DL_DIR/'inputs'/'ring_known.facts', 'w') as f:
            for term in options['prop_term']:
                print(f"writing {term}")
                f.write(term_to_fact(term))

        os.chdir(datalog.__path__[0])
        subprocess.check_call(shlex.split('souffle -D./outputs -F./inputs ringlogic.dl'))

        for pth in Path(DL_DIR / 'outputs').iterdir():
            if pth.name.endswith('contradictions.csv'):
                try:
                    assert pth.stat().st_size == 0, f'Contradiction in {pth.name}'
                except AssertionError:
                    logger.info(f"The supplied inputs are inconsistent: see {pth.name} "
                                f"to view the contradictions.")
                    return False
        logger.info(f"The supplied conditions seem to be consistent with each other.")
        return True
