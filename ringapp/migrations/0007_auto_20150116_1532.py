# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0006_ring_keywords'),
    ]

    operations = [
        migrations.AddField(
            model_name='theorem',
            name='characterizes',
            field=models.ForeignKey(to='ringapp.Property', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='theorem',
            name='comm_characterizes',
            field=models.ForeignKey(to='ringapp.CommProperty', null=True, on_delete=models.CASCADE),
            preserve_default=True,
        ),
    ]
