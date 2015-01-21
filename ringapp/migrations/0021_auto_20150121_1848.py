# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0020_auto_20150121_1843'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='InvariantType',
            new_name='Metaproperty',
        ),
    ]
