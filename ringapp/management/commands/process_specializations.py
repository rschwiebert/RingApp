"""Django management command: process_specializations

This command processes ring specialization pairs from the ``ring_specializations.csv``
template provided by the ``dart_data`` package.

It:
1. Loads pairs of (general_case, special_case) from the CSV.
2. Writes `specrings.facts` containing `(specializes, specialized)` mappings.
3. Queries known properties from the database for ONLY the rings involved in specializations.
4. Writes `ring_property.facts` with sides 2 (left) and 3 (right).
5. Runs `ringspeclogic.dl` through Soufflé to deduce new ring properties.
6. Checks for contradictions.
7. Displays or optionally records (via `--record`) newly discovered properties.

Typical usage::

    python manage.py process_specializations [--dry-run] [--record]
"""

import csv
import importlib.resources
import logging
import os
from pathlib import Path
import shlex
import subprocess

from django.core.management.base import BaseCommand, CommandError
from django.db import transaction

import datalog
from datalog.souffle_utils import DL_DIR
from ringapp.models import RingProperty

logger = logging.getLogger(__name__)


def explain(ring_id, mode, side, property_id, general_ring_id):
    if side == "2":
        side_str = "on the left "
    elif side == "3":
        side_str = "on the right "
    else:
        side_str = ""

    action = "has" if mode == "has" else "lacks"
    return f"ring={ring_id} {action} property={property_id} {side_str}as a special case of {general_ring_id}"


class Command(BaseCommand):
    help = "Process ring specializations and update related properties"

    def add_arguments(self, parser):
        """Define command-line arguments."""
        parser.add_argument(
            "--dry-run",
            action="store_true",
            help="Execute without persisting changes to the database",
        )
        parser.add_argument(
            "--record",
            action="store_true",
            help="Save discovered properties to the database",
        )

    def _load_pairs(self) -> list[tuple[int, int]]:
        """Load ``ring_specializations`` using :class:`csv.DictReader`.

        Returns a list of ``(general_case_id, special_case_id)`` tuples.
        The function is tolerant of missing files – it returns an empty list and
        writes a notice to the command output.
        """
        try:
            template_path = importlib.resources.files("dart_data") / "templates" / "dart_data" / "ring_specializations.csv"
            if not template_path.is_file():
                self.stdout.write(self.style.NOTICE(
                    "ring_specializations template not found; no specializations will be processed."
                ))
                return []
            with template_path.open("r", encoding="utf-8") as f:
                reader = csv.DictReader(f)
                pairs: list[tuple[int, int]] = []
                for row in reader:
                    if not row:
                        continue
                    first_val = (row.get("special_case") or "").strip()
                    if first_val.startswith("#"):
                        continue
                    parent = (row.get("general_case") or "").strip()
                    child = (row.get("special_case") or "").strip()
                    if parent and child:
                        try:
                            pairs.append((int(parent), int(child)))
                        except ValueError:
                            self.stdout.write(self.style.WARNING(
                                f"Invalid ring IDs in line: {row}"
                            ))
                    else:
                        self.stdout.write(self.style.WARNING(
                            f"Incomplete specialization line: {row}"
                        ))
                return pairs
        except Exception as exc:
            self.stdout.write(self.style.WARNING(f"Failed to load ring_specializations template: {exc}"))
            return []

    def handle(self, *args, **options):
        """Entry point for the command."""
        dry_run = options.get("dry_run", False)
        record = options.get("record", False)
        if dry_run:
            self.stdout.write(self.style.NOTICE("Running in dry-run mode; no changes will be saved."))

        pairs = self._load_pairs()
        if not pairs:
            self.stdout.write(self.style.WARNING("No specialization pairs found to process."))
            return

        inputs_dir = Path(DL_DIR / "inputs")
        os.makedirs(inputs_dir, exist_ok=True)
        for fn in os.scandir(inputs_dir):
            os.remove(fn.path)

        outputs_dir = Path(DL_DIR / "outputs")
        os.makedirs(outputs_dir, exist_ok=True)
        for fn in os.scandir(outputs_dir):
            os.remove(fn.path)

        # 1. Write specrings.facts (specializes \t specialized)
        specrings_facts = inputs_dir / "specrings.facts"
        ring_ids = set()
        with open(specrings_facts, "w") as f:
            for parent_id, child_id in pairs:
                ring_ids.add(parent_id)
                ring_ids.add(child_id)
                # specrings(specializes, specialized) -> child specializes parent
                f.write(f"{child_id}\t{parent_id}\n")

        self.stdout.write(f"Wrote {len(pairs)} pair(s) to {specrings_facts}")

        # 2. Write ring_property.facts for ONLY the rings involved
        ring_props = (
            RingProperty.objects
            .filter(ring_id__in=ring_ids)
            .select_related("property")
        )

        ring_property_facts = inputs_dir / "ring_property.facts"
        count = 0
        with open(ring_property_facts, "w") as f:
            for rp in ring_props:
                # Left side (side 2)
                if rp.has_on_left is True:
                    f.write(f"{rp.ring_id}\thas\t2\t{rp.property_id}\t0\n")
                    count += 1
                elif rp.has_on_left is False:
                    f.write(f"{rp.ring_id}\tlacks\t2\t{rp.property_id}\t0\n")
                    count += 1

                # Right side (side 3)
                if rp.has_on_right is True:
                    f.write(f"{rp.ring_id}\thas\t3\t{rp.property_id}\t0\n")
                    count += 1
                elif rp.has_on_right is False:
                    f.write(f"{rp.ring_id}\tlacks\t3\t{rp.property_id}\t0\n")
                    count += 1

        self.stdout.write(
            f"Wrote {count} property fact(s) across {len(ring_ids)} ring(s) to {ring_property_facts}"
        )

        # 3. Run Souffle
        logger.debug("Running ringspeclogic.dl")
        os.chdir(datalog.__path__[0])
        subprocess.check_call(shlex.split("souffle -D./outputs -F./inputs ringspeclogic.dl"))

        # 4. Check for contradictions
        for pth in outputs_dir.iterdir():
            if pth.name.endswith("contradictions.csv"):
                try:
                    assert pth.stat().st_size == 0, f"Contradiction found in {pth.name}"
                except AssertionError as exc:
                    raise CommandError(exc)

        # 5. Read output discoveries
        output_file = outputs_dir / "output_ring_property.csv"
        discovered = []
        if output_file.exists():
            with open(output_file, "r") as found:
                discovered = [line.strip() for line in found.readlines() if line.strip()]

        if not discovered:
            self.stdout.write(self.style.SUCCESS("No new properties discovered by specialization."))
            return

        self.stdout.write(self.style.NOTICE(f"Discovered {len(discovered)} new property value(s):"))
        for line in discovered:
            parts = line.split("\t")
            self.stdout.write(explain(*parts))

        discovered_deduplicated = dict()
        for line in discovered:
            discovered_deduplicated[tuple(line.split("\t")[:-1])] = line
        discovered = discovered_deduplicated.values()

        # 6. Record to database if requested and not dry_run
        if record and not dry_run:
            self.stdout.write("Recording discoveries to database...")
            with transaction.atomic():
                for line in discovered:
                    ring_id, mode, side, property_id, general_ring_id = line.split("\t")
                    mode_bool = True if mode == "has" else False
                    rp, created = RingProperty.objects.get_or_create(
                        ring_id=int(ring_id),
                        property_id=int(property_id),
                    )
                    reason = f"ringspeclogic.dl: {explain(ring_id, mode, side, property_id, general_ring_id)}"
                    if side == "2":
                        if rp.has_on_left is None:
                            rp.has_on_left = mode_bool
                            rp.reason_left = reason
                    elif side == "3":
                        if rp.has_on_right is None:
                            rp.has_on_right = mode_bool
                            rp.reason_right = reason

                    rp.save()
            self.stdout.write(self.style.SUCCESS("Recorded all discoveries successfully."))
        elif record and dry_run:
            self.stdout.write(self.style.NOTICE("Dry-run enabled: skipped writing to database."))
        else:
            self.stdout.write("Run with --record to persist these discoveries to the database.")
