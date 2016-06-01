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
from SALT.SaltAPI import SaltAPI
from SALT.models import SaltServer

#机房列表
@login_required
def idc(request):
    idc_list= IDC.objects.order_by('pk')
    count = {}  #统计机房中有多少台主机（不含物理主机）
    for idc in idc_list:
        num=0
        for server in idc.server_set.all():
            num+=server.host_set.count()
        count[int(idc.id)]=num
    # print count
    return render(request, 'CMDB/idc.html', locals())
#操作系统列表
@login_required
def system(request):
    system_list= SystemType.objects.order_by('name')
    return render(request, 'CMDB/system.html', locals())
# 服务器列表
@login_required
def server(request):
    system_id = request.GET.get('system_id')
    idc_id = request.GET.get('idc_id')
    system_list = SystemType.objects.order_by('name')
    idc_list = IDC.objects.order_by('name')
    server_list = Server.objects.order_by('ip')
    if system_id:
        if idc_id:
            server_list = server_list.filter(ip__host__systype=system_id,idc=idc_id)
        else:
            server_list = server_list.filter(ip__host__systype=system_id)
    elif idc_id:
        server_list = server_list.filter(idc=idc_id)
    else:
        server_list = server_list
    return render(request, 'CMDB/server.html', locals())
#主机列表
@login_required
def host(request):
    system_id = request.GET.get('system_id')
    server_id = request.GET.get('server_id')
    idc_id=request.GET.get('idc_id')
    hostname=request.POST.get('hostname')
    host_list=Host.objects.order_by('ip')
    system_list = SystemType.objects.order_by('name')
    server_list = Server.objects.order_by('name')
    idc_list = IDC.objects.order_by('name')
    #根据系统、机房、服务器过滤
    if system_id:
        if server_id:
            host_list = host_list.filter(system_type=system_id,server=server_id)
        elif idc_id:
            servers=server_list.filter(idc=idc_id)
            host_list = host_list.filter(system_type=system_id,server__in=servers)
        else:
            host_list = host_list.filter(system_type=system_id)
    elif server_id:
        host_list = host_list.filter(server=server_id)
    elif idc_id:
        servers=server_list.filter(idc=idc_id)
        host_list = host_list.filter(server__in=servers)
    else:
        host_list= host_list.order_by('ip')
    #根据主机名搜索，不区分大小写的匹配
    if hostname:
        host_list =host_list.filter(ip__tgt_id__icontains=hostname)
    else:
        host_list= host_list
    return render(request, 'CMDB/host.html', locals())



#主机详细信息
@login_required
def detail(request, ip):
    host_detail = HostDetail.objects.get(ip=ip)
    return render(request, 'CMDB/detail.html', {'host_detail': host_detail})
#网络设备列表
@login_required
def network(request):
    idc_id = request.GET.get('idc_id')
    if idc_id:
        net_list = Network.objects.filter(idc=idc_id).order_by('name')
    else:
        net_list = Network.objects.order_by('name')
    idc_list = IDC.objects.order_by('name')
    return render(request,'CMDB/network.html',locals())

def initialize(request,host_id):
    #vi /etc/salt/roster
    #10.188.1.43:
    #  host: 10.188.1.43
    #  user: root
    #  passwd: password
    host=HostDetail.objects.get(id=host_id)
    idc = Host.objects.get(ip=host_id).server.idc
    salt_server = SaltServer.objects.get(ip__server__idc=idc)
    sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)

    result = sapi.SaltCmd(client='ssh',tgt=host.ip,fun='state.sls',arg='minions.install')
    # 服务端shell执行结果：
    # {u'return': [{u'minion03': {u'fun_args': [], u'jid': u'20160418114256060122', u'return': True, u'retcode': 0, u'fun': u'test.ping', u'id': u'minion03'}}]}
    # 本案返回结果：
    #{u'return': [{u'10.188.1.43': {u'fun_args': [u'/tmp/.root_062b80_salt/salt_state.tgz', u'test=None', u'pkg_sum=9a6345be067f85bfd9cb53cd881e69cb', u'hash_type=md5'], u'jid': u'20160427112651029260', u'return': {u'file_|-epel_repo_|-/etc/yum.repos.d/epel.repo_|-managed': {u'comment': u'File /etc/yum.repos.d/epel.repo is in the correct state', u'name': u'/etc/yum.repos.d/epel.repo', u'start_time': u'11:26:51.094575', u'result': True, u'duration': 22.386, u'__run_num__': 0, u'changes': {}}, u'service_|-salt_service_|-salt-minion_|-running': {u'comment': u'The service salt-minion is already running', u'name': u'salt-minion', u'start_time': u'11:26:52.274941', u'result': True, u'duration': 98.74, u'__run_num__': 3, u'changes': {}}, u'pkg_|-salt_pkg_|-salt-minion_|-installed': {u'comment': u'Package salt-minion is already installed', u'name': u'salt-minion', u'start_time': u'11:26:51.738705', u'result': True, u'duration': 521.291, u'__run_num__': 1, u'changes': {}}, u'file_|-salt_conf_|-/etc/salt/minion_|-managed': {u'comment': u'File /etc/salt/minion is in the correct state', u'name': u'/etc/salt/minion', u'start_time': u'11:26:52.260834', u'result': True, u'duration': 12.585, u'__run_num__': 2, u'changes': {}}}, u'retcode': 0, u'fun': u'state.pkg', u'id': u'10.188.1.43', u'out': u'highstate'}}]}
#     {
#     u'return': [
#         {
#             u'10.188.1.43': {
#                 u'fun_args': [
#                     u'/tmp/.root_062b80_salt/salt_state.tgz',
#                     u'test=None',
#                     u'pkg_sum=9a6345be067f85bfd9cb53cd881e69cb',
#                     u'hash_type=md5'
#                 ],
#                 u'jid': u'20160427112651029260',
#                 u'return': {
#                     u'file_|-epel_repo_|-/etc/yum.repos.d/epel.repo_|-managed': {
#                         u'comment': u'File/etc/yum.repos.d/epel.repoisinthecorrectstate',
#                         u'name': u'/etc/yum.repos.d/epel.repo',
#                         u'start_time': u'11: 26: 51.094575',
#                         u'result': True,
#                         u'duration': 22.386,
#                         u'__run_num__': 0,
#                         u'changes': {
#
#                         }
#                     },
#                     u'service_|-salt_service_|-salt-minion_|-running': {
#                         u'comment': u'Theservicesalt-minionisalreadyrunning',
#                         u'name': u'salt-minion',
#                         u'start_time': u'11: 26: 52.274941',
#                         u'result': True,
#                         u'duration': 98.74,
#                         u'__run_num__': 3,
#                         u'changes': {
#
#                         }
#                     },
#                     u'pkg_|-salt_pkg_|-salt-minion_|-installed': {
#                         u'comment': u'Packagesalt-minionisalreadyinstalled',
#                         u'name': u'salt-minion',
#                         u'start_time': u'11: 26: 51.738705',
#                         u'result': True,
#                         u'duration': 521.291,
#                         u'__run_num__': 1,
#                         u'changes': {
#
#                         }
#                     },
#                     u'file_|-salt_conf_|-/etc/salt/minion_|-managed': {
#                         u'comment': u'File/etc/salt/minionisinthecorrectstate',
#                         u'name': u'/etc/salt/minion',
#                         u'start_time': u'11: 26: 52.260834',
#                         u'result': True,
#                         u'duration': 12.585,
#                         u'__run_num__': 2,
#                         u'changes': {
#
#                         }
#                     }
#                 },
#                 u'retcode': 0,
#                 u'fun': u'state.pkg',
#                 u'id': u'10.188.1.43',
#                 u'out': u'highstate'
#             }
#         }
#     ]
# }
    # jid = result['return'][0][host.ip]['jid']
    print result
    return HttpResponse(result)


#http://www.jb51.net/article/80289.htm
def collect(request,host_id):
    host=HostDetail.objects.get(id=host_id)
    idc = Host.objects.get(ip=host_id).server.idc
    salt_server = SaltServer.objects.get(ip__server__idc=idc)
    sapi = SaltAPI(url=salt_server.url,username=salt_server.username,password=salt_server.password)

    result = sapi.SaltMinions(host.tgt_id)
    grains = result['return'][0].values()[0]
    host.fqdn=grains['fqdn']
    host.domain=grains['domain']
    host.hwaddr_interfaces=grains['hwaddr_interfaces']
    host.cpu_model=grains['cpu_model']
    host.kernel=grains['kernel']
    host.os=grains['os']
    # ipv4 = str(grains[i]["ipv4"]).replace(", '127.0.0.1'","")
    # host.osarch=grains['osarch']
    host.osrelease=grains['osrelease']
    # host.productname=grains['productname']
    # host.serialnumber=grains['serialnumber']
    host.server_id=grains['server_id']
    host.save()
    #CPU核数num_cpus
#硬盘信息disk.usage disk_data = data_vol / 1048576
    return HttpResponseRedirect(reverse('cmdb:host'))


# #保存设备的登陆账号
# def account(request,device,id):
#
#     if request.method == 'POST':
#         if device == 'network':
#             obj=Network.objects.get(pk=id)
#             obj.username=request.POST.get('username')
#             obj.password=encrypt(request.POST.get('password'),SECRET_KEY)
#             obj.save()
#             return HttpResponseRedirect(reverse('cmdb:network'))
#         elif device == 'machine':
#             pass
#         elif device == 'host':
#             pass
#     return render(request,'CMDB/account.html')
