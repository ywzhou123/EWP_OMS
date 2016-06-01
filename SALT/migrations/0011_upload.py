# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0010_auto_20160419_0943'),
    ]

    operations = [
        migrations.CreateModel(
            name='Upload',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('username', models.CharField(max_length=30, verbose_name='\u7528\u6237')),
                ('headImg', models.FileField(upload_to=b'./media/', verbose_name='\u6587\u4ef6\u8def\u5f84')),
                ('date', models.DateTimeField(auto_now_add=True, verbose_name='\u4e0a\u4f20\u65f6\u95f4')),
            ],
            options={
                'verbose_name': '\u6587\u4ef6\u4e0a\u4f20',
                'verbose_name_plural': '\u6587\u4ef6\u4e0a\u4f20',
            },
        ),
    ]
