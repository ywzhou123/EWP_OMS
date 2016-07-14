#encoding:utf-8
from django.conf.urls import url
from views import *

urlpatterns = [
    url(r'^host/$', host, name='host'),
    # url(r'^server/$', server, name='server'),
    # url(r'^config/(?P<server_id>[0-9]+)/$', config, name='config'),
    ]