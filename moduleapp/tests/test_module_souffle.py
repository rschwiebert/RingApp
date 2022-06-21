from django.test import TestCase

import ringapp.models as ringmodels
import moduleapp.models as modmodels
from django.core.management import call_command, CommandError


class SimpleTest(TestCase):
    databases = ['default', 'ringapp_data']

    def setUp(self) -> None:
        self.ring = ringmodels.Ring.objects.create()
        self.module = modmodels.Module.objects.create(ring=self.ring)
        self.ring_P1 = ringmodels.Property.objects.create(symmetric=False)
        self.P1 = modmodels.Property.objects.create()
        self.P2 = modmodels.Property.objects.create()
        self.P3 = modmodels.Property.objects.create()
        self.P4 = modmodels.Property.objects.create()
        self.P5 = modmodels.Property.objects.create()
        self.P6 = modmodels.Property.objects.create()
        self.RP1 = ringmodels.RingProperty.objects.create(ring=self.ring, property=self.ring_P1)
        self.MP1 = modmodels.ModuleProperty.objects.create(module=self.module, property=self.P1)
        self.MP2 = modmodels.ModuleProperty.objects.create(module=self.module, property=self.P2)
        self.MP3 = modmodels.ModuleProperty.objects.create(module=self.module, property=self.P3)
        self.MP4 = modmodels.ModuleProperty.objects.create(module=self.module, property=self.P4)
        self.MP5 = modmodels.ModuleProperty.objects.create(module=self.module, property=self.P5)
        self.MP6 = modmodels.ModuleProperty.objects.create(module=self.module, property=self.P6)

        self.L1 = modmodels.Logic.objects.create(
            hyps=f'module_deduced("has",{self.P1.id})',
            concs=f'module_deduced("has",{self.P2.id})',
            variety=0,
            active=True)
        self.L2 = modmodels.Logic.objects.create(
            hyps=f'module_deduced("has",{self.P3.id}) AND module_deduced("has",{self.P4.id})',
            concs=f'module_deduced("has",{self.P5.id})',
            variety=0,
            active=True)
        self.L3 = modmodels.Logic.objects.create(
            hyps=f'ring_deduced("has",2,{self.ring_P1.id})',
            concs=f'module_deduced("has",{self.P6.id})',
            variety=1,
            active=True)

    def test_L1(self):
        self.MP1.has = True
        self.MP1.save()
        call_command('process_module', self.module.id, record=True)
        self.MP2.refresh_from_db()
        self.assertTrue(self.MP2.has)

    def test_L1_backward(self):
        self.MP2.has = False
        self.MP2.save()
        call_command('process_module', self.module.id, record=True)
        self.MP1.refresh_from_db()
        self.assertFalse(self.MP2.has)

    def test_L2(self):
        self.MP3.has = True
        self.MP4.has = True
        self.MP3.save()
        self.MP4.save()
        call_command('process_module', self.module.id, record=True)
        self.MP5.refresh_from_db()
        self.assertTrue(self.MP5.has)

    def test_L2_negative(self):
        self.MP3.has = True
        self.MP5.has = False
        self.MP3.save()
        self.MP5.save()
        call_command('process_module', self.module.id, record=True)
        self.MP4.refresh_from_db()
        self.assertFalse(self.MP4.has)

    def test_L3_1(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        call_command('process_module', self.module.id, record=True)
        self.MP6.refresh_from_db()
        self.assertTrue(self.MP6.has)

    def test_l3_2(self):
        self.MP6.has = False
        self.MP6.save()
        call_command('process_module', self.module.id, record=True)
        self.RP1.refresh_from_db()
        self.assertFalse(self.RP1.has_on_left)

    def test_contradiction_1(self):
        self.MP1.has = True
        self.MP1.save()
        self.MP2.has = False
        self.MP2.save()
        self.assertRaises(
            CommandError, call_command, 'process_module', self.module.id, record=True)

    def test_contradiction_2(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        self.MP6.has = False
        self.MP6.save()
        self.assertRaises(
            CommandError, call_command, 'process_module', self.module.id, record=True)
