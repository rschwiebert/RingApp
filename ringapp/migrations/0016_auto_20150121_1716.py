# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0015_auto_20150121_1712'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='commproperty',
            options={'verbose_name_plural': 'Commutative ring properties'},
        ),
        migrations.AlterModelOptions(
            name='commringproperty',
            options={'verbose_name_plural': 'Commutative ring-property relationships'},
        ),
        migrations.AlterModelOptions(
            name='glossary',
            options={'verbose_name_plural': 'Glossary entries'},
        ),
        migrations.AlterModelOptions(
            name='property',
            options={'verbose_name_plural': 'Ring properties'},
        ),
        migrations.AlterModelOptions(
            name='ringproperty',
            options={'verbose_name_plural': 'Ring-property relationships'},
        ),
    ]
