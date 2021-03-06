# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2016-04-07 19:57
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0032_suggestion'),
    ]

    operations = [
        migrations.AlterField(
            model_name='glossary',
            name='reference',
            field=models.ManyToManyField(blank=True, to='ringapp.Citation', verbose_name='glossary reference'),
        ),
        migrations.AlterField(
            model_name='ring',
            name='keywords',
            field=models.ManyToManyField(blank=True, to='ringapp.Keyword', verbose_name='ring keywords'),
        ),
        migrations.AlterField(
            model_name='ring',
            name='reference',
            field=models.ManyToManyField(blank=True, to='ringapp.Citation', verbose_name='ring reference'),
        ),
    ]
