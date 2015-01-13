# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0005_keyword'),
    ]

    operations = [
        migrations.AddField(
            model_name='ring',
            name='keywords',
            field=models.ManyToManyField(to='ringapp.Keyword', verbose_name='ring keywords'),
            preserve_default=True,
        ),
    ]
