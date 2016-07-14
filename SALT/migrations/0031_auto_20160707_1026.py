# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0030_auto_20160628_0931'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='result',
            name='idc_id',
        ),
        migrations.AddField(
            model_name='result',
            name='server',
            field=models.ForeignKey(default=2, verbose_name='\u6240\u5c5eSalt\u670d\u52a1\u5668', to='SALT.SaltServer'),
            preserve_default=False,
        ),
    ]
