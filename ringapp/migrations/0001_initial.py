# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Citation',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('location', models.CharField(max_length=50)),
                ('poster', models.CharField(max_length=30)),
                ('time', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'db_table': 'citations',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='CommEquivalents',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('equivalent', models.CharField(max_length=500)),
                ('keywords', models.CharField(max_length=200)),
                ('source', models.CharField(max_length=100)),
                ('poster', models.CharField(max_length=30, null=True, blank=True)),
            ],
            options={
                'db_table': 'comm_equivalents',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='CommLogic',
            fields=[
                ('logic_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='logic_ID')),
                ('entry_type', models.IntegerField(null=True, blank=True)),
                ('cond_1', models.IntegerField(null=True, blank=True)),
                ('cond_2', models.IntegerField(null=True, blank=True)),
                ('cond_3', models.IntegerField(null=True, blank=True)),
                ('cond_4', models.IntegerField(null=True, blank=True)),
                ('conc', models.IntegerField(null=True, blank=True)),
                ('option', models.CharField(max_length=200, blank=True)),
                ('citation', models.CharField(max_length=200, blank=True)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
                ('readable', models.CharField(max_length=120, null=True, blank=True)),
            ],
            options={
                'db_table': 'comm_logic',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='CommProperty',
            fields=[
                ('property_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='property_ID')),
                ('name', models.CharField(max_length=250)),
                ('definition', models.CharField(max_length=500)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
            ],
            options={
                'db_table': 'comm_properties',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='CommRingProperty',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('has_property', models.IntegerField(null=True, blank=True)),
                ('reason', models.CharField(max_length=200)),
                ('source', models.CharField(max_length=500)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
                ('time', models.DateTimeField(auto_now_add=True)),
                ('property', models.ForeignKey(db_column='property_ID', blank=True, to='ringapp.CommProperty', null=True, on_delete=models.CASCADE)),
            ],
            options={
                'db_table': 'comm_ring_property',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Equivalents',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('equivalent', models.CharField(max_length=500)),
                ('keywords', models.CharField(max_length=200)),
                ('source', models.CharField(max_length=100)),
                ('poster', models.CharField(max_length=30, null=True, blank=True)),
            ],
            options={
                'db_table': 'equivalents',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Logic',
            fields=[
                ('logic_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='logic_ID')),
                ('entry_type', models.IntegerField(null=True, blank=True)),
                ('cond_1', models.IntegerField(null=True, blank=True)),
                ('cond_2', models.IntegerField(null=True, blank=True)),
                ('cond_3', models.IntegerField(null=True, blank=True)),
                ('cond_4', models.IntegerField(null=True, blank=True)),
                ('conc', models.IntegerField(null=True, blank=True)),
                ('option', models.CharField(max_length=200, blank=True)),
                ('citation', models.CharField(max_length=200, null=True, blank=True)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
                ('readable', models.CharField(max_length=120, null=True, blank=True)),
            ],
            options={
                'db_table': 'logic',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Property',
            fields=[
                ('property_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='property_ID')),
                ('name', models.CharField(max_length=250)),
                ('definition', models.CharField(max_length=500)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
            ],
            options={
                'db_table': 'properties',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Publication',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('title', models.CharField(max_length=100)),
                ('authors', models.CharField(max_length=50)),
                ('details', models.CharField(max_length=100, null=True, blank=True)),
                ('pub_date', models.DateField()),
                ('poster', models.CharField(max_length=30)),
                ('time', models.DateTimeField(auto_now_add=True)),
            ],
            options={
                'db_table': 'publications',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Ring',
            fields=[
                ('ring_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='ring_ID')),
                ('name', models.CharField(max_length=250)),
                ('description', models.CharField(max_length=1000)),
                ('keywords', models.CharField(max_length=200)),
                ('reference', models.CharField(max_length=500)),
                ('notes', models.CharField(max_length=500, null=True, blank=True)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
            ],
            options={
                'db_table': 'rings',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='RingProperty',
            fields=[
                ('id', models.AutoField(unique=True, serialize=False, primary_key=True)),
                ('has_property', models.IntegerField(null=True, blank=True)),
                ('reason', models.CharField(max_length=200)),
                ('source', models.CharField(max_length=500)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
                ('time', models.DateTimeField(auto_now_add=True, null=True)),
                ('property', models.ForeignKey(db_column='property_ID', blank=True, to='ringapp.Property', null=True, on_delete=models.CASCADE)),
                ('ring', models.ForeignKey(db_column='ring_ID', blank=True, to='ringapp.Ring', null=True, on_delete=models.CASCADE)),
            ],
            options={
                'db_table': 'ring_property',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Theorem',
            fields=[
                ('theorem_id', models.AutoField(unique=True, serialize=False, primary_key=True, db_column='theorem_id')),
                ('alias', models.CharField(max_length=100, null=True, blank=True)),
                ('statement', models.CharField(max_length=400)),
                ('link', models.URLField(null=True, blank=True)),
                ('poster', models.CharField(max_length=25, null=True, blank=True)),
                ('time', models.DateTimeField(auto_now_add=True)),
                ('reference', models.ManyToManyField(to='ringapp.Citation', verbose_name='theorem reference')),
            ],
            options={
                'db_table': 'theorems',
            },
            bases=(models.Model,),
        ),
        migrations.AddField(
            model_name='equivalents',
            name='property',
            field=models.ForeignKey(db_column='property_ID', blank=True, to='ringapp.Property', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='commringproperty',
            name='ring',
            field=models.ForeignKey(db_column='ring_ID', blank=True, to='ringapp.Ring', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='commequivalents',
            name='property',
            field=models.ForeignKey(db_column='property_ID', blank=True, to='ringapp.CommProperty', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='citation',
            name='publication',
            field=models.ForeignKey(to='ringapp.Publication', on_delete=models.CASCADE),
            preserve_default=True,
        ),
    ]
