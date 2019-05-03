# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0025_ring_reference'),
    ]

    operations = [
        migrations.RenameField(
            model_name='comminvariance',
            old_name='is_invariant',
            new_name='has_metaproperty',
        ),
        migrations.RenameField(
            model_name='invariance',
            old_name='is_invariant',
            new_name='has_metaproperty',
        ),
        migrations.AlterField(
            model_name='glossary',
            name='reference',
            field=models.ManyToManyField(to='ringapp.Citation', null=True, verbose_name='glossary reference', blank=True),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='theorem',
            name='characterizes',
            field=models.ForeignKey(blank=True, to='ringapp.Property', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='theorem',
            name='comm_characterizes',
            field=models.ForeignKey(blank=True, to='ringapp.CommProperty', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
    ]
