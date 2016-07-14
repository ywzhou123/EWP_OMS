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



@login_required
def host(request):
    graphid=request.GET.get('graphid','')
    try:
        zapi=ZabbixAPI()
        host_list=zapi.HostGet()
        if graphid:
            graph=zapi.GraphGet(graphid)[0]
    except Exception as e:
        error=str(e)
    return render(request, 'ZABBIX/host.html', locals())

