# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0023_svnproject_create_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='svnproject',
            name='status',
            field=models.CharField(default='\u65b0\u5efa', max_length=40, verbose_name='\u53d1\u5e03\u72b6\u6001'),
        ),
    ]
