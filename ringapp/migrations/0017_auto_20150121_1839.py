# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0016_auto_20150121_1716'),
    ]

    operations = [
        migrations.AlterModelTable(
            name='comminvariance',
            table='comm_property_invarianttype',
        ),
        migrations.AlterModelTable(
            name='invariance',
            table='property_invarianttype',
        ),
    ]
