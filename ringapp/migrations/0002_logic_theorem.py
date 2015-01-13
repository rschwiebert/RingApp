# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='logic',
            name='theorem',
            field=models.ForeignKey(db_column='theorem_id', blank=True, to='ringapp.Theorem', null=True),
            preserve_default=True,
        ),
    ]
