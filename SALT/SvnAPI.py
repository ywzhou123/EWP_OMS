#!/usr/bin/env python
# -*- coding: utf-8 -*-

import svn.local,svn.remote
import pprint
import sys
# reload(sys)
# sys.setdefaultencoding( "utf-8" )


class SvnLocal:
    def __init__(self,path):
        self.__p=path.rstrip('/').encode('gbk')
    def info(self):
        try:
            r = svn.local.LocalClient(self.__p)
            i=r.info()
            result = {'vision':i['commit_revision'],'date':i['commit_date'],'url':i['url']}
        except:
            result = {'error':u"此目录不是SVN副本！"}
        return result
    def commit(self):
        try:
            r = svn.local.LocalClient(self.__p)
            s=r.run_command(subcommand=['status'],args=[self.__p])
            # pprint.pprint(s)
            for l in s:
                a=l.split(' ')
                p=a[-1].rstrip('\r')
                if a[0]=='?':
                    r.run_command(subcommand=['add'],args=[p,'--depth=infinity'])
                elif a[0]=='!':
                    r.run_command(subcommand=['delete'],args=[p])
            r.run_command(subcommand=["commit"], args=[self.__p, "-m 'commit'"])
            result={'ret':1,'msg':u"SVN副本提交成功！"}
        except Exception as e:
            result={'ret':0,'msg':u"SVN副本提交失败！\n错误信息：%s" % e}
        return  result
    def update(self):
        result = self.commit()
        print result
        if result['ret']==1:
            try:
                r = svn.local.LocalClient(self.__p)
                r.run_command(subcommand=['update'],args=[self.__p])
                result={'ret':1,'msg':u"SVN副本更新成功！"}
            except Exception as e:
                result={'ret':0,'msg':u"SVN副本更新失败！\n错误信息：%s" % e}
        return  result
    def revert(self):
        try:
            r = svn.local.LocalClient(self.__p)
            r.run_command(subcommand=['revert'],args=[self.__p,"--depth=infinity","-q"])
            result={'ret':1,'msg':u"SVN副本还原成功！"}
        except Exception as e:
            result={'ret':0,'msg':u"SVN副本还原失败！\n错误信息：%s" % e}
        return  result

class SvnRemote:
    def __init__(self,url,username,passwrod,path):
        self.__url=url
        self.__username=username
        self.__password=passwrod
        self.__path=path
    def checkout(self):
        try:
            r = svn.remote.RemoteClient(url=self.__url,username=self.__username,password=self.__password)
            r.checkout(self.__path)
            result={'ret':1,'msg':u'目录签出成功！'}
        except Exception as e:
            print e
            result={'ret':0,'msg':u"目录签出失败!错误信息：%s"%e}
        return result