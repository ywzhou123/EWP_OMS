#encoding:utf-8
from django.conf.urls import url
from views import *

urlpatterns = [
    url(r'^host/$', host, name='host'),
    url(r'^host_create/$', host_create, name='host_create'),
    url(r'^item/$', item, name='item'),
    url(r'^template/$', template, name='template'),
    url(r'^graph/$', graph, name='graph'),
    url(r'^history/$', history, name='history'),
    # url(r'^server/$', server, name='server'),
    # url(r'^config/(?P<server_id>[0-9]+)/$', config, name='config'),
    ]