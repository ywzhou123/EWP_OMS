# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0027_auto_20160624_1535'),
    ]

    operations = [
        migrations.AddField(
            model_name='svnproject',
            name='target',
            field=models.CharField(default='salt', max_length=50, verbose_name='\u9879\u76ee\u76ee\u5f55'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='svnproject',
            name='path',
            field=models.CharField(max_length=200, verbose_name='\u9879\u76ee\u6839\u8def\u5f84'),
        ),
    ]
