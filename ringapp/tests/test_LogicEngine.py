from django.test import TestCase
from ringapp.models import Logic, PropertySide, Ring, RingProperty
from ringapp.LogicUtils import LogicEngine, LogicError

from model_mommy import mommy

log_eng = LogicEngine()

# [(0, ''),
#  (1, 'left and right'),
#  (2, 'left'),
#  (3, 'right'),
#  (4, 'left or right'), ]


class LogicTestCase(TestCase):
    databases = ('default', 'ringapp_data', )
    def setUp(self):
        self.ring = Ring.objects.create(name='joe', is_commutative=False)
        self.ps1 = mommy.make(PropertySide, side=3)  # right
        self.ps2 = mommy.make(PropertySide, side=3)  # right
        self.ps3 = mommy.make(PropertySide, side=0)  # symmetric
        self.ps3.property.symmetric = True
        self.ps3.property.save()
        self.ps4 = mommy.make(PropertySide, side=4)  # left or right

    def test_merge_if_possible(self):
        d1 = {1: True, 2: True, 3: False}
        d2 = {1: True, 2: True, 4: False, 5: True}
        d3 = log_eng.merge_if_possible(d1, d2)
        d1.update(d2)
        self.assertEqual(d1, d3)

    def test_merge_if_possible_neg(self):
        d1 = {1: True, 2: True}
        d2 = {1: True, 2: False}
        with self.assertRaises(LogicError):
            log_eng.merge_if_possible(d1, d2)

    def test_simple_same_side_forward(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True,
                                    has_on_left=True)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps2.property,
                                            has_on_right=True,
                                            has_on_left=True)
        self.assertTrue(check.exists())

    def test_simple_same_side_backward(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps2.property,
                                    has_on_right=False,
                                    has_on_left=False)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps1.property,
                                            has_on_right=False,
                                            has_on_left=False)
        self.assertTrue(check.exists())

    def test_simple_exception(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True)
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps2.property,
                                    has_on_right=False)
        log_eng.reinitialize()
        log_eng.load_ringproperties(self.ring)
        with self.assertRaises(LogicError):
            log_eng.apply_logic(log, self.ring, {})

    def test_simple_equivalence_forward(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=1)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True,
                                    has_on_left=False)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps2.property,
                                            has_on_right=True,
                                            has_on_left=False)
        self.assertTrue(check.exists())

    def test_simple_equivalence_backward(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=1)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps2.property,
                                    has_on_right=False,
                                    has_on_left=True)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps1.property,
                                            has_on_right=False,
                                            has_on_left=True)
        self.assertTrue(check.exists())

    def test_simple_equivalence_exception(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=1)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=False)
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps2.property,
                                    has_on_right=True)
        log_eng.reinitialize()
        log_eng.load_ringproperties(self.ring)
        with self.assertRaises(LogicError):
            log_eng.apply_logic(log, self.ring, {})

    def test_one_implies_two_pos(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, self.ps3])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True,
                                    has_on_left=False)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check1 = RingProperty.objects.filter(ring=self.ring,
                                             property=self.ps2.property,
                                             has_on_right=True)
        check2 = RingProperty.objects.filter(ring=self.ring,
                                             property=self.ps3.property,
                                             has_on_right=True,
                                             has_on_left=True)
        self.assertTrue(check1.exists() and check2.exists())

    def test_one_implies_two_neg1(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, self.ps3])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps2.property,
                                    has_on_right=False)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps1.property,
                                            has_on_right=False)
        self.assertTrue(check.exists())

    def test_one_implies_two_neg2(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps2, self.ps3])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps3.property,
                                    has_on_right=False)
        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps1.property,
                                            has_on_right=False)
        self.assertTrue(check.exists())

    def test_two_implies_one_pos(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, self.ps3])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps3.property,
                                    has_on_right=True)
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True)

        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps2.property,
                                            has_on_right=True)
        self.assertTrue(check.exists())

    def test_two_implies_one_neg(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, self.ps3])
        log.concs.set([self.ps2, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps2.property,
                                    has_on_right=False)
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True)

        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps3.property,
                                            has_on_right=False)
        self.assertTrue(check.exists())

    def test_or_implies_one(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps4])
        log.concs.set([self.ps1, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps4.property,
                                    has_on_right=True,
                                    has_on_left=False)

        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps1.property,
                                            has_on_right=True)
        self.assertTrue(check.exists())

    def test_or_implies_one_neg(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps4])
        log.concs.set([self.ps1, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=False)

        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps4.property,
                                            has_on_right=False,
                                            has_on_left=False)
        self.assertTrue(check.exists())

    def test_one_implies_or(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps4, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps1.property,
                                    has_on_right=True)
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps4.property,
                                    has_on_right=False)

        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps4.property,
                                            has_on_right=False,
                                            has_on_left=True)
        self.assertTrue(check.exists())

    def test_one_implies_or_neg(self):
        log = Logic.objects.create(symmetric=False,
                                   variety=0)
        log.hyps.set([self.ps1, ])
        log.concs.set([self.ps4, ])
        log.save()
        RingProperty.objects.create(ring=self.ring,
                                    property=self.ps4.property,
                                    has_on_right=False,
                                    has_on_left=False)

        log_eng.reinitialize()
        log_eng.process_ring(self.ring)
        check = RingProperty.objects.filter(ring=self.ring,
                                            property=self.ps1.property,
                                            has_on_right=False,
                                            has_on_left=False)
        self.assertTrue(check.exists())

    def tearDown(self):
        RingProperty.objects.all().delete()
        Logic.objects.all().delete()
