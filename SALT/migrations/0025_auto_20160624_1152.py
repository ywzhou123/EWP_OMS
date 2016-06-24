# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0024_svnproject_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='svnproject',
            name='info',
            field=models.TextField(max_length=500, verbose_name='\u5907\u6ce8\u4fe1\u606f', blank=True),
        ),
    ]
