# -*- coding: utf-8 -*-
from django.shortcuts import  render,render_to_response,get_object_or_404
from django.http import HttpResponseRedirect,HttpResponse,JsonResponse
from django.contrib.auth.decorators import login_required
from models import *
from CMDB.models import *
from SaltAPI import SaltAPI
from EWP_OMS.settings import *
import os
from urllib import quote
#文件管理页面
@login_required
def file_remote(request,server_id):
    server_list=SaltServer.objects.all()
    try:
        salt_server = SaltServer.objects.get(id=server_id)
    except:#id不存在时返回第一个
        salt_server = SaltServer.objects.all()[0]
    context={'server_list':server_list,'salt_server':salt_server}
    #返回在线minion
    try:
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        result=sapi.SaltRun(client='runner',fun='manage.status')
        print result
        context['minions_up']=result['return'][0]['up']
    except Exception as error:
        context['error']=error
    #返回请求的目录列表和文件
    dir=None
    if request.method == 'GET':
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        tgt=request.GET.get('tgt')
        path=request.GET.get('path').replace('//','/').rstrip('/').encode('utf-8')
        #目录存在时返回目录列表
        try:
            if sapi.SaltCmd(client='local',tgt=tgt,fun='file.directory_exists',arg=path)['return'][0][tgt]:
                path_str=path.split('/')
                if path_str[-1]=='..':#返回上层
                    if len(path_str)>3:
                        dir='/'.join(path_str[0:-2])
                    else:
                        dir='/'
                else:
                    dir=path
        except Exception as e:
            # result = {'error':str(e)}
            context['error']=str(e)
        else:
            #文件存在时，返回文件内容，加上文件格式、大小限制
            if os.path.splitext(path)[1] in FILE_FORMAT:
                if sapi.SaltCmd(client='local',tgt=tgt,fun='file.file_exists',arg=path)['return'][0][tgt]:
                    stats=sapi.SaltCmd(client='local',tgt=tgt,fun='file.stats',arg=path)['return'][0][tgt]
                    if stats['size'] <= 1024000:
                        content=sapi.SaltCmd(client='local',tgt=tgt,fun='cmd.run',arg='cat '+path)['return'][0][tgt]
                        # result = {'content':content,'type':'file','pdir':path,'stats':stats}
                        context['content']=content
                        context['stats']=stats
                    else:
                        # result = {'error':u"文件大小超过1M，拒绝访问！"}
                        context['error']=u"文件大小超过1M，拒绝访问！"
                    path_str=path.rstrip('/').split('/')
                    dir='/'.join(path_str[0:-1])
            else:
                # result = {'error':u"文件格式不允许访问，请检查setting.FILE_FORMAT！"}
                context['error']=u"文件格式不允许访问，请检查setting.FILE_FORMAT！"
        # 根据路径获取列表
        if dir:
            dirs = sapi.SaltCmd(client='local',tgt=tgt,fun='file.readdir',arg=dir)['return'][0][tgt]
            try:
                dirs.remove('.').remove('.svn')
                if dir=='/':
                    dirs.remove('..')
            except:pass
            # result = {'dirs':sorted(dirs) ,'type':'dir','pdir':path}
            context['dir']=dir
            context['dir_list']=dirs
            context['tgt']=tgt
        # return JsonResponse(result,safe=False)

    return render(request,'SALT/file_remote.html',context)

#重命名目录或文件
@login_required
def file_remote_rename(request):
    if request.is_ajax():
        if request.method == 'GET':
            minion=request.GET.get('minion')
            path=request.GET.get('path')
            type=request.GET.get('ype')
            name=request.GET.get('_name')
            server=request.GET.get('server')
            salt_server = SaltServer.objects.get(id=server)
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            #新建目录或文件
            if type == 'Dir':
                create_name = (path+'/'+name).replace('//','/')
                try:
                    sapi.SaltCmd(client='local',tgt=minion,fun='file.mkdir',arg=create_name)
                    result = {'ret':1,'msg':u'目录"%s"创建成功！' % create_name}
                except:
                    result = {'ret':0,'msg':u'目录"%s"创建失败！' % create_name}
            elif type == 'File':
                create_name = (path+'/'+name).replace('//','/')
                #创建文件，文件不存在时创建，存在则刷新创建时间，内容不变，目录不存在时返回false
                ret = sapi.SaltCmd(client='local',tgt=minion,fun='file.touch',arg=create_name)['return'][0][minion]
                if ret == True:
                    result = {'ret':1,'msg':u'文件"%s"创建成功！' % create_name}
                else:
                    result ={'ret':0,'msg': u'文件"%s"创建失败！' % create_name}
            else:
                result={'ret':0,'msg':u'目标类型错误！'}
            return JsonResponse(result,safe=False)
#创建目录或文件
@login_required
def file_remote_create(request):
    if request.is_ajax() and request.method == 'GET':
        tgt=request.GET.get('tgt')
        name=request.GET.get('name')
        path_r=request.GET.get('path')+'/'+name
        path=path_r.encode('utf-8')
        print path
        type=request.GET.get('type')
        server=request.GET.get('server')
        salt_server = SaltServer.objects.get(id=server)
        sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
        #新建目录或文件
        if type == 'Dir':
            try:
                if sapi.SaltCmd(client='local',tgt=tgt,fun='file.directory_exists',arg=path)['return'][0][tgt]:
                    result = {'ret':0,'msg':u'目录"%s"已存在！' % path_r}
                else:
                    try:
                        sapi.SaltCmd(client='local',tgt=tgt,fun='file.mkdir',arg=path)
                        result = {'ret':1,'msg':u'目录"%s"创建成功！' % path_r}
                    except:
                        result = {'ret':0,'msg':u'目录"%s"创建失败！' % path_r}
            except Exception as e:
                result = {'ret':0,'msg':u'错误：%s' % e}
        elif type == 'File':
            try:
                #创建文件，文件不存在时创建，存在则刷新创建时间，内容不变，目录不存在时返回false
                if sapi.SaltCmd(client='local',tgt=tgt,fun='file.file_exists',arg=path)['return'][0][tgt]:
                    result ={'ret':0,'msg': u'文件"%s"已存在！' % path}
                elif sapi.SaltCmd(client='local',tgt=tgt,fun='file.touch',arg=path)['return'][0][tgt]:
                    result = {'ret':1,'msg':u'文件"%s"创建成功！' % path_r}
                else:
                    result ={'ret':0,'msg': u'文件"%s"创建失败！' % path_r}
            except Exception as e:
                result = {'ret':0,'msg':u'错误：%s' % e}
        else:
            result={'ret':0,'msg':u'目标类型错误！'}
        # print result
        return JsonResponse(result,safe=False)

#写入文件内容
@login_required
def file_remote_write(request):
    if request.is_ajax():
        if request.method == 'GET':
            tgt=request.GET.get('tgt')
            server=request.GET.get('server')
            path=request.GET.get('path')
            content=request.GET.get('content')
            # print master,path
            salt_server = SaltServer.objects.get(id=server)
            # print salt_server
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            # ret = sapi.SaltCmd(client='local',tgt=master,fun='file.write',arg=[file_path,file_content])['return'][0][master]
            try:
                if sapi.SaltCmd(client='local',tgt=tgt,fun='file.file_exists',arg=path.encode("utf-8"))['return'][0][tgt]:
                #     result  = sapi.SaltCmd(client='local',tgt=master,fun='cmd.run',arg='echo "'+file_content+'" > '+file_path)['return'][0][master]
                #     if result=="":
                    try:
                        arg1='arg='+quote(path)
                        arg2='arg='+quote(content)
                        # print arg1,arg2
                        obj=['client=local','tgt=%s'%tgt,'fun=file.write',arg1,arg2]
                        # print obj
                        # print obj
                        result=sapi.RepeatArgs(obj)['return'][0][tgt]
                        # result=u'文件%s修改成功！' % path
                    except Exception as e:
                        # print e
                        result = str(e)
                else:
                    result = u"文件不存在"
            except Exception as e:
                result = str(e)
            print result
            return JsonResponse(result,safe=False)
