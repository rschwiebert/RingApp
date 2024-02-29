# Generated by Django 3.2.23 on 2024-02-07 04:24

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0065_auto_20240203_0314'),
    ]

    operations = [
        migrations.AddField(
            model_name='metaproperty',
            name='relation_type',
            field=models.CharField(choices=[('NONE', '(error)'), ('SUBRING_OF', 'is a subring of'), ('IMAGE_OF', 'is a homomorphic image of'), ('LOCALIZATION_OF', 'is a localization of'), ('CORNER_OF', 'is a corner ring of'), ('FULL_CORNER_OF', 'is a full corner ring of'), ('COMPLETION_OF', 'is the completion of'), ('INTEGRAL_CLOSURE_OF', 'is the integral closure of'), ('RING_OF_QUOTIENTS_OF', 'is the full ring of quotients of'), ('CENTER_OF', 'is the center of'), ('POLYNOMIAL_RING_OF', 'is the polynomial ring of'), ('MATRIX_RING_OF', 'is a matrix ring of'), ('FG_ALGEBRA_OVER', 'is a finitely generated algebra over'), ('MORITA_EQ_TO', 'is Morita equivalent to'), ('POWER_SERIES_OF', 'is the power series ring of')], default='NONE', max_length=32),
        ),
        migrations.AlterField(
            model_name='relation',
            name='relation_type',
            field=models.CharField(choices=[('NONE', '(error)'), ('SUBRING_OF', 'is a subring of'), ('IMAGE_OF', 'is a homomorphic image of'), ('LOCALIZATION_OF', 'is a localization of'), ('CORNER_OF', 'is a corner ring of'), ('FULL_CORNER_OF', 'is a full corner ring of'), ('COMPLETION_OF', 'is the completion of'), ('INTEGRAL_CLOSURE_OF', 'is the integral closure of'), ('RING_OF_QUOTIENTS_OF', 'is the full ring of quotients of'), ('CENTER_OF', 'is the center of'), ('POLYNOMIAL_RING_OF', 'is the polynomial ring of'), ('MATRIX_RING_OF', 'is a matrix ring of'), ('FG_ALGEBRA_OVER', 'is a finitely generated algebra over'), ('MORITA_EQ_TO', 'is Morita equivalent to'), ('POWER_SERIES_OF', 'is the power series ring of')], default='NONE', max_length=32),
        ),
    ]