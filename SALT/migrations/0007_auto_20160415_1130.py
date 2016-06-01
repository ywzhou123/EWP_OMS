# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0006_auto_20160415_1104'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='result',
            name='salt_server',
        ),
        migrations.AddField(
            model_name='result',
            name='idc_id',
            field=models.IntegerField(default=1, verbose_name='Salt\u63a5\u53e3'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='result',
            name='client',
            field=models.CharField(max_length=20, verbose_name='\u6267\u884c\u65b9\u5f0f'),
        ),
        migrations.AlterField(
            model_name='result',
            name='datetime',
            field=models.DateTimeField(auto_now_add=True, verbose_name='\u6267\u884c\u65f6\u95f4'),
        ),
        migrations.AlterField(
            model_name='result',
            name='fun',
            field=models.CharField(max_length=50, verbose_name='\u547d\u4ee4'),
        ),
        migrations.AlterField(
            model_name='result',
            name='minions',
            field=models.CharField(max_length=500, verbose_name='\u76ee\u6807\u4e3b\u673a'),
        ),
        migrations.AlterField(
            model_name='result',
            name='tgt_type',
            field=models.CharField(max_length=20, verbose_name='\u76ee\u6807\u7c7b\u578b'),
        ),
    ]
