# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0007_auto_20160415_1130'),
    ]

    operations = [
        migrations.AddField(
            model_name='result',
            name='result',
            field=models.TextField(verbose_name='\u8fd4\u56de\u7ed3\u679c', blank=True),
        ),
    ]
