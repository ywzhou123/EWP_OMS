{% set server_ip = '10.175.198.38' %}
{% set base_dir  = '/soft' %}
up_conf:
  file.managed:
    - name: /soft/zabbix/etc/zabbix_agentd.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - template: jinja
    - user: zabbix
    - group: zabbix
    - defaults:
        Server: {{ server_ip }}
        ServerActive: {{ server_ip }}
        host: {{ grains['ip4_interfaces']['eth0'][0] }}
        install_dir: {{ base_dir }}

modify:
  file.managed:
    - name: /etc/init.d/zabbix_agentd
    - source: salt://zabbix/files/zabbix_agentd
    - template: jinja
    - defaults:
        install_dir: {{ base_dir }}
