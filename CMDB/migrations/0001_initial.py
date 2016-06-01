# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Host',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('start_date', models.DateField(verbose_name='\u542f\u7528\u65e5\u671f')),
                ('status', models.BooleanField(default=True, verbose_name='\u4f7f\u7528\u72b6\u6001')),
                ('username', models.CharField(max_length=20, verbose_name='\u7528\u6237\u540d', blank=True)),
                ('password', models.CharField(max_length=50, verbose_name='\u5bc6\u7801', blank=True)),
            ],
            options={
                'verbose_name': '\u4e3b\u673a',
                'verbose_name_plural': '\u4e3b\u673a\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='HostDetail',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('ip', models.GenericIPAddressField(unique=True, verbose_name='IP')),
                ('tgt_id', models.CharField(max_length=50, verbose_name='\u76ee\u6807ID', blank=True)),
                ('fqdn', models.CharField(max_length=50, verbose_name='\u8ba1\u7b97\u673a\u5168\u79f0', blank=True)),
                ('domain', models.CharField(max_length=50, verbose_name='\u57df\u540d', blank=True)),
                ('hwaddr_interfaces', models.CharField(max_length=50, verbose_name='MAC\u5730\u5740', blank=True)),
                ('cpu_model', models.CharField(max_length=50, verbose_name='CPU\u578b\u53f7', blank=True)),
                ('kernel', models.CharField(max_length=50, verbose_name='\u5185\u6838', blank=True)),
                ('os', models.CharField(max_length=50, verbose_name='\u64cd\u4f5c\u7cfb\u7edf', blank=True)),
                ('osarch', models.CharField(max_length=50, verbose_name='\u7cfb\u7edf\u67b6\u6784', blank=True)),
                ('osrelease', models.CharField(max_length=50, verbose_name='\u7cfb\u7edf\u7248\u672c', blank=True)),
                ('productname', models.CharField(max_length=50, verbose_name='\u4ea7\u54c1\u578b\u53f7', blank=True)),
                ('serialnumber', models.CharField(max_length=50, verbose_name='\u5e8f\u5217\u53f7', blank=True)),
                ('server_id', models.CharField(max_length=50, verbose_name='\u670d\u52a1\u5668ID', blank=True)),
                ('virtual', models.CharField(max_length=50, verbose_name='\u865a\u62df\u73af\u5883', blank=True)),
                ('salt_status', models.BooleanField(default=False, verbose_name='Salt\u72b6\u6001')),
                ('zbx_status', models.BooleanField(default=False, verbose_name='Zabbix\u72b6\u6001')),
            ],
            options={
                'verbose_name': '\u4e3b\u673a\u8be6\u7ec6\u4fe1\u606f',
                'verbose_name_plural': '\u4e3b\u673a\u8be6\u7ec6\u4fe1\u606f\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='HostGroup',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=30)),
            ],
            options={
                'verbose_name': '\u4e3b\u673a\u7ec4',
                'verbose_name_plural': '\u4e3b\u673a\u7ec4\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='IDC',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=50, verbose_name='\u673a\u623f\u540d\u79f0')),
                ('type', models.CharField(default=b'DX', max_length=20, verbose_name='\u673a\u623f\u7c7b\u578b', choices=[(b'DX', '\u7535\u4fe1'), (b'LT', '\u8054\u901a'), (b'YD', '\u79fb\u52a8'), (b'ZJ', '\u81ea\u5efa')])),
                ('address', models.CharField(max_length=100, verbose_name='\u673a\u623f\u5730\u5740', blank=True)),
                ('contact', models.CharField(max_length=100, verbose_name='\u8054\u7cfb\u65b9\u5f0f', blank=True)),
                ('start_date', models.DateField(null=True, verbose_name='\u79df\u8d41\u65e5\u671f', blank=True)),
                ('end_date', models.DateField(null=True, verbose_name='\u5230\u671f\u65e5\u671f', blank=True)),
                ('cost', models.CharField(max_length=20, verbose_name='\u79df\u8d41\u8d39\u7528', blank=True)),
            ],
            options={
                'verbose_name': '\u673a\u623f',
                'verbose_name_plural': '\u673a\u623f\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Network',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u540d\u79f0')),
                ('brand', models.CharField(max_length=30, verbose_name='\u54c1\u724c', blank=True)),
                ('model', models.CharField(max_length=30, verbose_name='\u578b\u53f7', blank=True)),
                ('ip_out', models.GenericIPAddressField(unique=True, null=True, verbose_name='\u5916\u7f51IP\u5730\u5740', blank=True)),
                ('ip_in', models.GenericIPAddressField(unique=True, null=True, verbose_name='\u5185\u7f51IP\u5730\u5740', blank=True)),
                ('info', models.CharField(max_length=100, verbose_name='\u8bf4\u660e', blank=True)),
                ('url', models.URLField(max_length=100, verbose_name='\u8bbf\u95ee\u5730\u5740', blank=True)),
                ('username', models.CharField(max_length=20, verbose_name='\u7528\u6237\u540d', blank=True)),
                ('password', models.CharField(max_length=50, verbose_name='\u5bc6\u7801', blank=True)),
                ('idc', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', to='CMDB.IDC')),
            ],
            options={
                'verbose_name': '\u7f51\u7edc\u8bbe\u5907',
                'verbose_name_plural': '\u7f51\u7edc\u8bbe\u5907\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='Server',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50, verbose_name='\u670d\u52a1\u5668\u540d\u79f0', blank=True)),
                ('location', models.CharField(max_length=30, verbose_name='\u673a\u67b6\u4f4d\u7f6e', blank=True)),
                ('start_date', models.DateField(verbose_name='\u542f\u7528\u65e5\u671f')),
                ('status', models.BooleanField(default=True, verbose_name='\u4f7f\u7528\u72b6\u6001')),
                ('idc', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', to='CMDB.IDC')),
                ('ip', models.OneToOneField(verbose_name='IP\u5730\u5740', to='CMDB.HostDetail')),
            ],
            options={
                'verbose_name': '\u670d\u52a1\u5668',
                'verbose_name_plural': '\u670d\u52a1\u5668\u5217\u8868',
            },
        ),
        migrations.CreateModel(
            name='SystemType',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(unique=True, max_length=30, verbose_name='\u7cfb\u7edf\u7c7b\u578b')),
            ],
            options={
                'verbose_name': '\u7cfb\u7edf\u7c7b\u578b',
                'verbose_name_plural': '\u7cfb\u7edf\u7c7b\u578b\u5217\u8868',
            },
        ),
        migrations.AddField(
            model_name='host',
            name='group',
            field=models.ManyToManyField(to='CMDB.HostGroup', verbose_name='\u6240\u5c5e\u4e3b\u673a\u7ec4', blank=True),
        ),
        migrations.AddField(
            model_name='host',
            name='ip',
            field=models.OneToOneField(verbose_name='IP\u5730\u5740', to='CMDB.HostDetail'),
        ),
        migrations.AddField(
            model_name='host',
            name='server',
            field=models.ForeignKey(verbose_name='\u6240\u5c5e\u670d\u52a1\u5668', to='CMDB.Server'),
        ),
        migrations.AddField(
            model_name='host',
            name='system_type',
            field=models.ForeignKey(verbose_name='\u64cd\u4f5c\u7cfb\u7edf\u7c7b\u578b', to='CMDB.SystemType'),
        ),
    ]
