# Generated by Django 2.2.27 on 2022-04-28 02:38

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0056_nullboolean_to_boolean'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='citation',
            name='user',
        ),
        migrations.RemoveField(
            model_name='logic',
            name='user',
        ),
        migrations.RemoveField(
            model_name='ring',
            name='user',
        ),
        migrations.RemoveField(
            model_name='suggestion',
            name='citation',
        ),
        migrations.RemoveField(
            model_name='theorem',
            name='user',
        ),
    ]