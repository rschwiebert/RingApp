# from django.test import TestCase
from unittest import TestCase

from ringapp.routers import RingAppRouter


class RouterTestCase(TestCase):
    def test_allowmigrations(self):
        router = RingAppRouter()
        cases = [
            ('default', 'ringapp', False),
            ('default', 'web', True),
            ('default', 'publications', False),
            ('default', '(anything)', True),
            ('ringapp_data', 'ringapp', True),
            ('ringapp_data', 'web', False),
            ('ringapp_data', 'publications', True),
            ('ringapp_data', '(anything)', False),
        ]
        for case in cases:
            db, app_label, result = case
            with self.subTest():
                self.assertEqual(router.allow_migrate(db, app_label), result)
