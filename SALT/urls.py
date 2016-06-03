#encoding:utf-8
from django.conf.urls import url
from views import *
from file_local import *
from file_remote import *
from django.conf import settings

urlpatterns = [
    url(r'^target/$', target, name='target'),
    url(r'^command/$', command, name='command'),
    url(r'^server/$', server, name='server'),
    url(r'^keys/$', keys, name='keys'),
    url(r'^minions/$', minions, name='minions'),
    url(r'^execute/$', execute, name='execute'),
    url(r'^result/$', result, name='result'),
    # url(r'^cmd_result_detail/(?P<result_id>[0-9]+)/$', cmd_result_detail, name='cmd_result_detail'),
    url(r'^jid_info/$', jid_info, name='jid_info'),
    url(r'^file_local/$', file_local, name='file_local'),
    url(r'^file_create/$', file_create, name='file_create'),
    url(r'^file_rename/$', file_rename, name='file_rename'),
    url(r'^file_write/$', file_write, name='file_write'),
    url(r'^file_delete/$', file_delete, name='file_delete'),
    url(r'^file_upload/$', file_upload, name='file_upload'),
    url(r'^svn/$', svn, name='svn'),
    url(r'^file_remote/$', file_remote, name='file_remote'),
    url(r'^file_list/$', file_list, name='file_list'),
    url(r'^deploy/$', deploy, name='deploy'),


    # url(r'^file_download/(?P<file_name>.*)/$', file_download, name='file_download'),
    # url(r'^media/(?P<path>.*)$','django.views.static.serve',{'document_root': settings.MEDIA_ROOT}),
    url(r'^media/(?P<path>.*)$','django.views.static.serve',{'document_root': settings.MEDIA_ROOT}),
    # url(r'^command/(?P<module_id>[0-9]+)/$', command, name='command'),
    ]