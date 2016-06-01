# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0016_auto_20160530_1510'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='command',
            name='doc',
        ),
        migrations.RemoveField(
            model_name='module',
            name='info',
        ),
        migrations.RemoveField(
            model_name='module',
            name='url',
        ),
    ]
