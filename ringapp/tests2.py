__author__ = 'ryan'
from django.test import TestCase
from django.http import Http404
from ringapp.models import Property, Ring
from django.core.urlresolvers import reverse


class TestHeads(TestCase):
    def test_1(self):
        """Hit core pages to see if they all return 200."""
        Property.objects.create(property_id=1, name='commutative')
        for name in ['utilities', 'guides', 'processor', 'index',
                     'rings', 'properties', 'cproperties', 'logics', 'commlogics', 'theorems', 'about',
                     'people', 'resources', 'contribute', 'suggestions', 'bibliography', 'crings', 'search', 'csearch']:
            response = self.client.head(reverse(name))
            self.assertEqual(response.status_code, 200,
                             "request for head of url for '%s' returned code %d" % (name, response.status_code))

    # def test_2(self):
    #     ring = Ring.objects.create(name='testring', description='', reference='')
    #     has_props = lacks_props = other_props = []
    #     response = self.client.head(
    #         'rings/ring/1/',
    #         {'r': ring,
    #          'has_props': has_props,
    #          'lacks_props': lacks_props,
    #          'other_props': other_props
    #          })
    #     self.assertEqual(response.status_code, 200,
    #                      "request for head returned code %d" % response.status_code)


    # untested ['results', 'cresults', ]