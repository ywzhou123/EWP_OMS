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

#代码发布
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
        #刷新页面检测并更新项目状态
        for project in project_list:
            path=project.path+'/'+project.target
            svn_info=sapi.SaltCmd(client='local',tgt=project.host,fun='svn.info',arg=path,arg1='fmt=dict')['return'][0][project.host][0]
            if isinstance(svn_info,dict):
                if project.url == svn_info['URL']:
                    project.status=u"已发布"
                    project.info=u"最近修改时间：%s\n最近修改版本：%s\n最新版本：%s"%(svn_info["Last Changed Date"][0:20],svn_info["Last Changed Rev"],svn_info["Revision"])
                else:
                    project.status=u"冲突"
                    project.info=u"SVN路径不匹配：\n本地SVN为'%s'\n项目SVN为'%s'"%(svn_info['URL'],project.url)
                # project.save()
            else:
                #根路径不存在时创建
                if not sapi.SaltCmd(client='local',tgt=project.host,fun='file.directory_exists',arg=project.path)['return'][0][project.host]:
                    sapi.SaltCmd(client='local',tgt=project.host,fun='file.mkdir',arg=project.path)
                #目录未被版本控制，可能SVN未安装
                if not sapi.SaltCmd(client='local',tgt=project.host,fun='pkg.version',arg='subversion')['return'][0][project.host]:
                    sapi.SaltCmd(client='local',tgt=project.host,fun='pkg.install',arg='subversion')
                #签出项目、获取信息并存入库
                sapi.SaltCmd(client='local',tgt=project.host,fun='svn.checkout',arg=project.path,arg0='target=%s'%project.target,arg1='remote=%s'%project.url,arg2='username=%s'%project.username,arg3='password=%s'%project.password)
                project.info=sapi.SaltCmd(client='local',tgt=project.host,fun='svn.info',arg=path,arg1='fmt=dict')['return'][0][project.host][0]
                project.status=u"已发布"
            project.save()
    except Exception as error:
        context['error']=error


    return render(request,'SALT/deploy.html',context)
#SVN提交、更新
@login_required
def deploy_fun(request,server_id):
    print server_id
    #SVN功能按钮
    if request.is_ajax() and request.method == 'GET':
        tgt=request.GET.get('tgt','')
        path=request.GET.get('path','').encode("utf-8")
        active=request.GET.get('active','')
        project_id=request.GET.get('project_id','')

        try:
            salt_server = SaltServer.objects.get(id=server_id)
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            if project_id:
                project=SvnProject.objects.get(id=project_id)#指定项目
                path=project.path+'/'+project.target
                tgt=project.host
            else:
                project=None                                #项目不存在
                projects=SvnProject.objects.filter(host=tgt)
                for p in projects:
                    if path.startswith(p.path+'/'+p.target): #项目子目录
                        project=p
            #SvnProject里没有记录时自动创建，但密码需要在后台设置
            if not project:
                svn_info=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.info',arg=path,arg1='fmt=dict')['return'][0][tgt][0]
                if isinstance(svn_info,dict):
                    result = {'ret':False,'msg':u'SVN项目不存在，请在后台页面添加！','add':True}
                else:
                    result = {'ret':False,'msg':u'错误：%s'%svn_info}
            #提交
            elif active=='commit' or active=='update':
                status=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.status',arg=path)['return'][0][tgt]
                for s in status.split('\n'):
                    l=s.split(' ')
                    if l[0]=='?':
                        sapi.SaltCmd(client='local',tgt=tgt,fun='svn.add',arg=path,arg0=path+'/'+l[-1],arg2='username=%s'%project.username,arg3='password=%s'%project.password)
                    elif l[0]=='!':
                        sapi.SaltCmd(client='local',tgt=tgt,fun='svn.remove',arg=path,arg0=path+'/'+l[-1],arg2='username=%s'%project.username,arg3='password=%s'%project.password)
                ci=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.commit',arg=path,arg1='msg=commit from %s'%tgt,arg2='username=%s'%project.username,arg3='password=%s'%project.password)['return'][0][tgt]
                result = {'ret':True,'msg':u"提交成功！\n%s"%ci}
                #更新（先提交否则会冲突）
                if active=='update':
                    up=sapi.SaltCmd(client='local',tgt=tgt,fun='svn.update',arg=path,arg2='username=%s'%project.username,arg3='password=%s'%project.password)['return'][0][tgt]
                    result = {'ret':True,'msg':u"提交成功！\n%s\n更新成功！\n%s"%(ci,up)}
        except Exception as e:
            result = {'ret':False,'msg':u'错误：%s' % e}
        return JsonResponse(result,safe=False)
#应用部署
@login_required
def state(request,server_id):
    server_list=SaltServer.objects.all()
    try:
        salt_server = SaltServer.objects.get(id=server_id)
    except:#id不存在时返回第一个
        salt_server = SaltServer.objects.all()[0]

    minion_list=Minions.objects.filter(status="Accepted")
    context={'server_list':server_list,'salt_server':salt_server,'minion_list':minion_list}

    try:
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        context['envs']=sapi.SaltRun(client='runner',fun='fileserver.envs')['return'][0]
    except Exception as error:
        context['error']=error

    return render(request,'SALT/state.html',context)
@login_required
def state_fun(request,server_id):
    if request.is_ajax() and request.method == 'GET':
        tgt=request.GET.get('tgt','')
        env=request.GET.get('env','')
        state=request.GET.get('state','')
        states=[]
        try:
            salt_server = SaltServer.objects.get(id=server_id)
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            if env:
                if state and tgt:
                    arg=state.rstrip(',')
                    result=sapi.SaltCmd(client='local',tgt=tgt,fun='state.sls',arg=arg,arg1='saltenv=%s'%env,expr_form='list')['return'][0]
                    Res=State(client='local',minions=tgt,fun='state.sls',arg=arg,tgt_type='list',server=salt_server,user=request.user.username,result=json.dumps(result))
                    Res.save()
                else:
                    roots=sapi.SaltRun(client='wheel',fun='file_roots.list_roots')['return'][0]['data']['return']
                    dirs=roots[env][0]                #dirs={"/srv/salt/prod/":{}}
                    for root,dirs in dirs.items():   #root="/srv/salt/prod/"  dirs={"init":{"epel.sls":"f",}}
                        for dir,files in dirs.items():         #dir='init' or 'top.sls'    files={"epel.sls":"f",}
                            if  dir == '.svn' :pass
                            elif files == "f" and dir.endswith('.sls'):
                                states.append(dir[0:-4])
                            elif isinstance(files,dict):
                                for sls,f in files.items():
                                    if f=='f' and sls.endswith('.sls'):
                                        states.append('%s.%s'%(dir,sls[0:-4]))
                    result=sorted(states)
        except Exception as e:
            result = str(e)
        return JsonResponse(result,safe=False)

#部署记录
@login_required
def state_history(request):
    if request.is_ajax() and request.method == 'GET':
        id = request.GET.get('id')
        if id:
            r=State.objects.get(id=id)
            result = json.loads(r.result) #result.html默认从数据库中读取
            return JsonResponse(result,safe=False)
    else:
        result_list = State.objects.order_by('-id')

    return render(request, 'SALT/state_history.html', locals())