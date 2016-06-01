# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0003_auto_20160415_1054'),
    ]

    operations = [
        migrations.AlterField(
            model_name='result',
            name='datetime',
            field=models.DateTimeField(verbose_name='\u6267\u884c\u65f6\u95f4', blank=True),
        ),
    ]
