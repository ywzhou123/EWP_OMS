info.py
#!/usr/bin/python
import commands
import simplejson
import urllib
def role():
    information={}
    information['disk_num'] = commands.getoutput('fdisk -l|
    information['disk_big'] = commands.getoutput("fdisk -l|
    f=open('/etc/sysconfig/network')
    line=f.readlines()
    for i in list(line):
        if i.split('=')[0]  == 'HOSTNAME':
            host=i.split('=')[1]
            a=urllib.urlopen('http://XXXXXXXXXX:36000/devic
            ldev = simplejson.loads(a)
            for dev in ldev:
                if dev.has_key('appList'):
                    for app in dev['appList']:
                        if app.startswith('CPISF'):
                            information['type'] = app
            information['node']= '-'.join(host.split('-')[1
    return information