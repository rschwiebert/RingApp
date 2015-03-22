# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0030_commring'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='commring',
            options={'verbose_name_plural': 'Commutative rings'},
        ),
    ]
