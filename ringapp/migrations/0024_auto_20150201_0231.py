# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0023_auto_20150121_1925'),
    ]

    operations = [
        migrations.RenameField(
            model_name='ring',
            old_name='reference',
            new_name='old_reference',
        ),
        migrations.AddField(
            model_name='property',
            name='comm_version',
            field=models.ForeignKey(blank=True, to='ringapp.CommProperty', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='ring',
            name='kwds',
            field=models.CharField(max_length=200, null=True, blank=True),
            preserve_default=True,
        ),
    ]
