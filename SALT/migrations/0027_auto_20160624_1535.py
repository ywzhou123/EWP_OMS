# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0026_svnproject_salt_server'),
    ]

    operations = [
        migrations.AlterField(
            model_name='svnproject',
            name='password',
            field=models.CharField(max_length=40, verbose_name='SVN\u5bc6\u7801', blank=True),
        ),
    ]
