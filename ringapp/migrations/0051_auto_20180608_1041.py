# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2018-06-08 10:41
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0050_auto_20180606_1103'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='ringdimension',
            unique_together=set([('ring', 'dimension_type')]),
        ),
        migrations.AlterUniqueTogether(
            name='ringsubset',
            unique_together=set([('ring', 'subset_type')]),
        ),
    ]
