# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0017_auto_20160531_1104'),
    ]

    operations = [
        migrations.DeleteModel(
            name='TargetType',
        ),
        migrations.AddField(
            model_name='command',
            name='doc',
            field=models.TextField(max_length=1000, verbose_name='\u5e2e\u52a9\u6587\u6863', blank=True),
        ),
        migrations.AddField(
            model_name='module',
            name='client',
            field=models.CharField(default=b'execution', max_length=20, verbose_name='Salt\u6a21\u5757'),
        ),
        migrations.AlterField(
            model_name='module',
            name='name',
            field=models.CharField(max_length=20, verbose_name='Salt\u6a21\u5757'),
        ),
    ]
