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
def file_remote(request):
    salt_server=SaltServer.objects.all()
    system_list = SystemType.objects.order_by('name')
    idc_list = IDC.objects.order_by('name')
    group_list = HostGroup.objects.order_by('name')
    if not os.path.isdir(MEDIA_ROOT):
        os.makedirs(MEDIA_ROOT)
    media_list = os.listdir(MEDIA_ROOT)
    return render(request,'SALT/file_remote.html',locals())
#获取目录列表
@login_required
def file_list(request):
    if request.is_ajax():
        if request.method == 'GET':
            minion=request.GET.get('minion')
            path=request.GET.get('path')
            print minion,path
            idc = HostDetail.objects.get(tgt_id=minion).host.server.idc
            print idc
            salt_server = SaltServer.objects.get(ip__server__idc=idc)
            print salt_server.url,salt_server.username,salt_server.password
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            #目录存在时返回目录列表
            try:
                isdir=sapi.SaltCmd(client='local',tgt=minion,fun='file.directory_exists',arg=path)['return'][0][minion]
                # if isdir:
                #     path_str=path.split('/')
                #     print path_str
                #     if path_str[-1]=='..':
                #         if len(path_str)>3:
                #             path='/'.join(path_str[0:-2])
                #         else:
                #             path='/'
                #         print path
                #     file_list = sapi.SaltCmd(client='local',tgt=minion,fun='file.readdir',arg=path)['return'][0][minion]
                #     file_list.remove('.')
                #     if path=='/':
                #         file_list.remove('..')
                #     result = {'file_list':sorted(file_list) ,'path_type':'dir','pdir':path}
            except Exception as e:
                print e
                result = {'file_list':[e],'path_type':'none'}
            else:
                #文件存在时，返回文件内容，需要加上文件大小限制
                isfile=sapi.SaltCmd(client='local',tgt=minion,fun='file.file_exists',arg=path)['return'][0][minion]
                # if isfile:
                #     file_content=sapi.SaltCmd(client='local',tgt=minion,fun='cmd.run',arg='cat '+path)['return'][0][minion]
                #     result = {'file_content':file_content,'path_type':'file','pdir':path}

            print result
            return JsonResponse(result,safe=False)
#创建目录或文件
@login_required
def file_create_r(request):
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
def file_write_r(request):
    if request.is_ajax():
        if request.method == 'GET':
            master=request.GET.get('master')
            file_path=request.GET.get('file_path')
            file_content=request.GET.get('file_content')
            # print master,path
            salt_server = SaltServer.objects.filter(ip__ip__tgt_id=master)[0]
            # print salt_server
            sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)
            # ret = sapi.SaltCmd(client='local',tgt=master,fun='file.write',arg=[file_path,file_content])['return'][0][master]
            if sapi.SaltCmd(client='local',tgt=master,fun='file.file_exists',arg=file_path)['return'][0][master]:
                result  = sapi.SaltCmd(client='local',tgt=master,fun='cmd.run',arg='echo "'+file_content+'" > '+file_path)['return'][0][master]
                if result=="":
                    result=u'文件%s修改成功！' %file_path
            else:
                result = u"文件%s不存在！" % file_path
            print result
            return JsonResponse(result,safe=False)
