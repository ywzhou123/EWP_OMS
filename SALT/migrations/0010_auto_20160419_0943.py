# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0009_auto_20160418_1646'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='client',
            field=models.CharField(max_length=20, verbose_name='\u6267\u884c\u65b9\u5f0f', blank=True),
        ),
    ]
