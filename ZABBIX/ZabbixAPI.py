# -*- coding: utf-8 -*-
import ConfigParser
import json
import urllib2

class ZabbixAPI:
    def __init__(self):
        cf = ConfigParser.ConfigParser()
        cf.read("EWP_OMS/config.ini")
        self.__url = cf.get("zabbix_server","url")
        self.__user= cf.get("zabbix_server","user")
        self.__password = cf.get("zabbix_server","password")
        self.__header = {"Content-Type": "application/json-rpc"}
        self.__token_id = self.UserLogin()
    #登陆获取token
    def UserLogin(self):
        data = {
            "jsonrpc": "2.0",
            "method": "user.login",
            "params": {
                "user": self.__user,
                "password": self.__password
            },
            "id": 0,
        }
        return self.PostRequest(data)
    #推送请求
    def PostRequest(self, data):
        request = urllib2.Request(self.__url,json.dumps(data),self.__header)
        result = urllib2.urlopen(request)
        response = json.loads(result.read())
        try:
            # print response['result']
            return response['result']
        except KeyError:
            raise KeyError
    #主机列表
    def HostGet(self,hostid=None,hostip=None):
        data = {
            "jsonrpc":"2.0",
            "method":"host.get",
            "params":{
                "output":"extend",
                "selectGroups": "extend",
                "selectParentTemplates": ["templateid","name"],
                "selectInterfaces": ["interfaceid","ip"],
                "selectInventory": ["os"],
                "selectItems":["itemid","name"],
                "selectGraphs":["graphid","name"],
                "selectApplications":["applicationid","name"],
                "selectTriggers":["triggerid","name"],
                "selectScreens":["screenid","name"]
            },
            "auth": self.__token_id,
            "id":1,
        }
        if hostid:
            data["params"]={
                "output": "extend",
                "hostids": hostid,
                "sortfield": "name"
            }
        return  self.PostRequest(data)
    #主机列表
    def HostCreate(self,hostname,hostip,groupid=None,templateid=None):
        data = {
            "jsonrpc":"2.0",
            "method":"host.create",
            "params": {
                "host": hostname,
                "interfaces": [
                    {
                        "type": 1,
                        "main": 1,
                        "useip": 1,
                        "ip": hostip,
                        "dns": "",
                        "port": "10050"
                    }
                ],
                "groups": [
                    {
                        "groupid": groupid
                    }
                ],
                "templates": [
                    {
                        "templateid": templateid
                    }
                ]
            },
            "auth": self.__token_id,
            "id":1,
        }
        return  self.PostRequest(data)

    #主机组列表
    def HostGroupGet(self,hostid=None,itemid=None):
        data = {
            "jsonrpc":"2.0",
            "method":"hostgroup.get",
            "params":{
                "output": "extend",
                "hostids": hostid,
                "itemids": itemid,
                "sortfield": "name"
            },
            "auth": self.__token_id,
            "id":1,
        }
        return  self.PostRequest(data)
    #监控项列表
    def ItemGet(self,hostid=None,itemid=None):
        data = {
            "jsonrpc":"2.0",
            "method": "item.get",
            "params": {
                "output": "extend",
                "hostids": hostid,
                "itemids": itemid,
                "sortfield": "name"
            },
            "auth": self.__token_id,
            "id":1,
        }
        return  self.PostRequest(data)
    #模板列表
    def TemplateGet(self, hostid=None,templateid=None):
        data = {
            "jsonrpc":"2.0",
            "method": "template.get",
            "params": {
                "output": "extend",
                "hostids": hostid,
                "templateids": templateid,
                "sortfield": "name"
            },
            "auth": self.__token_id,
            "id":1,
        }
        return  self.PostRequest(data)
    #图像列表
    def GraphGet(self,hostid=None,graphid=None):
        data = {
            "jsonrpc":"2.0",
            "method": "graph.get",
            "params": {
                "output": "extend",
                "hostids": hostid,
                "graphids": graphid,
                "sortfield": "name"
            },
            "auth": self.__token_id,
            "id":1,
        }
        return  self.PostRequest(data)
    #历史数据
    def History(self,itemid=None):
        data = {
            "jsonrpc": "2.0",
            "method": "history.get",
            "params": {
                "output": "extend",
                "history": 0,
                "itemids": itemid,
                "sortfield": "clock",
                "sortorder": "DESC",
                "limit": 10
            },
            "auth": self.__token_id,
            "id": 2
        }
        return self.PostRequest(data)
#测试：python manager.py shell ; from ZABBIX.ZabbixAPI import * ; main()，代码修改了要ctrl+Z退出重进
def main():
    zapi=ZabbixAPI()
    token=zapi.UserLogin()
    print token
    #39378ec03aa101c2b17d1d2bd6f4ef16
    hosts=zapi.HostGet()
    print hosts
    #[{u'host': u'Zabbix server', u'hostid': u'10084', u'interfaces': [{u'interfaceid': u'1', u'ip': u'127.0.0.1'}]}]




if __name__ == '__main__':
    main()