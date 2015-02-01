# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0024_auto_20150201_0231'),
    ]

    operations = [
        migrations.AddField(
            model_name='ring',
            name='reference',
            field=models.ManyToManyField(to='ringapp.Citation', verbose_name='ring reference'),
            preserve_default=True,
        ),
    ]
