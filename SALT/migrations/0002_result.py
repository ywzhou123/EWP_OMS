# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Result',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('arg', models.CharField(max_length=255, verbose_name='\u53c2\u6570', blank=True)),
                ('jid', models.CharField(unique=True, max_length=50, verbose_name='\u4efb\u52a1\u53f7')),
                ('minions', models.CharField(max_length=255, verbose_name='\u76ee\u6807\u4e3b\u673a')),
                ('user', models.CharField(max_length=50, verbose_name='\u64cd\u4f5c\u7528\u6237')),
                ('datetime', models.TimeField(verbose_name='\u6267\u884c\u65f6\u95f4')),
                ('client', models.ForeignKey(verbose_name='\u6267\u884c\u65b9\u5f0f', to='SALT.ClientType')),
                ('fun', models.ForeignKey(verbose_name='\u547d\u4ee4', to='SALT.Command')),
                ('salt_server', models.ForeignKey(verbose_name='Salt\u63a5\u53e3', to='SALT.SaltServer')),
                ('tgt_type', models.ForeignKey(verbose_name='\u76ee\u6807\u7c7b\u578b', to='SALT.TargetType')),
            ],
            options={
                'verbose_name': '\u547d\u4ee4\u8fd4\u56de\u7ed3\u679c',
                'verbose_name_plural': '\u547d\u4ee4\u8fd4\u56de\u7ed3\u679c',
            },
        ),
    ]
