# Generated by Django 2.2.1 on 2020-02-08 18:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0054_theorem_categories'),
    ]

    operations = [
        migrations.AlterField(
            model_name='theorem',
            name='statement',
            field=models.TextField(max_length=1000),
        ),
    ]
