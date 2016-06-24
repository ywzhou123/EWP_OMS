# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0018_auto_20160601_1622'),
    ]

    operations = [
        migrations.AlterField(
            model_name='command',
            name='cmd',
            field=models.CharField(max_length=40, verbose_name='Salt\u547d\u4ee4'),
        ),
        migrations.AlterUniqueTogether(
            name='command',
            unique_together=set([('module', 'cmd')]),
        ),
        migrations.AlterUniqueTogether(
            name='module',
            unique_together=set([('client', 'name')]),
        ),
    ]
