# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0012_saltserver_status'),
    ]

    operations = [
        migrations.DeleteModel(
            name='ClientType',
        ),
        migrations.DeleteModel(
            name='Upload',
        ),
        migrations.RemoveField(
            model_name='saltserver',
            name='status',
        ),
        migrations.AddField(
            model_name='saltserver',
            name='role',
            field=models.CharField(default=b'M', max_length=20, verbose_name='\u89d2\u8272', choices=[(b'M', 'Master'), (b'B', 'Backend')]),
        ),
    ]
