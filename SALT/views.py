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

############################################### 基本配置
#命令管理
@login_required
def command(request):
    module_id = request.GET.get('module_id')
    module_name = request.GET.get('module_name')
    client = request.GET.get('client')
    cmd = request.GET.get('cmd')
    active = request.GET.get('active')
    context={}
    #命令收集
    if active=='collect':
        try:
            salt_server=SaltServer.objects.all()[0]
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            funs=['doc.runner','doc.wheel','doc.execution']
            for fun in funs:
                result = sapi.SaltRun(fun=fun,client='runner')
                cs=result['return'][0]
                for c in cs:
                    Module.objects.get_or_create(client=fun.split('.')[1],name=c.split('.')[0])
                    module=Module.objects.get(client=fun.split('.')[1],name=c.split('.')[0])
                    Command.objects.get_or_create(cmd=c,module=module)
                    command=Command.objects.get(cmd=c,module=module)
                    if not command.doc:
                        command.doc=cs[c]
                        command.save()
            context['success']=u'命令收集完成！'
        except Exception as error:
            context['error']=error


    cmd_list=Command.objects.order_by('cmd')
    module_list=Module.objects.order_by('client','name')
    #按模块过滤
    if  request.method=='GET' and module_id:
            cmd_list = cmd_list.filter(module=module_id)

    if request.is_ajax() and client:
        if re.search('runner',client):
            client='runner'
        elif re.search('wheel',client):
            client='wheel'
        else:
            client='execution'
    #命令帮助信息
        if cmd:
            try:
                command=Command.objects.get(cmd=cmd,module__client=client)
                doc=command.doc.replace("\n","<br>").replace(" ","&nbsp;")
            except Exception as error:
                doc=str(error)
            return JsonResponse(doc,safe=False)
    #请求模块下的命令
        elif module_name:
            cmd_list = cmd_list.filter(module__client=client,module__name=module_name).order_by('-cmd')
            cmd_list = [cmd.cmd for cmd in cmd_list]
            return JsonResponse(cmd_list,safe=False)
    #请求CLIENT下的模块
        else:
            module_list=module_list.filter(client=client)
            module_list=[module.name for module in module_list.order_by('-name')]
            return JsonResponse(module_list,safe=False)

    context['cmd_list']=cmd_list
    context['module_list']=module_list
    return render(request, 'SALT/command.html', context)
#接口管理
@login_required
def server(request):
    server_list=SaltServer.objects.order_by('idc')
    return render(request, 'SALT/server.html', locals())
#Salt配置
@login_required
def config(request,server_id):
    server_list=SaltServer.objects.all()
    salt_server = SaltServer.objects.get(id=server_id)
    context={'server_list':server_list,'salt_server':salt_server}
    try:
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        # result=sapi.SaltRun(client='wheel',fun='config.values')
        # configs=result['return'][0]['data']['return']
        context['envs']=sorted(sapi.SaltRun(client='runner',fun='fileserver.envs')['return'][0])
        # context['envs']=sorted(configs['file_roots'].keys())
    except Exception as e:
        context['error']=str(e)
    return render(request,'SALT/config.html',context)

@login_required
def config_fun(request,server_id):
    if request.is_ajax() and request.method=='GET':
        env=request.GET.get('env')
        file=request.GET.get('file')
        content=request.GET.get('content')

        try:
            salt_server = SaltServer.objects.get(id=server_id)
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            result=sapi.SaltRun(client='wheel',fun='config.values')
            configs=result['return'][0]['data']['return']

            if env:
                if file:
                    if content:#写入文件内容，文件会产生[noeol]问题，因此需要在内容最后加个结束符\n
                        r=sapi.SaltRun(client='wheel',fun='file_roots.write',path=file,data=content+'\n',saltenv=env)
                        # r=sapi.SaltRun(client='wheel',fun='config.update_config',file_name='test',yaml_contents='{a:1}')
                        success=r['return'][0]['data']['success']
                        if success:
                            result=u"文件%s保存成功！"%file
                        else:
                            result=u"文件%s保存失败！"%file
                    else:#读取环境下文件内容
                        path=configs['file_roots'][env][0]+file #每个环境最好只定义一个目录
                        r=sapi.SaltRun(client='wheel',fun='file_roots.read',path=path,saltenv=env)
                        result=r['return'][0]['data']['return']
                        if isinstance(result,str):
                            result={'Error':result}
                        else:
                            result=result[0]
                else:#列出环境下的文件
                    result=sapi.SaltRun(client='runner',fun='fileserver.file_list',saltenv=env)['return'][0] #.svn .git已在files.conf配置中过滤
        except Exception as e:
            result={'Error':str(e)}
        return JsonResponse(result,safe=False)
############################################### 客户端管理
#客户端管理（KEY）
@login_required
def minions(request,server_id):
    server_list=SaltServer.objects.all()
    try:
        salt_server = SaltServer.objects.get(id=server_id)
    except:#id不存在时返回第一个
        salt_server = SaltServer.objects.all()[0]
    context={'server_list':server_list,'salt_server':salt_server}

    try:
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        #对所有key刷新minions表数据
        a,d,u,r=sapi.ListKey()
        if a:
            for m in a:
                collect(salt_server.id,m,'Accepted')
        if d:
            for m in d:
                collect(salt_server.id,m,'Denied')
        if u:
            for m in u:
                collect(salt_server.id,m,'Unaccepted')
        if r:
            for m in r:
                collect(salt_server.id,m,'Rejected')
        #minion不存在对应的key时设为未知
        keys=[]
        for s in [a,d,u,r]:
            for m in s:
                keys.append(m)
        minion_list=Minions.objects.filter(salt_server=salt_server)
        ms=[]
        for m in minion_list:
            if m.minion not in keys:
                m.status='Unknown'
                m.save()
            grains=json.loads(m.grains)
            grains['ipv4'].remove('127.0.0.1')
            obj={'id':m.id,'minion':m.minion,'ip':grains['ipv4'],'os':grains['os'],'status':m.status}
            ms.append(obj)
        context['minion_list']=ms
    except Exception as error:
        context['error']=error
        # print error
    return render(request,'SALT/minions.html',context)
#客户端KEY接收、删除、显示信息
@login_required
def minions_fun(request):
    id=request.GET.get('id','')
    active=request.GET.get('active','')
    if request.is_ajax() and id and active:
        try:
            minion=Minions.objects.get(id=id)
            salt_server = SaltServer.objects.get(id=minion.salt_server.id)
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            if id:
                if active == 'delete':
                    success=sapi.DeleteKey(minion)
                    if success:
                        minion.status='Unknown'
                        minion.save()
                        result=u'KEY"%s"删除成功！'%minion.minion
                    else:
                        result=u'KEY"%s"删除失败！'%minion.minion
                elif active == 'accept':
                    success=sapi.AcceptKey(minion)
                    if success:
                        collect(salt_server.id,minion.minion,'Accepted')
                        result=u'KEY"%s"接受成功！'%minion.minion
                    else:
                        result=u'KEY"%s"接受失败！'%minion.minion
                elif active == 'grains':
                    result=json.loads(minion.grains)
                elif active == 'pillar':
                    result=json.loads(minion.pillar)
        except Exception as e:
            result=str(e)
        return JsonResponse(result,safe=False)
#客户端信息收集
def collect(server_id,minion ,status='Unknown'):
    try:
        salt_server = SaltServer.objects.get(id=server_id)
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        Minions.objects.get_or_create(minion=minion,salt_server=salt_server)
        Minion=Minions.objects.get(minion=minion,salt_server=salt_server)

        if status=='Accepted':
            grains=sapi.SaltMinions(minion)['return'][0][minion]
            pillar=sapi.SaltCmd(tgt=minion,fun='pillar.items',client='local')['return'][0][minion]
            Minion.grains=json.dumps(grains)
            Minion.pillar=json.dumps(pillar)
        Minion.status=status
        Minion.save()
        result=True
    except Exception as e:
        result=str(e)
    return  result
################################################ 命令操作
#命令执行
@login_required
def execute(request,server_id):
    module_list=Module.objects.filter(client='execution').order_by('name')
    server_list=SaltServer.objects.all()
    try:
        salt_server = SaltServer.objects.get(id=server_id)
    except:#id不存在时返回第一个
        salt_server = SaltServer.objects.all()[0]
    minion_list=Minions.objects.filter(status='Accepted',salt_server=salt_server)
    context={'server_list':server_list,'salt_server':salt_server,'module_list':module_list,'minion_list':minion_list}

    # try:
    #     sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
    #     result=sapi.SaltRun(client='runner',fun='manage.status')
    #     context['minions_up']=result['return'][0]['up']
    #     context['minions_down']=result['return'][0]['down']
    # except Exception as error:
    #     context['error']=error
    return render(request,'SALT/execute.html',context)
@login_required
def execute_fun(request,server_id):
    if request.is_ajax() and request.method == 'GET':
        id = request.GET.get('id')
        client = request.GET.get('client')
        tgt_type = request.GET.get('tgt_type')
        tgt  = request.GET.get('tgt','')
        fun = request.GET.get('fun')
        arg = request.GET.get('arg','')
        user  = request.user.username
        if id:
            r=Result.objects.get(id=id)
            result = json.loads(r.result) #result.html默认从数据库中读取
        else:
            try:
                salt_server = SaltServer.objects.get(id=server_id)
                sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
                if re.search('runner',client) or re.search('wheel',client):
                    r=sapi.SaltRun(client=client,fun=fun,arg=arg)
                else:
                    r = sapi.SaltCmd(client=client,tgt=tgt,fun=fun,arg=arg,expr_form=tgt_type)
                if re.search('async',client):
                    jid = r['return'][0]['jid']
                    result=jid #异步命令只返回JID，之后JS会调用jid_info
                    # minions = ','.join(result['return'][0]['minions'])
                    Res=Result(client=client,jid=jid,minions=tgt,fun=fun,arg=arg,tgt_type=tgt_type,server=salt_server,user=user)
                    Res.save()
                else:
                    result=r['return'][0]#同步命令直接返回结果
                    Res=Result(client=client,minions=tgt,fun=fun,arg=arg,tgt_type=tgt_type,server=salt_server,user=user,result=json.dumps(result))
                    Res.save()
                # res=model_to_dict(r,exclude='result')
            except Exception as e:
                result={'Error': str(e)}

        return JsonResponse(result,safe=False)
#执行结果
@login_required
def result(request):
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
                sapi = SaltAPI(url=r.server.url,username=r.server.username,password=r.server.password)
                jid_info=sapi.SaltJob(jid)
                result = jid_info['info'][0]['Result']
                r.result=json.dumps(result)
                r.save()
        except Exception as e:
            result={'error':str(e)}
        return JsonResponse(result,safe=False)
