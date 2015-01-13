# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0002_logic_theorem'),
    ]

    operations = [
        migrations.AddField(
            model_name='commlogic',
            name='theorem',
            field=models.ForeignKey(db_column='theorem_id', blank=True, to='ringapp.Theorem', null=True),
            preserve_default=True,
        ),
    ]
