# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0011_comminvariance'),
    ]

    operations = [
        migrations.CreateModel(
            name='FAQ',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('question', models.CharField(max_length=200, null=True, blank=True)),
                ('answer', models.CharField(max_length=400, null=True, blank=True)),
            ],
            options={
                'db_table': 'faq',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Glossary',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('term', models.CharField(max_length=100, null=True, blank=True)),
                ('definition', models.CharField(max_length=400, null=True, blank=True)),
                ('reference', models.ManyToManyField(to='ringapp.Citation', verbose_name='glossary reference')),
            ],
            options={
                'db_table': 'glossary',
            },
            bases=(models.Model,),
        ),
    ]
