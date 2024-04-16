from django.test import TestCase

from ringapp.models import Logic, Property, RingProperty, Ring, RingDimension, Dimension, Subset, RingSubset, Relation, \
    PropertyMetaproperty, Metaproperty
from django.core.management import call_command, CommandError


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
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP2.refresh_from_db()
        self.assertEqual(self.RP2.has_on_left, True)
        self.assertIsNone(self.RP2.has_on_right)

    def test_L1_backward(self):
        self.RP2.has_on_left = False
        self.RP2.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP1.refresh_from_db()
        self.assertEqual(self.RP2.has_on_left, False)
        self.assertIsNone(self.RP2.has_on_right)

    def test_L1_bothsides(self):
        self.RP1.has_on_left = True
        self.RP1.has_on_right = True
        self.RP1.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP2.refresh_from_db()
        self.assertEqual(self.RP2.has_on_left, True)
        self.assertEqual(self.RP2.has_on_right, True)

    def test_L2(self):
        self.RP3.has_on_left = True
        self.RP4.has_on_left = True
        self.RP3.save()
        self.RP4.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP5.refresh_from_db()
        self.assertEqual(self.RP5.has_on_left, True)

    def test_L2_negative(self):
        self.RP3.has_on_left = True
        self.RP5.has_on_left = False
        self.RP3.save()
        self.RP5.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP4.refresh_from_db()
        self.assertEqual(self.RP4.has_on_left, False)

    def test_l3_1(self):
        self.RP6.has_on_left = True
        self.RP6.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP7.refresh_from_db()
        self.assertEqual(self.RP7.has_on_left, True)

    def test_l3_2(self):
        self.RP6.has_on_left = False
        self.RP6.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP7.refresh_from_db()
        self.assertEqual(self.RP7.has_on_left, False)

    def test_l3_3(self):
        self.RP7.has_on_left = True
        self.RP7.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP6.refresh_from_db()
        self.assertEqual(self.RP6.has_on_left, True)

    def test_l3_4(self):
        self.RP7.has_on_left = False
        self.RP7.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RP6.refresh_from_db()
        self.assertEqual(self.RP6.has_on_left, False)



class RingDimTest(TestCase):
    databases = ['default', 'ringapp_data']

    def setUp(self) -> None:
        self.ring = Ring.objects.create()
        self.P1 = Property.objects.create(symmetric=False)
        self.RP1 = RingProperty.objects.create(ring=self.ring, property=self.P1)
        self.D1 = Dimension.objects.create()
        self.RD1 = RingDimension.objects.create(ring=self.ring, dimension_type=self.D1)
        self.L1 = Logic.objects.create(hyps=f'ring_deduced("has",2,{self.P1.id})',
                                       concs=f'ring_dim_deduced("1",2,{self.D1.id})',
                                       variety=0,
                                       symmetric=False,
                                       active=True)

    def test_L1_dim(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        self.RD1.refresh_from_db()
        self.assertEqual(self.RD1.left_dimension, '1')

    def test_L1_dim_conflict(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        self.RD1.left_dimension = '2'
        self.RD1.save()
        with self.assertRaises(CommandError):
            call_command('process_ring', self.ring.id, record=True, reload_logic=True)


class RingSubsetTest(TestCase):
    databases = ['default', 'ringapp_data']

    def setUp(self) -> None:
        self.ring = Ring.objects.create()
        self.P1 = Property.objects.create(symmetric=False)
        self.RP1 = RingProperty.objects.create(ring=self.ring, property=self.P1)
        self.S1 = Subset.objects.create()
        # self.RS1 = RingSubset.objects.create(ring=self.ring, subset_type=self.S1, subset='1')
        self.L1 = Logic.objects.create(hyps=f'ring_deduced("has",2,{self.P1.id})',
                                       concs=f'ring_subset_deduced("1",{self.S1.id})',
                                       variety=0,
                                       symmetric=True,
                                       active=True)

    def test_L1_subset(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        call_command('process_ring', self.ring.id, record=True, reload_logic=True)
        rs1 = RingSubset.objects.get(ring=self.ring, subset_type=self.S1)
        self.assertEqual(rs1.subset, '1')

    def test_L1_subset_conflict(self):
        self.RP1.has_on_left = True
        self.RP1.save()
        RingSubset.objects.create(ring=self.ring, subset_type=self.S1, subset='2')

        with self.assertRaises(CommandError):
            call_command('process_ring', self.ring.id, record=True, reload_logic=True)


class RelationTest(TestCase):
    databases = ['default', 'ringapp_data']

    def setUp(self) -> None:
        self.ring_1 = Ring.objects.create()
        self.ring_2 = Ring.objects.create()
        self.ring_3 = Ring.objects.create()
        self.rel_1 = Relation.objects.create(first=self.ring_1, second=self.ring_2, relation_type=Relation.RelationType.SUB_OF)
        self.rel_2 = Relation.objects.create(first=self.ring_2, second=self.ring_3, relation_type=Relation.RelationType.IM_OF)
        self.P1 = Property.objects.create(symmetric=False)
        self.P2 = Property.objects.create(symmetric=True)
        self.MP1 = Metaproperty.objects.create(relation_type=Relation.RelationType.SUB_OF)
        self.MP2 = Metaproperty.objects.create(relation_type=Relation.RelationType.IM_OF)
        self.PMP1 = PropertyMetaproperty.objects.create(property=self.P1, metaproperty=self.MP1, has_metaproperty=True)
        self.PMP2 = PropertyMetaproperty.objects.create(property=self.P2, metaproperty=self.MP2, has_metaproperty=True)
        self.PMP3 = PropertyMetaproperty.objects.create(property=self.P2, metaproperty=self.MP1, has_metaproperty=True)
        self.PMP4 = PropertyMetaproperty.objects.create(property=self.P1, metaproperty=self.MP2, has_metaproperty=True)

    def test_symmetric_inheritance(self):
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P2, has_on_left=True).exists())
        rp = RingProperty.objects.create(ring=self.ring_3, property=self.P2, has_on_left=True)
        call_command('process_relations', record=True)
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_2, property=self.P2, has_on_left=True).exists())
        rp.delete()

    def test_asymmetric_inheritance(self):
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_1, property=self.P1, has_on_left=True).exists())
        rp = RingProperty.objects.create(ring=self.ring_2, property=self.P1, has_on_left=True)
        call_command('process_relations', record=True)
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_1, property=self.P1, has_on_left=True).exists())
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_1, property=self.P1, has_on_right=True).exists())
        rp.delete()

    def test_combined_inheritance(self):
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P2, has_on_left=True).exists())
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_1, property=self.P2, has_on_left=True).exists())
        rp = RingProperty.objects.create(ring=self.ring_3, property=self.P2, has_on_left=True)
        call_command('process_relations', record=True)
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_2, property=self.P2, has_on_left=True).exists())
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_1, property=self.P2, has_on_left=True).exists())
        rp.delete()

    def test_symmetric_disinheritance(self):
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_3, property=self.P2, has_on_left=False).exists())
        rp = RingProperty.objects.create(ring=self.ring_2, property=self.P2, has_on_left=False)
        call_command('process_relations', record=True)
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_3, property=self.P2, has_on_left=False).exists())
        rp.delete()

    def test_asymmetric_disinheritance(self):
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P1, has_on_left=False).exists())
        rp = RingProperty.objects.create(ring=self.ring_1, property=self.P1, has_on_left=False)
        call_command('process_relations', record=True)
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_2, property=self.P1, has_on_left=False).exists())
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P1, has_on_right=False).exists())
        rp.delete()

    def test_combined_disinheritance(self):
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P1, has_on_left=False).exists())
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_3, property=self.P1, has_on_left=False).exists())
        rp = RingProperty.objects.create(ring=self.ring_1, property=self.P1, has_on_left=False)
        call_command('process_relations', record=True)
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_2, property=self.P1, has_on_left=False).exists())
        self.assertTrue(RingProperty.objects.filter(ring=self.ring_3, property=self.P1, has_on_left=False).exists())
        rp.delete()

    def test_contradiction(self):
        fakerp = RingProperty.objects.create(ring=self.ring_2, property=self.P2, has_on_left=False)
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P2, has_on_left=True).exists())
        rp = RingProperty.objects.create(ring=self.ring_3, property=self.P2, has_on_left=True)
        with self.assertRaises(CommandError):
            call_command('process_relations', record=True)
        self.assertFalse(RingProperty.objects.filter(ring=self.ring_2, property=self.P2, has_on_left=True).exists())
        rp.delete()
        fakerp.delete()