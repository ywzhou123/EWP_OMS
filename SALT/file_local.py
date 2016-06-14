# -*- coding: utf-8 -*-
from django.shortcuts import  render,render_to_response,get_object_or_404
from django.http import HttpResponseRedirect,HttpResponse,JsonResponse
from django.contrib.auth.decorators import login_required
from django.core.urlresolvers import reverse
from SvnAPI import *
from EWP_OMS.settings import *
import os
import shutil

root = MEDIA_ROOT

#文件管理页面
@login_required
def file_local(request):
    root = MEDIA_ROOT
    #根目录不存在时创建
    if not os.path.isdir(root):
        os.makedirs(root)
    elif request.method == 'GET':
        base=request.GET.get('base','')
        dir=request.GET.get('dir','')
        path = root+dir+base
        #返回目录列表
        if os.path.isdir(path):
            dir=dir+base+'/'
            #返回目录的SVN信息
            svn=SvnLocal(path).info()
        #返回文件信息
        elif os.path.isfile(path):
            type='File'
            size=os.path.getsize(path)
            format=os.path.splitext(path)[1]
            if format in FILE_FORMAT:
                if size <= 1024000 :
                    try:
                        f=open(path,'r')
                        result=list()
                        for line in f.readlines():
                            # if not len(line) or line.startswith('#'):       #判断是否是空行或注释行
                            #     continue
                            result.append(line)
                        f.close()
                    except Exception as e:
                        error=e
                else:
                    error=u'文件%s大于1M，拒绝访问！' % base
                    nowrite=True
            else:
                error=u"文件格式'%s'不属于%s，拒绝访问!" % (format,FILE_FORMAT)
                nowrite=True
            #返回文件的SVN信息
            svn=SvnLocal(path).info()
            path=root+dir
        else:
            path=root+dir
            error=u'目标不是目录或文件，可能是符号链接或挂载点！'
        #返回上层目录
        updir=request.GET.get('updir','')
        if updir and updir!='/':
            dir_list=updir.split('/')
            base=dir_list[-3]
            dir='/'.join(dir_list[0:-2])+'/'
            path=root+dir
            svn=SvnLocal(path).info()
        #文件夹列表排除处理
        media_list=os.listdir(path)
        try: media_list.remove('.svn')
        except:pass
    return render(request, 'SALT/file_local.html', locals())
@login_required
def file_create(request):
    if request.is_ajax() and request.method == 'GET':
        dir=request.GET.get('dir','')
        type=request.GET.get('type','')
        name=request.GET.get('name','')
        path=root+dir+name
        if type=='Dir':
            if os.path.isdir(path):
                result = {'ret':0,'msg':u"目录\"%s\"已存在！" % name}
            else:
                try:
                    os.mkdir(path)
                    result={'ret':1,'msg':u"目录\"%s\"创建成功！" % name}
                except Exception as e:
                    result={'ret':0,'msg':u"目录\"%s\"创建失败！\n错误信息：%s"  % (name,e)}
        elif type=='File':
            if os.path.isfile(path):
                result = {'ret':0,'msg':u"文件\"%s\"已存在！" % name}
            else:
                try:
                    f = open(path,'w')
                    f.close()
                    result={'ret':1,'msg':u"文件\"%s\"创建成功！" % name}
                except Exception as e:
                    result={'ret':0,'msg':u"文件\"%s\"创建失败！\n错误信息：%s" % (name,e)}
        else:
            result={'ret':0,'msg':u"目标\"%s\"类型错误！必须是'Dir'或者'File'！" % name}
        return JsonResponse(result,safe=False)
@login_required
def file_rename(request):
    if request.is_ajax() and request.method == 'GET':
        dir=request.GET.get('dir','')
        type=request.GET.get('type','')
        name=request.GET.get('name','')
        name_new=request.GET.get('name_new','')

        if type=='File':
            path_old=root+dir+name
            path_old_list=path_old.split('/')
            path_old_list[-1]=name_new
            path_new='/'.join(path_old_list)
            if os.path.isfile(path_new):
                result = {'ret':0,'msg':u"新文件\"%s\"已存在！" % name_new}
            else:
                try:
                    os.rename(path_old,path_new)
                    result={'ret':1,'msg':u"文件\"%s\"已成功重命名为\"%s\"！" % (name,name_new),'dir':dir}
                except Exception as e:
                    result={'ret':0,'msg':u"文件\"%s\"重命名失败！\n错误信息：%s" % (name,e)}
        else:
            path_old=root+dir.rstrip('/')
            path_old_list=path_old.split('/')
            path_old_list[-1]=name_new
            path_new='/'.join(path_old_list)

            if os.path.isdir(path_new):
                result = {'ret':0,'msg':u"新目录\"%s\"已存在！" % name_new}
            else:
                try:
                    os.rename(path_old,path_new)
                    result={'ret':1,'msg':u"目录\"%s\"已成功重命名为\"%s\"！" % (name,name_new),'dir':path_new[len(root):-len(name_new)]}
                except Exception as e:
                    result={'ret':0,'msg':u"目录\"%s\"重命名失败！\n错误信息：%s" % (name,e)}
        return JsonResponse(result,safe=False)
@login_required
def file_delete(request):
    if request.is_ajax() and request.method == 'GET':
        type=request.GET.get('type','')
        dir=request.GET.get('dir','')
        name=request.GET.get('name','')
        if type=='File':
            path=root+dir+name
            if os.path.isfile(path):
                try:
                    os.remove(path)
                    updir=dir+name+'/'
                    result={'ret':1,'msg':u"文件\"%s\"删除成功！" % path,'updir':updir}
                except:
                    result={'ret':0,'msg':u"文件\"%s\"删除失败！" % path}
            else:
                result={'ret':0,'msg':u"文件\"%s\"不存在！" % path}
        else:
            path=root+dir.rstrip('/')
            if os.path.isdir(path):
                try:
                    shutil.rmtree(path)
                    result={'ret':2,'msg':u"目录\"%s\"删除成功！rmtree" % path}
                except Exception as e:
                    try:
                        if os.name=='posix':
                            os.system('rm -rf %s'%path)
                        elif os.name=='nt':
                            os.system('del /S/Q/F  %s'%path.replace('/','\\'))
                            os.rmdir(path)
                        result={'ret':2,'msg':u"目录\"%s\"删除成功！os.system" % path}
                    except Exception as e:
                        result={'ret':0,'msg':u"目录\"%s\"删除失败！可能存在只读文件，请再次执行删除！" % e}
            else:
                result={'ret':0,'msg':u"目录\"%s\"不存在！" % path}

        return JsonResponse(result,safe=False)
@login_required
def file_write(request):
    if request.is_ajax() and request.method == 'GET':
        dir=request.GET.get('dir','')
        name=request.GET.get('name','')
        content=request.GET.get('content','')
        path=root+dir+name
        format=os.path.splitext(path)[1]
        print format,type(format)
        if format in FILE_FORMAT:
            try:
                f=open(path,'w')
                f.write(content.encode("utf-8"))
                f.close()
                result={'ret':1,'msg':u"文件\"%s\"保存成功！" % path}
            except Exception as e:
                result={'ret':0,'msg':u"文件\"%s\"保存失败！\n错误信息：%s" % (path,e)}
        else:
            result={'ret':0,'msg':u"文件\"%s\"的格式必须符合\"%s\"其中一项！" % (name,FILE_FORMAT)}

        return JsonResponse(result,safe=False)
@login_required
def file_upload(request):
    if request.method == 'POST':
        path=request.POST['path']
        file=request.FILES['file']
        name=str(file)
        print path,name
        if not os.path.isdir(root+path):
            return HttpResponse("Path is not exists")
        elif os.path.isfile(root+path+name):
            return HttpResponse("File '%s'is already exists, please delete it before!"%name)
        else:
            with open(root+path+name, 'wb+') as destination:
                for chunk in file.chunks():
                    destination.write(chunk)
                destination.close()
            return HttpResponseRedirect("/salt/file_local/?base=%s&dir=%s" % (name,path))
    else:
        return HttpResponse("Upload Failed")
@login_required
def svn(request):
    if request.is_ajax() and request.method == 'GET':
        active=request.GET.get('active','')
        dir=request.GET.get('dir','')
        path=root+dir
        svn=SvnLocal(path)

        url=request.GET.get('url','')
        username=request.GET.get('username','')
        password=request.GET.get('password','')
        path_r=root+'/'+dir
        svn_r=SvnRemote(url,username,password,path_r)

        if active == 'commit':
            result=svn.commit()
        elif active == 'update':
            result=svn.update()
        elif active == 'revert':
            result=svn.revert()
        elif active == 'checkout':
            result=svn_r.checkout()
        else:
            result={'ret':0,'msg':u'未指定SVN操作类型！'}
        return JsonResponse(result,safe=False)
