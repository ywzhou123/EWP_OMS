include:
  - zabbix.install_zabbix
  - zabbix.update_zbx_conf

start_zbx_agentd:
  cmd.run:
    - name: service zabbix_agentd start
    - unless: pstree|grep zabbix_agentd

chkconfig:
  cmd.run:
    - name: chkconfig --level 35 zabbix_agentd on
