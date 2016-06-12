# -*- coding: utf-8 -*-
from django.shortcuts import  render,render_to_response,get_object_or_404
from django.http import HttpResponseRedirect,HttpResponse,JsonResponse
from django.contrib.auth.decorators import login_required
from models import *
from CMDB.models import *
from SaltAPI import SaltAPI
from EWP_OMS.settings import *
import os

#文件管理页面
@login_required
def file_remote(request,server_id):
    server_list=SaltServer.objects.all()
    try:
        salt_server = SaltServer.objects.get(id=server_id)
    except:#id不存在时返回第一个
        salt_server = SaltServer.objects.all()[0]
    context={'server_list':server_list,'salt_server':salt_server}

    try:
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        result=sapi.SaltRun(client='runner',fun='manage.status')
        print result
        context['minions_up']=result['return'][0]['up']
    except Exception as error:
        context['error']=error
    return render(request,'SALT/file_remote.html',context)
#获取目录列表
@login_required
def file_remote_list(request):
    if request.is_ajax():
        if request.method == 'GET':
            tgt=request.GET.get('tgt')
            path=request.GET.get('path')
            server_id=request.GET.get('server_id')
            salt_server = SaltServer.objects.get(id=server_id)
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            #目录存在时返回目录列表
            try:
                isdir=sapi.SaltCmd(client='local',tgt=tgt,fun='file.directory_exists',arg=path)['return'][0][tgt]
                if isdir:
                    path_str=path.split('/')
                    if path_str[-1]=='..':#返回上层
                        if len(path_str)>3:
                            path='/'.join(path_str[0:-2])
                        else:
                            path='/'
                    dirs = sapi.SaltCmd(client='local',tgt=tgt,fun='file.readdir',arg=path)['return'][0][tgt]
                    try:dirs.remove('.').remove('.svn')
                    except:pass
                    if path=='/':
                        dirs.remove('..')
                    result = {'dirs':sorted(dirs) ,'type':'dir','pdir':path}
            except Exception as e:
                result = {'error':str(e)}
            else:
                #文件存在时，返回文件内容，加上文件格式、大小限制
                if os.path.splitext(path)[1] in FILE_FORMAT:
                    isfile=sapi.SaltCmd(client='local',tgt=tgt,fun='file.file_exists',arg=path)['return'][0][tgt]
                    if isfile:
                        stats=sapi.SaltCmd(client='local',tgt=tgt,fun='file.stats',arg=path)['return'][0][tgt]
                        if stats['size'] <= 1024000:
                            content=sapi.SaltCmd(client='local',tgt=tgt,fun='cmd.run',arg='cat '+path)['return'][0][tgt]
                            result = {'content':content,'type':'file','pdir':path,'stats':stats}
                        else:
                            result = {'error':u"文件大小超过1M，拒绝访问！"}
                else:
                    result = {'error':u"文件格式不允许访问，请检查setting.FILE_FORMAT！"}

            return JsonResponse(result,safe=False)
#创建目录或文件
@login_required
def file_remote_create(request):
    if request.is_ajax():
        if request.method == 'GET':
            master=request.GET.get('master')
            path=request.GET.get('path')
            file_type=request.GET.get('file_type')
            file_name=request.GET.get('file_name')
            # print master,path
            salt_server = SaltServer.objects.filter(ip__ip__tgt_id=master)[0]
            # print salt_server
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            #新建目录或文件
            if file_type == 'dir':
                create_name = (path+'/'+file_name).replace('//','/')
                try:
                    sapi.SaltCmd(client='local',tgt=master,fun='file.mkdir',arg=create_name)
                    result = u'目录"%s"创建成功！' % create_name
                except:
                    result = u'目录"%s"创建失败！' % create_name
            elif file_type == 'file':
                create_name = (path+'/'+file_name).replace('//','/')
                #创建文件，文件不存在时创建，存在则刷新创建时间，内容不变，目录不存在时返回false
                ret = sapi.SaltCmd(client='local',tgt=master,fun='file.touch',arg=create_name)['return'][0][master]
                if ret == True:
                    result = u'文件"%s"创建成功！' % create_name
                else:
                    result = ret
            else:
                result=u'目标类型错误！'
            return JsonResponse(result,safe=False)
#写入文件内容
@login_required
def file_remote_write(request):
    if request.is_ajax():
        if request.method == 'GET':
            minion=request.GET.get('minion')
            server=request.GET.get('server')
            path=request.GET.get('path')
            content=request.GET.get('content')
            # print master,path
            salt_server = SaltServer.objects.get(id=server)
            # print salt_server
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            # ret = sapi.SaltCmd(client='local',tgt=master,fun='file.write',arg=[file_path,file_content])['return'][0][master]
            obj=['client=local','tgt='+minion,'fun=file.write','arg='+path,'arg='+content]
            if sapi.SaltCmd(client='local',tgt=minion,fun='file.file_exists',arg=path)['return'][0][minion]:
            #     result  = sapi.SaltCmd(client='local',tgt=master,fun='cmd.run',arg='echo "'+file_content+'" > '+file_path)['return'][0][master]
            #     if result=="":
                try:
                    result=sapi.RepeatArgs(obj)['return'][0][minion]
                    # result=u'文件%s修改成功！' % path
                except Exception as e:
                    result = str(e)
            else:
                result = u"文件%s不存在！" % path
            print result
            return JsonResponse(result,safe=False)
