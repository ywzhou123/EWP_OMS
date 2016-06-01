# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0015_auto_20160527_1448'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='jid',
            field=models.CharField(max_length=50, verbose_name='\u4efb\u52a1\u53f7', blank=True),
        ),
    ]
