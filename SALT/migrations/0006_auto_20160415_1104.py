# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0005_auto_20160415_1102'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='datetime',
            field=models.DateTimeField(auto_now=True, verbose_name='\u6267\u884c\u65f6\u95f4'),
        ),
    ]
