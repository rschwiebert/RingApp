# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2017-02-03 11:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0037_suggestion_response'),
    ]

    operations = [
        migrations.CreateModel(
            name='News',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.CharField(blank=True, max_length=256, null=True)),
            ],
        ),
    ]
