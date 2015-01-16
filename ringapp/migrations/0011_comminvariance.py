# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0010_auto_20150116_1918'),
    ]

    operations = [
        migrations.CreateModel(
            name='CommInvariance',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('is_invariant', models.BooleanField(default=None)),
                ('note', models.CharField(max_length=100, null=True, blank=True)),
                ('example', models.ForeignKey(db_column='ring_ID', blank=True, to='ringapp.Ring', null=True)),
                ('invarianttype', models.ForeignKey(to='ringapp.InvariantType', db_column='type_id')),
                ('property', models.ForeignKey(to='ringapp.CommProperty', db_column='property_ID')),
                ('theorem', models.ForeignKey(db_column='theorem_id', blank=True, to='ringapp.Theorem', null=True)),
            ],
            options={
                'db_table': 'comm_invariance',
            },
            bases=(models.Model,),
        ),
    ]
