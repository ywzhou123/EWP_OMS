# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CMDB', '0003_auto_20160418_0856'),
        ('SALT', '0013_auto_20160526_1139'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='saltserver',
            name='ip',
        ),
        migrations.AddField(
            model_name='saltserver',
            name='idc',
            field=models.ForeignKey(default=1, verbose_name='\u6240\u5c5e\u673a\u623f', to='CMDB.IDC'),
            preserve_default=False,
        ),
    ]
