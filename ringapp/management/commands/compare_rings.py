import csv
import json
import logging
import os
import re
import subprocess
import time

import sys
from collections import defaultdict
from pathlib import Path
import shlex
from pprint import pformat

import pexpect
from django.core.management.base import BaseCommand, CommandError

import datalog
import ringapp
from datalog.souffle_utils import DL_DIR, TEMPLATES, write_ring_properties, write_ring_dims, write_ring_subsets
from ringapp.SuggestionUtils import humanize_souffle_rule
from ringapp.constants import sidetype_choices
from ringapp.models import Ring, RingDimension, Dimension, Subset

logger = logging.getLogger(__name__)


class Command(BaseCommand):
    help = 'Check if two rings differ on known properties'

    def add_arguments(self, parser):
        parser.add_argument('ring_id', type=int)
        parser.add_argument('other_ring_id', type=int)

    def handle(self, *args, **options):
        ring1 = ringapp.models.Ring.objects.get(pk=options['ring_id'])
        ring2 = ringapp.models.Ring.objects.get(pk=options['other_ring_id'])

        rpd1 = {rp.property: rp for rp in ring1.ringproperty_set.all()}
        rpd2 = {rp.property: rp for rp in ring2.ringproperty_set.all()}
        props1 = set(list(rpd1.keys()))
        props2 = set(list(rpd2.keys()))
        props = props1 & props2

        for prop in props:
            l1 = rpd1[prop].has_on_left
            l2 = rpd2[prop].has_on_left
            if None in (l1, l2):
                pass
            elif l1 != l2:
                logger.info(f"Rings differ on property {prop=}")
                return

            r1 = rpd1[prop].has_on_right
            r2 = rpd2[prop].has_on_right
            if None in (r1, r2):
                continue
            elif r1 != r2:
                logger.info(f"Rings differ on property {prop=}")
                return

        logger.info(f"No recorded differences between {ring1=} and {ring2=}")
