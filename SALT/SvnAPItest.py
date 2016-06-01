#!/usr/bin/env python
# -*- coding: utf-8 -*-
from SaltAPI import SaltAPI
import ConfigParser
import svn.local,svn.remote
import pprint
import sys
# reload(sys)
# sys.setdefaultencoding( "utf-8" )
# class SvnAPI:
#     def __init__(self,url,username,password):
#         self.__url = url.rstrip('/') #移除URL末尾的/
#         self.__username = username
#         self.__password = password
#     def add(self):
#         pass
#     def update(self):
#         pass
#     def checkout(self):
#         pass

def SvnLocal():
    cf = ConfigParser.ConfigParser()
    cf.read("../EWP_OMS/config.ini")
    url = cf.get("svn_master","url")
    username = cf.get("svn_master","username")
    password = cf.get("svn_master","password")
    path = cf.get("svn_master","path")

    # r = svn.remote.RemoteClient(url=url,username=username,password=password)
    # r.checkout(path)
    path=path+"/wqef/新建文件夹"
    r = svn.local.LocalClient(path)

    info = r.info()

    pprint.pprint(info)
    # for a in r.list():
    #     pprint.pprint(a)
    # r.run_command(subcommand=['help'],args=['commit'])
    # run=r.run_command(subcommand=['add'],args=[path+'/123','--depth=infinity'])
    run=r.run_command(subcommand=['status'],args=[path])
    print type(path)
    # pprint.pprint(run)
    for l in run:
        a=l.split(' ')
        p=a[-1].rstrip('\r')
        if a[0]=='?':
            run=r.run_command(subcommand=['add'],args=[p,'--depth=infinity'])
            pprint.pprint(run)
        elif a[0]=='!':
            run=r.run_command(subcommand=['delete'],args=[p])
            pprint.pprint(run)


    # r.run_command(subcommand=['commit'],args=[path+"/config/master","-m 'ad'"])
    # for e in r.log_default():
    #     print (e)

    # pprint.pprint(r.info())
    # for e in r.log_default():
    #     print e

SvnLocal()
