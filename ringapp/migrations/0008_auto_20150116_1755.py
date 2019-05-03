# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0007_auto_20150116_1532'),
    ]

    operations = [
        migrations.CreateModel(
            name='Invariance',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('is_invariant', models.BooleanField(default=None)),
                ('note', models.CharField(max_length=100)),
                ('example', models.ForeignKey(db_column='ring_ID', blank=True, to='ringapp.Ring', null=True, on_delete=models.CASCADE)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='InvariantType',
            fields=[
                ('type_id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('description', models.CharField(max_length=100)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='invariance',
            name='invarianttype',
            field=models.ForeignKey(to='ringapp.InvariantType', db_column='type_id', on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='invariance',
            name='property',
            field=models.ForeignKey(to='ringapp.Property', db_column='property_ID', on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='invariance',
            name='theorem',
            field=models.ForeignKey(db_column='theorem_id', blank=True, to='ringapp.Theorem', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
    ]
