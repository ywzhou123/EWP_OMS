#安装
keepalived-install:
    file.managed:
        - name: /usr/local/src/keepalived-1.2.20.tar.gz
        - source: salt://keepalived/files/keepalived-1.2.20.tar.gz
        - mode: 755
        - user: root
        - group: root
    cmd.run:
        - name: cd /usr/local/src && tar zxf keepalived-1.2.20.tar.gz
        - unless: test -d /usr/local/keepalived
        - require:
          - file: keepalived-install
#配置文件
/etc/sysconfig/keepalived:
    file.managed:
        - source: salt://keepalived/files/keepalived.sys
        - mode: 644
        - user: root
        - group: root
#进程文件
/etc/init.d/keepalived:
    file.managed:
        - source: salt://keepalived/files/keepalived.init
        - mode: 755
        - user: root
        - group: root
#自动启动
keepalived-init:
    cmd.run:
        - name: chkconfig --add keepalived
        - unless: chkconfig --list | grep keepalived
        - require:
          - file: /etc/init.d/keepalived
#配置文件目录
/etc/keepalived:
    file.directory:
        - user: root
        - group: root
