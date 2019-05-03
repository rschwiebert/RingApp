# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0012_faq_glossary'),
    ]

    operations = [
        migrations.CreateModel(
            name='test_Ring',
            fields=[
                ('ring_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='ring_ID')),
                ('name', models.CharField(max_length=250)),
                ('description', models.CharField(max_length=1000)),
            ],
            options={
                'db_table': 'test_rings',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='test_RingProperty',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('has_property', models.IntegerField(null=True, blank=True)),
                ('reason', models.CharField(max_length=200)),
                ('source', models.CharField(max_length=500)),
                ('property', models.ForeignKey(db_column='property_ID', blank=True, to='ringapp.Property', null=True, on_delete=models.CASCADE)),
                ('ring', models.ForeignKey(db_column='ring_ID', blank=True, to='ringapp.test_Ring', null=True, on_delete=models.CASCADE)),
            ],
            options={
                'db_table': 'test_ring_property',
            },
            bases=(models.Model,),
        ),
    ]
