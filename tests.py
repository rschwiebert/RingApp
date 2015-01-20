__author__ = 'ryan'

import unittest
from ringapp.models import test_Ring, test_RingProperty
from ringapp.AdminUtils import new_single_logic_forward, single_logic_forward
import random


class ParametrizedTestCase(unittest.TestCase):
    """ TestCase classes that want to be parametrized should
        inherit from this class.
    """
    def __init__(self, methodName='runTest', posprops=None, negprops=None):
        super(ParametrizedTestCase, self).__init__(methodName)
        self.posprops = posprops
        self.negprops = negprops

    @staticmethod
    def parametrize(testcase_klass, posprops=None, negprops=None):
        """ Create a suite containing all tests taken from the given
            subclass, passing them the parameter 'param'.
        """
        testloader = unittest.TestLoader()
        testnames = testloader.getTestCaseNames(testcase_klass)
        suite = unittest.TestSuite()
        for name in testnames:
            suite.addTest(testcase_klass(name, posprops=posprops, negprops=negprops))
        return suite


class ForwardLogicTestCase(ParametrizedTestCase):
    def setUp(self):
        ring = test_Ring(name='testring', description='testdesc')
        ring.save()
        for prop in self.posprops:
            new = test_RingProperty(ring=ring, property=prop, has_property=1,
                                    reason='', source='')
            new.save()

    def test_1(self):
        ctr = 0
        check = 1
        ring = test_Ring.objects.get(name='testring')
        while ctr < 25 and check > 0:
            check = new_single_logic_forward(ring, test=True)
            if check == -1:
                self.fail('The new single logic forward script produced an error.')
        if ctr == 25:
            self.fail('The new single logic forward script ran too many times.')

        count = test_RingProperty.objects.count()
        print "There are %d rows in test_Ring Property." % count
        for item in test_RingProperty.objects.all():
            print item

    def test_2(self):
        ctr = 0
        check = 1
        ring = test_Ring.objects.get(name='testring')
        while ctr < 25 and check > 0:
            check, err = single_logic_forward(ring, test=True)
            if err > 0:
                self.fail('The old single logic forward script produced an error.')
            print "Added %d rows." % check
        if ctr == 25:
            self.fail('The old single logic forward script ran too many times.')

        count = test_RingProperty.objects.count()
        print "There are %d rows in test_Ring Property." % count
        for item in test_RingProperty.objects.all():
            print item

    def tearDown(self):
        test_Ring.objects.all().delete()
        test_RingProperty.objects.all().delete()


def main():
    from ringapp.models import Property
    rand_prop = random.choice(Property.objects.all())
    print rand_prop
    suite = unittest.TestSuite()
    suite.addTest(ParametrizedTestCase.parametrize(ForwardLogicTestCase, posprops=[rand_prop]))
    unittest.TextTestRunner(verbosity=2).run(suite)
