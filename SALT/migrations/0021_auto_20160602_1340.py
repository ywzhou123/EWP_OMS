# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0020_auto_20160602_1334'),
    ]

    operations = [
        migrations.AlterField(
            model_name='command',
            name='cmd',
            field=models.CharField(max_length=100, verbose_name='Salt\u547d\u4ee4'),
        ),
        migrations.AlterField(
            model_name='command',
            name='doc',
            field=models.TextField(max_length=1000, verbose_name='\u5e2e\u52a9\u6587\u6863', blank=True),
        ),
    ]
