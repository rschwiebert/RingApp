# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0008_auto_20150116_1755'),
    ]

    operations = [
        migrations.AlterModelTable(
            name='invariance',
            table='invariance',
        ),
        migrations.AlterModelTable(
            name='invarianttype',
            table='invariant_types',
        ),
    ]
