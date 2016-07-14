{%set install_path= '/soft' %}

/soft/zabbix/monitor_scripts:
  file.recurse:
    - source: salt://zabbix/files/zabbix/monitor_scripts
    - include_empty: True
    - file_mode: 755



