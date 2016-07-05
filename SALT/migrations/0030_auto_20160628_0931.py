# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('SALT', '0029_auto_20160627_0915'),
    ]

    operations = [
        migrations.CreateModel(
            name='Minions',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('minion', models.CharField(max_length=50, verbose_name='\u5ba2\u6237\u7aef')),
                ('grains', models.TextField(max_length=500, verbose_name='Grains\u4fe1\u606f', blank=True)),
                ('pillar', models.TextField(max_length=500, verbose_name='Pillar\u4fe1\u606f', blank=True)),
                ('status', models.CharField(default=b'Unknown', max_length=20, verbose_name='\u5728\u7ebf\u72b6\u6001', choices=[(b'Unknown', b'Unknown'), (b'Accepted', b'Accepted'), (b'Denied', b'Denied'), (b'Unaccepted', b'Unaccepted'), (b'Rejected', b'Rejected')])),
                ('salt_server', models.ForeignKey(verbose_name='\u6240\u5c5eSalt\u670d\u52a1\u5668', to='SALT.SaltServer')),
            ],
            options={
                'verbose_name': 'Salt\u5ba2\u6237\u7aef',
                'verbose_name_plural': 'Salt\u5ba2\u6237\u7aef\u5217\u8868',
            },
        ),
        migrations.AlterField(
            model_name='svnproject',
            name='info',
            field=models.TextField(max_length=500, verbose_name='\u4fe1\u606f', blank=True),
        ),
        migrations.AlterField(
            model_name='svnproject',
            name='salt_server',
            field=models.ForeignKey(verbose_name='\u6240\u5c5eSalt\u670d\u52a1\u5668', to='SALT.SaltServer'),
        ),
        migrations.AlterField(
            model_name='svnproject',
            name='status',
            field=models.CharField(default='\u65b0\u5efa', max_length=40, verbose_name='\u72b6\u6001'),
        ),
        migrations.AlterUniqueTogether(
            name='minions',
            unique_together=set([('minion', 'salt_server')]),
        ),
    ]
