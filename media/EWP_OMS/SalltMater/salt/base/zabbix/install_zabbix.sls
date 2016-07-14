{%set zbx_install_dir= '/soft' %}

up_zbx_gz:
  file.managed:
    - name: /tmp/zabbix.tar.gz
    - source: salt://zabbix/files/zabbix.tar.gz

unzip_zbx_gz:
  cmd.run:
    - name: cd /tmp && tar -zxf zabbix.tar.gz && mkdir  -p {{ zbx_install_dir }} &&  mv /tmp/zabbix {{zbx_install_dir}}/zabbix 
    - require:
      - file: /tmp/zabbix.tar.gz
    - unless: test -d {{zbx_install_dir}}/zabbix

add_zbx_user:
  user.present:
    - name: zabbix
    - shell: /sbin/nologin
    - createhome: False
    - gid_from_name: True
    - system: True


chown_zbx_dir:
  cmd.run:
    - name: chown -R zabbix.zabbix {{ zbx_install_dir }}/zabbix
    - require:
      - cmd: unzip_zbx_gz
    - unless: test -d {{ zbx_install_dir }}/zabbix


service_script:
  file.managed:
    - name: /etc/init.d/zabbix_agentd
    - source: salt://zabbix/files/zabbix_agentd
    - mode: 755
  cmd.run:
    - name: chkconfig --add zabbix_agentd
    - unless: chkconfig --list|grep zabbix_agentd &>/dev/null
