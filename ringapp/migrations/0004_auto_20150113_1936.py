# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0003_commlogic_theorem'),
    ]

    operations = [
        migrations.RenameField(
            model_name='commequivalents',
            old_name='keywords',
            new_name='kwds',
        ),
        migrations.RenameField(
            model_name='equivalents',
            old_name='keywords',
            new_name='kwds',
        ),
        migrations.RenameField(
            model_name='ring',
            old_name='keywords',
            new_name='kwds',
        ),
    ]
