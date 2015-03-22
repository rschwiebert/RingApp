# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0029_auto_20150205_0635'),
    ]

    operations = [
        migrations.CreateModel(
            name='CommRing',
            fields=[
            ],
            options={
                'db_table': 'rings',
                'proxy': True,
            },
            bases=('ringapp.ring',),
        ),
    ]
