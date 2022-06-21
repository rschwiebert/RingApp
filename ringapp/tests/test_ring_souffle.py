from django.test import TestCase, TransactionTestCase

from ringapp.models import Logic, Property, RingProperty, Ring
from django.core.management import call_command


class SimpleTest(TestCase):
    databases = ['default', 'ringapp_data']

    def setUp(self) -> None:
        self.ring = Ring.objects.create()
        self.P1 = Property.objects.create(symmetric=False)
        self.P2 = Property.objects.create(symmetric=False)
        self.P3 = Property.objects.create(symmetric=False)
        self.P4 = Property.objects.create(symmetric=False)
        self.P5 = Property.objects.create(symmetric=False)
        self.P6 = Property.objects.create(symmetric=False)
        self.P7 = Property.objects.create(symmetric=False)
        self.RP1 = RingProperty.objects.create(ring=self.ring, property=self.P1)
        self.RP2 = RingProperty.objects.create(ring=self.ring, property=self.P2)
        self.RP3 = RingProperty.objects.create(ring=self.ring, property=self.P3)
        self.RP4 = RingProperty.objects.create(ring=self.ring, property=self.P4)
        self.RP5 = RingProperty.objects.create(ring=self.ring, property=self.P5)
        self.RP6 = RingProperty.objects.create(ring=self.ring, property=self.P6)
        self.RP7 = RingProperty.objects.create(ring=self.ring, property=self.P7)
        self.L1 = Logic.objects.create(hyps=f'ring_deduced("has",2,{self.P1.id})',
                                       concs=f'ring_deduced("has",2,{self.P2.id})',
                                       variety=0,
                                       symmetric=False,
                                       active=True)
        self.L2 = Logic.objects.create(hyps=f'ring_deduced("has",2,{self.P3.id}) AND ring_deduced("has",2,{self.P4.id})',
                                       concs=f'ring_deduced("has",2,{self.P5.id})',
                                       variety=0,
                                       symmetric=False,
                                       active=True)
        self.L3 = Logic.objects.create(hyps=f'ring_deduced("has",2,{self.P6.id})',
                                       concs=f'ring_deduced("has",2,{self.P7.id})',
                                       variety=1,
                                       symmetric=False,
                                       active=True)

    def test_L1(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP2.refresh_from_db()
        self.assertTrue(self.RP2.has_on_left)
        self.assertIsNone(self.RP2.has_on_right)

    def test_L1_backward(self):
        self.RP2.has_on_left = False
        self.RP2.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP1.refresh_from_db()
        self.assertFalse(self.RP2.has_on_left)
        self.assertIsNone(self.RP2.has_on_right)

    def test_L1_bothsides(self):
        self.RP1.has_on_left = True
        self.RP1.has_on_right = True
        self.RP1.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP2.refresh_from_db()
        self.assertTrue(self.RP2.has_on_left)
        self.assertTrue(self.RP2.has_on_right)

    def test_L2(self):
        self.RP3.has_on_left = True
        self.RP4.has_on_left = True
        self.RP3.save()
        self.RP4.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP5.refresh_from_db()
        self.assertTrue(self.RP5.has_on_left)

    def test_L2_negative(self):
        self.RP3.has_on_left = True
        self.RP5.has_on_left = False
        self.RP3.save()
        self.RP5.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP4.refresh_from_db()
        self.assertFalse(self.RP4.has_on_left)

    def test_l3_1(self):
        self.RP6.has_on_left = True
        self.RP6.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP7.refresh_from_db()
        self.assertTrue(self.RP7.has_on_left)

    def test_l3_2(self):
        self.RP6.has_on_left = False
        self.RP6.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP7.refresh_from_db()
        self.assertFalse(self.RP7.has_on_left)

    def test_l3_3(self):
        self.RP7.has_on_left = True
        self.RP7.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP6.refresh_from_db()
        self.assertTrue(self.RP6.has_on_left)

    def test_l3_4(self):
        self.RP7.has_on_left = False
        self.RP7.save()
        call_command('process_ring', self.ring.id, record=True)
        self.RP6.refresh_from_db()
        self.assertFalse(self.RP6.has_on_left)
