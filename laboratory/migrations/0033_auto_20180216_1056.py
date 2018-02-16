# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2018-02-16 16:56
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('laboratory', '0032_solution'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='principaltechnician',
            name='credentials',
        ),
        migrations.AddField(
            model_name='principaltechnician',
            name='credentials',
            field=models.ManyToManyField(null=True, to=settings.AUTH_USER_MODEL),
        ),
    ]
