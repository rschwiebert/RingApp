# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0009_auto_20150116_1759'),
    ]

    operations = [
        migrations.AlterField(
            model_name='invariance',
            name='note',
            field=models.CharField(max_length=100, null=True, blank=True),
            preserve_default=True,
        ),
    ]
