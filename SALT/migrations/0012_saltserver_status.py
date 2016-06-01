# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0011_upload'),
    ]

    operations = [
        migrations.AddField(
            model_name='saltserver',
            name='status',
            field=models.BooleanField(default=False, verbose_name='\u72b6\u6001'),
        ),
    ]
