from django.test import TestCase
from django.shortcuts import reverse

from model_mommy import mommy

from ringapp.models import *


class EndpointTestCase(TestCase):
    def test_gets(self):
        rp = mommy.make(RingProperty)
        p = Property.objects.get(name='commutative')
        rp.property = p
        rp.save()
        ring = mommy.make(Ring)
        ring.id = 1
        ring.is_commutative = False
        # cit = mommy.make(Citation)  # https://github.com/lucastheis/django-publications/issues/27
        # ring.citation = [cit]
        ring.save()
        mommy.make(Keyword)
        mommy.make(News)
        mommy.make(User)
        mommy.make(Theorem)

        two_hundreds = ['index', 'about', 'auth_login',
                        'auth_password_reset', 'registration_register', 'bibliography',
                        'commring-list', 'csearch', 'contribute',
                        'ksearch', 'kresults', 'newsfeed', 'news-list',
                        'people', 'property-list',
                        'register', 'resources', 'ring-list',
                        'search', 'results', 'theorem-list', 'inspiration']

        for item in two_hundreds:
            resp = self.client.get(reverse(item))
            self.assertEqual(resp.status_code, 200, item)

        three_hundreds = ['auth_password_change', 'commproperty-list', 'cresults', 'profile', ]
        for item in three_hundreds:
            resp = self.client.get(reverse(item))
            self.assertLessEqual(resp.status_code, 302, item)
            self.assertGreaterEqual(resp.status_code, 301, item)

        details = ['property-detail', 'theorem-detail',
                   'keyword-detail',  'ring-detail', 'news-detail',  'expanded-detail', ]
        for item in details:
            resp = self.client.get(reverse(item, kwargs={'pk': 1}))
            self.assertEqual(resp.status_code, 200, item)

        redirected_details = ['commproperty-detail', 'commring-detail', ]
        for item in redirected_details:
            resp = self.client.get(reverse(item, kwargs={'pk': 1}))
            self.assertEqual(resp.status_code, 301, item)
