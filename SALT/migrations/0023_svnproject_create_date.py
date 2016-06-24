# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0022_auto_20160623_1616'),
    ]

    operations = [
        migrations.AddField(
            model_name='svnproject',
            name='create_date',
            field=models.DateTimeField( verbose_name='\u521b\u5efa\u65f6\u95f4', auto_now_add=True),
            preserve_default=False,
        ),
    ]
