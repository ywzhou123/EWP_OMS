#!/uer/bin/python
# -*- coding: utf-8 -*-
#salt ‘*’ util.sync_modules puppet
from __future__ import absolute_import
from salt.ext.six.moves.urllib.request import urlopen as _u
import salt.utils
import salt.utils.decorators as decorators
@decorators.memoize
def __detect_os():
    return salt.utils.which('puppet')
def __virtual__():
    if __detect_os():
        return True
    return False
def    setmaster(master='www.shencan.net',config_file='/etc
    '''
        salt \* puppet.setmaster www.shencan.net
    '''
    check = 'grep server  {0}'.format(config_file)
    outcheck = __salt__['cmd.run'](check)
    if outcheck:
        cmdline = 'sed -i "s/server = .*/server = {0}/g" {1
        output = __salt__['cmd.run'](cmdline)
        return 'has change server to {0}'.format(master)
    else:
        cmdline = 'echo "    server = {0}" >> {1}'.format(m
config_file)
        output = __salt__['cmd.run'](cmdline)
        return 'has change server to {0} need restart the s
def version():
    '''
        salt '*' puppet.version
    '''
    cmd = 'rpm -qf {0}'.format(__detect_os())
    output = __salt__['cmd.run'](cmd).splitlines()
    ret = output[0].split(': ')
    return ret[-1]
def service(signal=None):
    '''
        salt '*' puppet.service start
    '''
    status = ('start','stop','status','restart','reload','f
    if signal not in status:
        return 'puppet can not support this signal'
    cmdline='/etc/init.d/puppet ' + '{0}'.format(signal)
    output=__salt__['cmd.run'](cmdline)
    return output
def master(config_file='/etc/puppet/puppet.conf'):
    '''
    salt \* puppet.master
    '''
    cmdline='grep server ' +  '{0}'.format(config_file)
    output = __salt__['cmd.run'](cmdline, python_shell=Fals
    if output:
        return output
    else:
        return 'puppet server not setting'