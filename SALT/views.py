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
from SaltAPI import SaltAPI
import json
from django.forms.models import model_to_dict
import re

#获取命令
@login_required
def command(request):
    cmd_list=Command.objects.order_by('cmd')
    module_id = request.GET.get('module_id')
    if request.is_ajax() and module_id:  #按模块ID过滤
        cmd_list = cmd_list.filter(module=module_id).order_by('cmd')
        cmd_list = [cmd.cmd for cmd in cmd_list]
        return JsonResponse(cmd_list,safe=False)

#接口列表
@login_required
def server(request):
    server_list=SaltServer.objects.order_by('idc')
    return render(request, 'SALT/server.html', locals())
#执行命令页面
@login_required
def cmd_run(request):
    system_list = SystemType.objects.order_by('name')
    server_list = Server.objects.order_by('name')
    idc_list = IDC.objects.order_by('name')
    group_list = HostGroup.objects.order_by('name')
    module_list=Module.objects.order_by('name')
    tgt_type_list=TargetType.objects.order_by('name')
    return render(request, 'SALT/cmd_run.html.bak', locals())
#目标过滤
@login_required
def target(request):
    if request.is_ajax():
        if request.method == 'GET':
            tgt=request.GET.get('tgt','')
            idc_id=request.GET.get('idc_id','')
            system_id = request.GET.get('system_id','')
            group_id = request.GET.get('group_id','')
            # print(idc_id,system_id,group_id,hostname)
            host_list = HostDetail.objects.filter(salt_status=True).order_by('tgt_id')
            if tgt:
                if idc_id:
                    if system_id:
                        if group_id:
                            host_list = host_list.filter(tgt_id__icontains=tgt,host__server__idc=idc_id,host__system_type=system_id,host__group=group_id)
                        else:
                            host_list = host_list.filter(tgt_id__icontains=tgt,host__server__idc=idc_id,host__system_type=system_id)
                    elif group_id:
                        host_list = host_list.filter(tgt_id__icontains=tgt,host__server__idc=idc_id,host__group=group_id)
                    else:
                        host_list = host_list.filter(tgt_id__icontains=tgt,host__server__idc=idc_id)
                elif system_id:
                     if group_id:
                         host_list = host_list.filter(tgt_id__icontains=tgt,host__system_type=system_id,host__group=group_id)
                     else:
                         host_list = host_list.filter(tgt_id__icontains=tgt,host__system_type=system_id)
                elif group_id:
                    host_list = host_list.filter(tgt_id__icontains=tgt,host__group=group_id)
                else:
                    host_list = host_list.filter(tgt_id__icontains=tgt)
            elif idc_id:
                if system_id:
                    if group_id:
                        host_list = host_list.filter(host__server__idc=idc_id,host__system_type=system_id,host__group=group_id)
                    else:
                        host_list = host_list.filter(host__server__idc=idc_id,host__system_type=system_id)
                elif group_id:
                    host_list = host_list.filter(host__server__idc=idc_id,host__group=group_id)
                else:
                    host_list = host_list.filter(host__server__idc=idc_id)
            elif system_id:
                 if group_id:
                     host_list = host_list.filter(host__system_type=system_id,host__group=group_id)
                 else:
                     host_list = host_list.filter(host__system_type=system_id)
            elif group_id:
                host_list = host_list.filter(host__group=group_id)

            # print host_list
            host_list = [host.tgt_id for host in host_list]
            return JsonResponse(host_list,safe=False)
#命令结果
@login_required
def result(request):
    if request.is_ajax():
        if request.method == 'GET':
            id = request.GET.get('id')
            idc = request.GET.get('idc')
            client = request.GET.get('client')
            tgt_type = request.GET.get('tgt_type')
            tgt  = request.GET.get('tgt','')
            fun = request.GET.get('fun')
            arg = request.GET.get('arg','')
            user  = request.user.username
            if id:
                r=Result.objects.get(id=id)
                result = json.loads(r.result) #result.html默认从数据库中读取
                return JsonResponse(result,safe=False)

            try:
                salt_server = SaltServer.objects.get(idc=idc,role='Master') #根据机房ID选择对应salt服务端
                sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
                if re.search('runner',client) or re.search('wheel',client):
                    result=sapi.SaltRun(client=client,fun=fun,arg=arg)
                else:
                    result = sapi.SaltCmd(client=client,tgt=tgt,fun=fun,arg=arg,expr_form=tgt_type)

                if re.search('async',client):
                    jid = result['return'][0]['jid']
                    # minions = ','.join(result['return'][0]['minions'])
                    r=Result(client=client,jid=jid,minions=tgt,fun=fun,arg=arg,tgt_type=tgt_type,idc_id=idc,user=user)
                    res=r.jid #异步命令只返回JID，之后JS会调用jid_info
                else:
                    res=result['return'][0]#同步命令直接返回结果
                    r=Result(client=client,minions=tgt,fun=fun,arg=arg,tgt_type=tgt_type,idc_id=idc,user=user,result=json.dumps(res))
                r.save()
                # res=model_to_dict(r,exclude='result')
                return JsonResponse(res,safe=False)
            except Exception as error:
                return JsonResponse({'Error':"%s"%error},safe=False)

    else:
        idc_list= IDC.objects.all()
        result_list = Result.objects.order_by('-id')
        return render(request, 'SALT/result.html', locals())
#任务信息
@login_required
def jid_info(request):
    jid = request.GET.get('jid','')
    if jid:
        try:
            r = Result.objects.get(jid=jid)
            if r.result and r.result!='{}' :
                result = json.loads(r.result) #cmd_result.html默认从数据库中读取
            else:
                idc = r.idc_id
                salt_server = SaltServer.objects.get(idc=idc,role='Master')
                sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
                jid_info=sapi.SaltJob(jid)
                result = jid_info['info'][0]['Result']
                r.result=json.dumps(result)
                r.save()
            return JsonResponse(result,safe=False)
        except Exception as error:
            return JsonResponse({'error':error},safe=False)
#命令帮助信息
@login_required
def cmd_doc(request):
    salt_server = SaltServer.objects.all()[0] #选择salt接口中的第一个
    cmd_list = Command.objects.filter(doc='') #只对未获取帮助信息的命令操作
    sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
    for cmd in cmd_list:
        result = sapi.SaltCmd(client='local',tgt='*',fun='sys.doc',arg=cmd.cmd) #使用local直接返回结果，不需要异步
        print result
#{u'return': [{u'saltminion01-41.ewp.com': {u'cmd.script': u'\n    Download a script from a remote location and execute the script locally.\n  ...
        try:
            cmd.doc=result['return'][0].values()[0][cmd.cmd]
        #.replace(" ","&nbsp;")
        except:
            cmd.doc=u"这个命令没有帮助信息，请点击模块查看官方网站信息!"
        cmd.save()
    return HttpResponseRedirect(reverse('salt:command'))
#认证KEY管理
@login_required
def keys(request):
    idc_list = IDC.objects.order_by('name')
    idc=request.GET.get('idc',idc_list[0].id)
    key=request.GET.get('key','')
    active=request.GET.get('active','')
    context={'idc_list':idc_list,'idc':long(idc)}
    try:
        salt_server = SaltServer.objects.get(idc=idc,role='Master')
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        if key:
            if active == 'del':
                success=sapi.DeleteKey(key)
                if success:
                    context['success']=u'KEY"%s"删除成功！'%key
                else:
                    context['success']=u'KEY"%s"删除失败！'%key
            if active == 'accept':
                success=sapi.AcceptKey(key)
                if success:
                    context['success']=u'KEY"%s"接受成功！'%key
                else:
                    context['success']=u'KEY"%s"接受失败！'%key
        minions,minions_pre=sapi.ListKey()
        context['minions']=minions
        context['minions_pre']=minions_pre
    except Exception as error:
        context['error']=error
    print context
    return render(request,'SALT/keys.html',context)

@login_required
def minions(request):
    idc_list = IDC.objects.order_by('name')
    idc=request.GET.get('idc',idc_list[0].id)
    key=request.GET.get('key','')
    active=request.GET.get('active','')
    context={'idc_list':idc_list,'idc':long(idc)}
    try:
        salt_server = SaltServer.objects.get(ip__server__idc=idc,role='M')
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)

        minions=sapi.SaltRun(fun='manage.status')
        print minions
        context['minions_up']=minions['return'][0]['up']
        context['minions_down']=minions['return'][0]['down']
    except Exception as error:
        context['minions_up']=[]
        context['minions_down']=[]
        context['error']=error
    print context
    return render(request,'SALT/minions.html',context)
#命令执行页面
@login_required
def execute(request):
    idc_list = IDC.objects.order_by('name')
    module_list=Module.objects.order_by('name')
    idc=request.GET.get('idc',idc_list[0].id)
    context={'idc_list':idc_list,'module_list':module_list,'idc':long(idc)}
    try:
        salt_server = SaltServer.objects.get(idc=idc,role='Master')
        context['salt_server']=salt_server
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        status=sapi.SaltRun(client='runner',fun='manage.status')
        context['minions_up']=status['return'][0]['up']
        context['minions_down']=status['return'][0]['down']
    except Exception as error:
        context['error']=error
    return render(request,'SALT/execute.html',context)

