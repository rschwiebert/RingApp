__author__ = 'ryan'

import unittest
from ringapp.models import test_Ring, test_RingProperty


class ParametrizedTestCase(unittest.TestCase):
    """ TestCase classes that want to be parametrized should
        inherit from this class.
    """
    def __init__(self, methodName='runTest', posprops=None, negprops=None):
        super(ParametrizedTestCase, self).__init__(methodName)
        self.posprops = posprops
        self.negprops = posprops

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


class ProposedRingTestCase(ParametrizedTestCase):
    def setUp(self):
        ring = test_Ring(name='testring', description='testdesc')
        ring.save()
        for prop in self.posprops:
            new = test_RingProperty(ring=ring, property=prop, has_property=1,
                                    reason='', source='')
            new.save()
        for prop in self.negprops:
            new = test_RingProperty(ring=ring, property=prop, has_property=0,
                                    reason='', source='')
            new.save()

    def test_sometest(self):
        # run logic on test_RingProperty
        pass

    def tearDown(self):
        test_Ring.objects.all().delete()
        test_RingProperty.objects.all().delete()


def main():
    from ringapp.models import Property
    posprops = [Property.objects.get(name='Noetherian (right)')]
    negprops = [Property.objects.get(name='Artinian (right)')]
    suite = unittest.TestSuite()
    suite.addTest(ParametrizedTestCase.parametrize(ProposedRingTestCase, posprops=posprops, negprops=negprops))
    unittest.TextTestRunner(verbosity=2).run(suite)
