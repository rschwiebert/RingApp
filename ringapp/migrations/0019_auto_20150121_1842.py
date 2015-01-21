# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0018_auto_20150121_1841'),
    ]

    operations = [
        migrations.RenameField(
            model_name='comminvariance',
            old_name='invarianttype',
            new_name='metaproperty',
        ),
    ]
