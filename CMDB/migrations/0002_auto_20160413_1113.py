# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CMDB', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='hostdetail',
            name='server_id',
            field=models.CharField(max_length=50, verbose_name='\u670d\u52a1ID', blank=True),
        ),
    ]
