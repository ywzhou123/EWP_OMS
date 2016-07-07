#encoding:utf-8
from django.conf.urls import url
from views import *
from file_local import *
from file_remote import *
from deploy import *
from django.conf import settings

urlpatterns = [
    #基本配置
    url(r'^command/$', command, name='command'),
    url(r'^server/$', server, name='server'),
    url(r'^config/(?P<server_id>[0-9]+)/$', config, name='config'),
    url(r'^config_fun/(?P<server_id>[0-9]+)/$', config_fun, name='config_fun'),
    #客户端管理
    url(r'^minions/(?P<server_id>[0-9]+)/$', minions, name='minions'),
    url(r'^minions_fun/$', minions_fun, name='minions_fun'),
    #命令操作
    url(r'^execute/(?P<server_id>[0-9]+)/$', execute, name='execute'),
    url(r'^execute_fun/(?P<server_id>[0-9]+)/$', execute_fun, name='execute_fun'),
    url(r'^result/$', result, name='result'),
    url(r'^jid_info/$', jid_info, name='jid_info'),
    #本地文件管理
    url(r'^file_local/$', file_local, name='file_local'),
    url(r'^file_create/$', file_create, name='file_create'),
    url(r'^file_rename/$', file_rename, name='file_rename'),
    url(r'^file_write/$', file_write, name='file_write'),
    url(r'^file_delete/$', file_delete, name='file_delete'),
    url(r'^file_upload/$', file_upload, name='file_upload'),
    url(r'^svn/$', svn, name='svn'),
    #远程文件管理
    url(r'^file_remote/(?P<server_id>[0-9]+)/$', file_remote, name='file_remote'),
    url(r'^file_remote_create/$', file_remote_create, name='file_remote_create'),
    url(r'^file_remote_rename/$', file_remote_rename, name='file_remote_rename'),
    url(r'^file_remote_write/$', file_remote_write, name='file_remote_write'),
    url(r'^file_remote_delete/$', file_remote_delete, name='file_remote_delete'),
    #发布管理
    url(r'^deploy/(?P<server_id>[0-9]+)/$', deploy, name='deploy'),
    url(r'^deploy_fun/(?P<server_id>[0-9]+)/$', deploy_fun, name='deploy_fun'),
    url(r'^state/(?P<server_id>[0-9]+)/$', state, name='state'),
    url(r'^state_fun/(?P<server_id>[0-9]+)/$', state_fun, name='state_fun'),
    url(r'^state_history/$', state_history, name='state_history'),
    #文件下载
    url(r'^media/(?P<path>.*)$','django.views.static.serve',{'document_root': settings.MEDIA_ROOT}),
    ]