# -*- coding: utf-8 -*-
from django.shortcuts import  render,render_to_response,get_object_or_404
from django.http import HttpResponseRedirect,HttpResponse,JsonResponse
from django.core.urlresolvers import reverse
from django.contrib import auth
from django.contrib.auth.decorators import login_required  #setting: LOGIN_URL = '/auth/login/'
from django.shortcuts import redirect
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import  PasswordChangeForm
from models import *
from CMDB.models import *
from ZabbixAPI import ZabbixAPI
import json
from django.forms.models import model_to_dict
import re
# from pyzabbix import ZabbixAPI
import ConfigParser
import datetime
import time

@login_required
def host(request):
    try:
        zapi=ZabbixAPI()
        host_list=zapi.HostGet()
        group_list=zapi.HostGroupGet()
        template_list=zapi.TemplateGet()
    except Exception as e:
        error=str(e)
    return render(request, 'ZABBIX/host.html', locals())


@login_required
def host_create(request):
    name=request.GET.get('name','')
    ip=request.GET.get('ip','')
    groupid=request.GET.get('groupid','')
    templateid=request.GET.get('templateid','')

    try:
        zapi=ZabbixAPI()
        hostcreate=zapi.HostCreate(name,ip,groupid,templateid)
        if hostcreate['hostids']:
            result=u"主机%s创建成功，ID为%s."%(name,hostcreate['hostids'])
        else:
            result=u"主机%s创建失败."%(name)
    except Exception as e:
        result=str(e)
    return JsonResponse(result,safe=False)


@login_required
def template(request):
    return render(request, 'ZABBIX/template.html', locals())
@login_required
def item(request):
    cf = ConfigParser.ConfigParser()
    cf.read("EWP_OMS/config.ini")
    itemurl = cf.get("zabbix_server","itemurl")

    hostid=request.GET.get('hostid','')
    try:
        zapi=ZabbixAPI()
        host_list=zapi.HostGet()
        if hostid:
            item_list=zapi.ItemGet(hostid)
        else:
            item_list=zapi.ItemGet()
        #时间戳转化成日期格式
        for item in item_list:
            item['lastns']= time.strftime('%Y/%m/%d %H:%M', time.localtime(float(item['lastns'])))
    except Exception as e:
        error=str(e)
    return render(request, 'ZABBIX/item.html', locals())
@login_required
def graph(request):
    cf = ConfigParser.ConfigParser()
    cf.read("EWP_OMS/config.ini")
    graphurl = cf.get("zabbix_server","graphurl")

    hostid=request.GET.get('hostid','')
    try:
        zapi=ZabbixAPI()
        host_list=zapi.HostGet()
        if hostid:
            graph_list=zapi.GraphGet(hostid=hostid)
            print graph_list
        else:
            graph_list=zapi.GraphGet()
    except Exception as e:
        error=str(e)
    return render(request, 'ZABBIX/graph.html', locals())
@login_required
def screen(request):
    return render(request, 'ZABBIX/screen.html', locals())
@login_required
def history(request):
    itemid=request.GET.get('itemid','')
    try:
        zapi=ZabbixAPI()
        if itemid:
            history=zapi.History(itemid)
            print history
    except Exception as e:
        error=str(e)
    return render(request, 'ZABBIX/history.html', locals())