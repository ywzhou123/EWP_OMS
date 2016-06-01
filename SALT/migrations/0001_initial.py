# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CMDB', '0002_auto_20160413_1113'),
    ]

    operations = [
        migrations.CreateModel(
            name='ClientType',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=20, verbose_name='\u6267\u884c\u65b9\u5f0f')),
            ],
            options={
                'verbose_name': 'Salt\u6267\u884c\u65b9\u5f0f',
                'verbose_name_plural': 'Salt\u6267\u884c\u65b9\u5f0f\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Command',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('cmd', models.CharField(unique=True, max_length=40, verbose_name='Salt\u547d\u4ee4')),
                ('doc', models.TextField(max_length=500, verbose_name='\u5e2e\u52a9\u6587\u6863', blank=True)),
            ],
            options={
                'verbose_name': 'Salt\u547d\u4ee4',
                'verbose_name_plural': 'Salt\u547d\u4ee4\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Module',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=20, verbose_name='Salt\u6a21\u5757')),
                ('info', models.TextField(max_length=200, verbose_name='\u6a21\u5757\u8bf4\u660e')),
                ('url', models.URLField(verbose_name='\u5b98\u7f51\u94fe\u63a5', blank=True)),
            ],
            options={
                'verbose_name': 'Salt\u6a21\u5757',
                'verbose_name_plural': 'Salt\u6a21\u5757\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='SaltServer',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('url', models.URLField(max_length=100, verbose_name='URL\u5730\u5740')),
                ('username', models.CharField(max_length=50, verbose_name='\u7528\u6237\u540d')),
                ('password', models.CharField(max_length=50, verbose_name='\u5bc6\u7801')),
                ('ip', models.OneToOneField(verbose_name='\u6240\u5c5e\u4e3b\u673a', to='CMDB.Host')),
            ],
            options={
                'verbose_name': 'Salt\u670d\u52a1\u5668',
                'verbose_name_plural': 'Salt\u670d\u52a1\u5668\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='TargetType',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=20, verbose_name='\u76ee\u6807\u7c7b\u578b')),
            ],
            options={
                'verbose_name': 'Salt\u76ee\u6807\u7c7b\u578b',
                'verbose_name_plural': 'Salt\u76ee\u6807\u7c7b\u578b\u5217\u8868',
            },
        ),
        migrations.AddField(
            model_name='command',
            name='module',
            field=models.ForeignKey(verbose_name='\u6240\u5c5e\u6a21\u5757', to='SALT.Module'),
        ),
    ]
