# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0008_result_result'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='jid',
            field=models.CharField(unique=True, max_length=50, verbose_name='\u4efb\u52a1\u53f7', blank=True),
        ),
        migrations.AlterField(
            model_name='result',
            name='minions',
            field=models.CharField(max_length=500, verbose_name='\u76ee\u6807\u4e3b\u673a', blank=True),
        ),
    ]
