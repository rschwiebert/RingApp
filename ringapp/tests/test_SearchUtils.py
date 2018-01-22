from django.test import TestCase
from ringapp import SearchUtils


class UtilityTest(TestCase):
    def test_mirror_search_terms(self):
        _input = ['H1l', 'H2r', 'L3l', 'L4r', 'H5', 'L6']
        output = ['H1r', 'H2l', 'L3r', 'L4l', 'H5', 'L6']
        check = SearchUtils.mirror_search_terms(_input)

        self.assertEqual(output, check)
