# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0022_auto_20150121_1856'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='comminvariance',
            options={'verbose_name_plural': 'Commutative property-metaproperty relationships'},
        ),
        migrations.AlterModelOptions(
            name='invariance',
            options={'verbose_name_plural': 'Property-metaproperty relationships'},
        ),
        migrations.AlterModelOptions(
            name='metaproperty',
            options={'verbose_name_plural': 'Metaproperties'},
        ),
    ]
