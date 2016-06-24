# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0021_auto_20160602_1340'),
    ]

    operations = [
        migrations.CreateModel(
            name='SvnProject',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50, verbose_name='\u9879\u76ee\u540d\u79f0', blank=True)),
                ('host', models.CharField(max_length=50, verbose_name='\u9879\u76ee\u4e3b\u673a')),
                ('path', models.CharField(max_length=200, verbose_name='\u9879\u76ee\u8def\u5f84')),
                ('url', models.CharField(max_length=200, verbose_name='SVN\u5730\u5740')),
                ('username', models.CharField(max_length=40, verbose_name='SVN\u8d26\u53f7')),
                ('password', models.CharField(max_length=40, verbose_name='SVN\u5bc6\u7801')),
                ('info', models.CharField(max_length=100, verbose_name='\u5907\u6ce8\u4fe1\u606f', blank=True)),
            ],
            options={
                'verbose_name': 'SVN\u9879\u76ee',
                'verbose_name_plural': 'SVN\u9879\u76ee\u5217\u8868',
            },
        ),
        migrations.AlterField(
            model_name='module',
            name='client',
            field=models.CharField(default=b'execution', max_length=20, verbose_name='Salt\u6a21\u5757\u7c7b\u578b'),
        ),
        migrations.AlterField(
            model_name='module',
            name='name',
            field=models.CharField(max_length=20, verbose_name='Salt\u6a21\u5757\u540d\u79f0'),
        ),
    ]
