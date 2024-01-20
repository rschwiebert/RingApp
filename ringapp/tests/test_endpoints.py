from django.test import TestCase
from django.shortcuts import reverse

from model_mommy import mommy

from ringapp import models
from django.contrib.auth.models import User


class EndpointTestCase(TestCase):
    databases = {'default', 'ringapp_data',}
    # fixtures = ['properties.json']

    def test_gets(self):
        rp = mommy.make(models.RingProperty)
        p = models.Property.objects.get(name='commutative')
        rp.property = p
        rp.save()
        ring = mommy.make(models.Ring)
        ring.id = 1
        ring.is_commutative = False
        # cit = mommy.make(Citation)  # https://github.com/lucastheis/django-publications/issues/27
        # ring.citation = [cit]
        ring.save()
        mommy.make(models.Keyword)
        mommy.make(User)
        mommy.make(models.Theorem)

        two_hundreds = ['index', 'about', 'auth_login',
                        'auth_password_reset', 'registration_register', 'bibliography',
                        'commring-list', 'csearch', 'contribute',
                        'ksearch', 'kresults',
                        'people', 'property-list', 'commproperty-list',
                        'register', 'resources', 'ring-list',
                        'search', 'results', 'theorem-list', 'inspiration']

        for item in two_hundreds:
            resp = self.client.get(reverse(item), follow=True)
            self.assertEqual(resp.status_code, 200, item)

        three_hundreds = ['auth_password_change', 'cresults', 'profile', 'newsfeed']
        for item in three_hundreds:
            resp = self.client.get(reverse(item))
            self.assertLessEqual(resp.status_code, 302, item)
            self.assertGreaterEqual(resp.status_code, 301, item)

        details = ['property-detail', 'theorem-detail',
                   'keyword-detail',  'ring-detail', 'expanded-detail', ]
        for item in details:
            resp = self.client.get(reverse(item, kwargs={'pk': 1}), follow=True)
            self.assertEqual(resp.status_code, 200, item)

        redirected_details = ['commproperty-detail', 'commring-detail', ]
        for item in redirected_details:
            resp = self.client.get(reverse(item, kwargs={'pk': 1}))
            self.assertEqual(resp.status_code, 301, item)
