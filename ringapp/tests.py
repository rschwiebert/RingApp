__author__ = 'ryan'

from django.test import TestCase
from models import RingProperty, Ring, Property, CommProperty, Logic
from models import Theorem
from AdminUtils import new_single_logic_forward, single_logic_forward
import subprocess
from django.core.urlresolvers import reverse
import random


class TestHeads(TestCase):
    """Testing headers for 200 OK status"""
    def test_1(self):
        """Hit core pages to see if they all return 200."""
        if not Logic.objects.all().exists():
            p = subprocess.Popen("psql -d test_ring_db -f test_db_data.sql",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            r, e = p.communicate()
            self.assertEqual('', e)

        for name in ['utilities', 'guides', 'processor', 'index',
                     'rings', 'properties', 'cproperties', 'logics', 'commlogics', 'theorems', 'about',
                     'people', 'resources', 'contribute', 'suggestions', 'bibliography', 'crings', 'search', 'csearch']:
            response = self.client.head(reverse(name))
            self.assertEqual(response.status_code, 200,
                             "request for head of url for '%s' returned code %d" % (name, response.status_code))

    def test_2(self):
        """Ring detail pages"""
        ids = [x.ring_id for x in Ring.objects.all()]
        self.assertLess(0, len(ids))
        for id in ids:
            response = self.client.head(reverse('rings') + 'ring/%d/' % id)
            self.assertEqual(response.status_code, 200,
                             "request for head of url for ring %d returned code %d" % (id, response.status_code))

    def test_3(self):
        """Property detail pages"""
        ids = [x.property_id for x in Property.objects.all()]
        self.assertLess(0, len(ids))
        for id in ids:
            response = self.client.head(reverse('properties') + 'property/%d/' % id)
            self.assertEqual(response.status_code, 200,
                             "request for head of url for property %d returned code %d" % (id, response.status_code))

    def test_4(self):
        """CommProperty detail pages"""
        ids = [x.property_id for x in CommProperty.objects.all()]
        self.assertLess(0, len(ids))
        for id in ids:
            response = self.client.head(reverse('cproperties') + 'property/%d/' % id)
            self.assertEqual(response.status_code, 200,
                             "request for head of url for commproperty %d returned code %d" % (id,
                                                                                               response.status_code))

    def test_5(self):
        """Theorem detail pages"""
        ids = [x.theorem_id for x in Theorem.objects.all()]
        self.assertLess(0, len(ids))
        for id in ids:
            response = self.client.head(reverse('theorems') + 'theorem/%d/' % id)
            self.assertEqual(response.status_code, 200,
                             "request for head of url for theorem %d returned code %d" % (id, response.status_code))

    def test_6(self):
        """CommRing detail pages"""
        prop = Property.objects.get(name='commutative')
        ids = [x.ring.ring_id for x in RingProperty.objects.filter(property=prop, has_property=1)]
        self.assertLess(0, len(ids))
        for id in ids:
            response = self.client.head(reverse('crings') + 'ring/%d/' % id)
            self.assertEqual(response.status_code, 200,
                             "request for head of url for ring %d returned code %d" % (id, response.status_code))


class ForwardLogicTestBase(TestCase):
    def setUp(self):
        if not Logic.objects.all().exists():
            p = subprocess.Popen("psql -d test_ring_db -f test_db_data.sql",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            r, e = p.communicate()
            self.assertEqual('', e)
        self.posprops = [Property.objects.get(name='commutative')]
        self.negprops = []
        RingProperty.objects.all().delete()

    def test_1(self):
        self.assertFalse(RingProperty.objects.all().exists(), 'RingProperty table is not clear')
        ctr = 0
        check = 1
        ring = Ring.objects.create(name='testring')

        for prop in self.posprops:
            new = RingProperty(ring=ring, property=prop, has_property=1,
                               reason='', source='')
            new.save()
        while ctr < 25 and check > 0:
            check = new_single_logic_forward(ring)
            if check == -1:
                self.fail('The new single logic forward script produced an error.')
        if ctr == 25:
            self.fail('The new single logic forward script ran too many times.')

        count1 = RingProperty.objects.count()

        RingProperty.objects.all().delete()
        for prop in self.posprops:
            new = RingProperty(ring=ring, property=prop, has_property=1,
                               reason='', source='')
            new.save()

        ctr = 0
        check = 1
        ring = Ring.objects.get(name='testring')
        while ctr < 25 and check > 0:
            check, err = single_logic_forward(ring)
            if err > 0:
                self.fail('The old single logic forward script produced an error.')
            print "Added %d rows." % check
        if ctr == 25:
            self.fail('The old single logic forward script ran too many times.')

        count2 = RingProperty.objects.count()

        self.assertEqual(count1, count2)

    def tearDown(self):
        RingProperty.objects.all().delete()


class ForwardLogicTest1(ForwardLogicTestBase):
    def setUp(self):
        if not Logic.objects.all().exists():
            p = subprocess.Popen("psql -d test_ring_db -f test_db_data.sql",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            r, e = p.communicate()
            self.assertEqual('', e)
        RingProperty.objects.all().delete()
        logic = random.choice(Logic.objects.filter(entry_type=1))
        conds = filter(lambda x: x is not None, [logic.cond_1, logic.cond_2, logic.cond_3, logic.cond_4])
        self.posprops = [Property.objects.get(property_id=x) for x in conds]
        self.negprops = []


class ForwardLogicTest2(ForwardLogicTestBase):
    def setUp(self):
        if not Logic.objects.all().exists():
            p = subprocess.Popen("psql -d test_ring_db -f test_db_data.sql",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            r, e = p.communicate()
            self.assertEqual('', e)
        RingProperty.objects.all().delete()
        logic = random.choice(Logic.objects.filter(entry_type=2))
        conds = filter(lambda x: x is not None, [logic.cond_1, logic.cond_2, logic.cond_3, logic.cond_4])
        self.posprops = [Property.objects.get(property_id=x) for x in conds]
        self.negprops = []


class ForwardLogicTest3(ForwardLogicTestBase):
    def setUp(self):
        if not Logic.objects.all().exists():
            p = subprocess.Popen("psql -d test_ring_db -f test_db_data.sql",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            r, e = p.communicate()
            self.assertEqual('', e)
        RingProperty.objects.all().delete()
        logic = random.choice(Logic.objects.filter(entry_type=3))
        conds = filter(lambda x: x is not None, [logic.cond_1, logic.cond_2, logic.cond_3, logic.cond_4])
        self.posprops = [Property.objects.get(property_id=x) for x in conds]
        self.negprops = []


class ForwardLogicTest4(ForwardLogicTestBase):
    def setUp(self):
        if not Logic.objects.all().exists():
            p = subprocess.Popen("psql -d test_ring_db -f test_db_data.sql",
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            r, e = p.communicate()
            self.assertEqual('', e)
        RingProperty.objects.all().delete()
        logic = random.choice(Logic.objects.filter(entry_type=4))
        conds = filter(lambda x: x is not None, [logic.cond_1, logic.cond_2, logic.cond_3, logic.cond_4])
        self.posprops = [Property.objects.get(property_id=x) for x in conds]
        self.negprops = []