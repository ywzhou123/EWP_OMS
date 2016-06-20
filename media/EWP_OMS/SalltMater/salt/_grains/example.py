#!/usr/bin/python
#salt 'Minion' saltutil.sync_grains
def grains():
    local={}
    test={'key': 'vaule','key1': 'vaule1','key2': 'vaule2'}
    local['list']= [1,2,3,4]
    local['string'] = 'str'
    local['dict'] = test
    return local