#encoding:utf-8
from django.conf.urls import url
from views import *

urlpatterns = [
    url(r'^idc/$', idc, name='idc'),
    url(r'^server/$', server, name='server'),
    url(r'^system/$', system, name='system'),
    url(r'^host/$', host, name='host'),
    url(r'^detail/(?P<ip>[0-9.]+)/$', detail, name='detail'),
    url(r'^network/$', network, name='network'),
    url(r'^initialize/(?P<host_id>\d+)/$', initialize, name='initialize'),
    url(r'^collect/(?P<host_id>\d+)/$', collect, name='collect'),
    # url(r'^account/(?P<device>.+)/(?P<id>[0-9].+)/$', account, name='account'),

]