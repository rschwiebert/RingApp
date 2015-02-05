# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0027_auto_20150202_0218'),
    ]

    operations = [
        migrations.AlterField(
            model_name='ring',
            name='reference',
            field=models.ManyToManyField(to='ringapp.Citation', null=True, verbose_name='ring reference', blank=True),
            preserve_default=True,
        ),
    ]
