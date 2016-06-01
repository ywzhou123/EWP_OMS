#encoding:utf-8
from django.conf.urls import url
from views import *

urlpatterns = [
    url(r'^$', index, name='index'),
    url(r'^login/$',  login,name='login'),
    url(r'^user/$', user,name='user'),
    url(r'^password/$',password,name='password'),
    url(r'^logout/$', logout,name='logout'),
]