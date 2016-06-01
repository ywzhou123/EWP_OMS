# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CMDB', '0002_auto_20160413_1113'),
    ]

    operations = [
        migrations.AlterField(
            model_name='hostdetail',
            name='hwaddr_interfaces',
            field=models.CharField(max_length=150, verbose_name='MAC\u5730\u5740', blank=True),
        ),
    ]
