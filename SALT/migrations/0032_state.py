# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0031_auto_20160707_1026'),
    ]

    operations = [
        migrations.CreateModel(
            name='State',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('client', models.CharField(max_length=20, verbose_name='\u6267\u884c\u65b9\u5f0f', blank=True)),
                ('fun', models.CharField(max_length=50, verbose_name='\u547d\u4ee4')),
                ('arg', models.CharField(max_length=255, verbose_name='\u53c2\u6570', blank=True)),
                ('tgt_type', models.CharField(max_length=20, verbose_name='\u76ee\u6807\u7c7b\u578b')),
                ('jid', models.CharField(max_length=50, verbose_name='\u4efb\u52a1\u53f7', blank=True)),
                ('minions', models.CharField(max_length=500, verbose_name='\u76ee\u6807\u4e3b\u673a', blank=True)),
                ('result', models.TextField(verbose_name='\u8fd4\u56de\u7ed3\u679c', blank=True)),
                ('user', models.CharField(max_length=50, verbose_name='\u64cd\u4f5c\u7528\u6237')),
                ('datetime', models.DateTimeField(auto_now_add=True, verbose_name='\u6267\u884c\u65f6\u95f4')),
                ('server', models.ForeignKey(verbose_name='\u6240\u5c5eSalt\u670d\u52a1\u5668', to='SALT.SaltServer')),
            ],
            options={
                'verbose_name': '\u90e8\u7f72\u7ed3\u679c',
                'verbose_name_plural': '\u90e8\u7f72\u7ed3\u679c',
            },
        ),
    ]
