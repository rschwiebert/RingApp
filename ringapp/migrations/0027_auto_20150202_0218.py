# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0026_auto_20150202_0026'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ring',
            name='keywords',
            field=models.ManyToManyField(to='ringapp.Keyword', null=True, verbose_name='ring keywords', blank=True),
            preserve_default=True,
        ),
    ]
