# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0025_auto_20160624_1152'),
    ]

    operations = [
        migrations.AddField(
            model_name='svnproject',
            name='salt_server',
            field=models.ForeignKey(default=2, verbose_name='Salt\u670d\u52a1\u5668', to='SALT.SaltServer'),
            preserve_default=False,
        ),
    ]
