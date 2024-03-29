# Generated by Django 3.2.23 on 2024-02-03 03:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('ringapp', '0064_auto_20221105_1232'),
    ]

    operations = [
        migrations.CreateModel(
            name='Relation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('relation_type', models.CharField(choices=[('SUBRING_OF', 'is a subring of'), ('IMAGE_OF', 'is a homomorphic image of'), ('LOCALIZATION_OF', 'is a localization of'), ('CORNER_OF', 'is a corner ring of'), ('COMPLETION_OF', 'is the completion of'), ('INTEGRAL_CLOSURE_OF', 'is the integral closure of'), ('RING_OF_QUOTIENTS_OF', 'is the full ring of quotients of')], max_length=32)),
                ('note', models.TextField(blank=True, max_length=400, null=True)),
                ('first', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='first_ring', to='ringapp.ring')),
                ('second', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='second_ring', to='ringapp.ring')),
            ],
            options={
                'unique_together': {('first', 'second', 'relation_type')},
            },
        ),
        migrations.AddField(
            model_name='propertymetaproperty',
            name='relation',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='ringapp.relation'),
        ),
    ]
