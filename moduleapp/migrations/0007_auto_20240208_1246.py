# Generated by Django 3.2.23 on 2024-02-08 12:46

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('moduleapp', '0006_auto_20240203_0314'),
    ]

    operations = [
        migrations.AddField(
            model_name='metaproperty',
            name='relation_type',
            field=models.CharField(choices=[('NONE', '(error)'), ('SUBMOD_OF', 'is a submodule of'), ('IMAGE_OF', 'is a homomorphic image of'), ('SUMMAND_OF', 'is a direct summand of')], default='NONE', max_length=32),
        ),
        migrations.AlterField(
            model_name='relation',
            name='relation_type',
            field=models.CharField(choices=[('NONE', '(error)'), ('SUBMOD_OF', 'is a submodule of'), ('IMAGE_OF', 'is a homomorphic image of'), ('SUMMAND_OF', 'is a direct summand of')], max_length=32),
        ),
    ]