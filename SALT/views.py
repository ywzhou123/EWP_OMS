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

#接口列表
@login_required
def server(request):
    server_list=SaltServer.objects.order_by('idc')
    return render(request, 'SALT/server.html', locals())
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
    module_list=Module.objects.filter(client='execution').order_by('name')
    idc=request.GET.get('idc',idc_list[0].id)
    context={'idc_list':idc_list,'module_list':module_list,'idc':long(idc)}
    try:
        salt_server = SaltServer.objects.get(idc=idc,role='Master')
        context['salt_server']=salt_server
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        result=sapi.SaltRun(client='runner',fun='manage.status')
        context['minions_up']=result['return'][0]['up']
        context['minions_down']=result['return'][0]['down']
    except Exception as error:
        context['error']=error
    return render(request,'SALT/execute.html',context)
@login_required
def config(request,server_id):
    server_list=SaltServer.objects.all()
    salt_server = SaltServer.objects.get(id=server_id)
    context={'server_list':server_list,'salt_server':salt_server}
    sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
    result=sapi.SaltRun(client='wheel',fun='config.values')
    configs=result['return'][0]['data']['return']
    context['envs']=sorted(configs['file_roots'].keys())
    # context['envs']=sapi.SaltRun(client='runner',fun='fileserver.envs')['return'][0]
    if request.is_ajax() :
        env=request.GET.get('env')
        file=request.GET.get('file')
        content=request.GET.get('content')
        if env:
            if file:
                if content:#写入文件内容，文件会产生[noeol]问题，因此需要在内容最后加个结束符\n
                    try:
                        r=sapi.SaltRun(client='wheel',fun='file_roots.write',path=file,data=content+'\n',saltenv=env)
                        # r=sapi.SaltRun(client='wheel',fun='config.update_config',file_name='test',yaml_contents='{a:1}')
                        success=r['return'][0]['data']['success']
                        if success:
                            res=u"文件%s保存成功！"%file
                        else:
                            res=u"文件%s保存失败！"%file
                    except Exception as error:
                        res=str(error)
                else:#读取环境下文件内容
                    try:
                        path=configs['file_roots'][env][0]+file #每个环境最好只定义一个目录
                        r=sapi.SaltRun(client='wheel',fun='file_roots.read',path=path,saltenv=env)
                        res=r['return'][0]['data']['return']
                        if isinstance(res,str):
                            res={'Error':res}
                        else:
                            res=res[0]
                    except Exception as error:
                        res={'Error':str(error)}
            else:#列出环境下的文件
                try:
<<<<<<< HEAD
                    res=sapi.SaltRun(client='runner',fun='fileserver.file_list',saltenv=env)['return'][0]
                    # res=[]
                    # for f in fs:
                    #     if not re.search('.svn',f) and not re.search('pki/',f):
                    #         res.append(f)
=======
                    res=sapi.SaltRun(client='runner',fun='fileserver.file_list',saltenv=env)['return'][0] #.svn .git已在files.conf配置中过滤
>>>>>>> dev
                except Exception as error:
                    res=[str(error)]
        else:
            res=None
        return JsonResponse(res,safe=False)

    else:
        return render(request,'SALT/config.html',context)

#SVN项目代码发布
@login_required
def deploy(request,server_id):
    server_list=SaltServer.objects.all()
    try:
        salt_server = SaltServer.objects.get(id=server_id)
    except:#id不存在时返回第一个
        salt_server = SaltServer.objects.all()[0]
    project_list=SvnProject.objects.filter(salt_server=salt_server).order_by('host')
    context={'server_list':server_list,'salt_server':salt_server,'project_list':project_list}

    try:
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        result=sapi.SaltRun(client='runner',fun='manage.status')
        context['minions_up']=result['return'][0]['up']
    except Exception as error:
        context['error']=error
    #针对SVN功能按钮
    if request.is_ajax() and request.method == 'GET':
        path=request.GET.get('path').encode("utf-8")
        tgt=request.GET.get('tgt')
        url=request.GET.get('url')
        username=request.GET.get('username')
        password=request.GET.get('password')
        active=request.GET.get('active')

        if tgt and path:
            try:
                projects=SvnProject.objects.filter(host=tgt)
                project=None
                for p in projects:
                    if path.startswith(p.path):
                        project=p

                salt_server = SaltServer.objects.get(id=server_id)
                sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
                #签出
                if url and username and password:


                    if project:
                        project.info=1
                        project.status=u"已发布"
                        project.save()
                        result = {'ret':0,'msg':u"此项目路径或其父路径已存在于'%s'，状态为'%s'"%(project,project.status)}
                    else:
                        r=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.checkout',arg=path,arg1='remote=%s'%url,arg2='username=%s'%username,arg3='password=%s'%password)['return'][0][tgt]
                        result = {'ret':1,'msg':r}
                        svn_info=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.info',arg=path)['return'][0][tgt][0]
                        SvnProject.objects.get_or_create(salt_server=salt_server,host=tgt,path=path,url=url,username=username,password=password,status=u"已发布",info=svn_info)
                #提交
                elif active=='commit'and project:
                    r=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.commit',arg=path,arg1='msg=commit from %s'%tgt,arg2='username=%s'%project.username,arg3='password=%s'%project.password)['return'][0][tgt]
                    result = {'ret':0,'msg':r}
                #更新（先提交否则会冲突）
                elif active=='update' and project:
                    r1=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.commit',arg=path,arg1='msg=commit from %s'%tgt,arg2='username=%s'%project.username,arg3='password=%s'%project.password)['return'][0][tgt]
                    r2=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.update',arg=path,arg2='username=%s'%project.username,arg3='password=%s'%project.password)['return'][0][tgt]
                    result = {'ret':1,'msg':r1+r2}
                #SvnProject里没有记录时自动创建，但密码需要在后台设置
                elif  not project:
                    svn_info=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.info',arg=path,arg1='fmt=dict')['return'][0][tgt][0]
                    if isinstance(svn_info,dict):
                        SvnProject.objects.get_or_create(host=tgt,path=path,url=svn_info['URL'],username=svn_info["Last Changed Author"],password='enter your password',status=u"请设置密码")
                        result = {'ret':0,'msg':u'SVN项目不存在，现已新建，请在后台页面设置SVN密码！'}
                    else:
                        result = {'ret':0,'msg':u'错误：%s'%svn_info}
            except Exception as e:
                result = {'ret':0,'msg':u'错误：%s' % e}
            return JsonResponse(result,safe=False)

    return render(request,'SALT/deploy.html',context)


