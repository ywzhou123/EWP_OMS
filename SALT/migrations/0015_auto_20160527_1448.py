# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0014_auto_20160527_1443'),
    ]

    operations = [
        migrations.AlterField(
            model_name='saltserver',
            name='role',
            field=models.CharField(default=b'Master', max_length=20, verbose_name='\u89d2\u8272', choices=[(b'Master', b'Master'), (b'Backend', b'Backend')]),
        ),
    ]
