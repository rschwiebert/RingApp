# Generated by Django 3.0 on 2022-05-10 11:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0055_auto_20200208_1803'),
    ]

    operations = [
        migrations.AlterField(
            model_name='dimension',
            name='symmetric',
            field=models.BooleanField(null=True),
        ),
        migrations.AlterField(
            model_name='logic',
            name='symmetric',
            field=models.BooleanField(null=True),
        ),
        migrations.AlterField(
            model_name='property',
            name='symmetric',
            field=models.BooleanField(null=True),
        ),
        migrations.AlterField(
            model_name='propertymetaproperty',
            name='has_metaproperty',
            field=models.BooleanField(null=True),
        ),
        migrations.AlterField(
            model_name='ring',
            name='is_commutative',
            field=models.BooleanField(null=True),
        ),
        migrations.AlterField(
            model_name='ringproperty',
            name='has_on_left',
            field=models.BooleanField(null=True),
        ),
        migrations.AlterField(
            model_name='ringproperty',
            name='has_on_right',
            field=models.BooleanField(null=True),
        ),
    ]
