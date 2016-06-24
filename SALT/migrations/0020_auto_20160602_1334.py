# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0019_auto_20160602_1326'),
    ]

    operations = [
        migrations.AlterField(
            model_name='command',
            name='doc',
            field=models.TextField(max_length=2000, verbose_name='\u5e2e\u52a9\u6587\u6863', blank=True),
        ),
    ]
