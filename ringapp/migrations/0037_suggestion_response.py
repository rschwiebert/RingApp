# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2017-02-02 12:11
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0036_auto_20160601_1522'),
    ]

    operations = [
        migrations.AddField(
            model_name='suggestion',
            name='response',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
