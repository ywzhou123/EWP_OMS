# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0028_auto_20160624_1609'),
    ]

    operations = [
        migrations.AlterUniqueTogether(
            name='svnproject',
            unique_together=set([('host', 'path', 'target')]),
        ),
    ]
