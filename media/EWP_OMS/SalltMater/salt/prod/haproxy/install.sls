include:
  - pkg.pkg-init

haproxy-install:
  file.managed:
    - name: /usr/local/src/haproxy-1.6.2.tar.gz
    - source: salt://haproxy/files/haproxy-1.6.2.tar.gz
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar zxf haproxy-1.6.2.tar.gz && 
    - unless: test -d /usr/local/haproxy
    - require:
      - pkg: pkg-init
      - file: haproxy-install

#进程文件
/etc/init.d/haproxy:
  file.managed:
    - source: salt://haproxy/files/haproxy.init
    - mode: 755
    - user: root
    - group: root
    - require:
      - cmd: haproxy-install
#自动启动
haproxy-init:
  cmd.run:
    - name: chkconfig --add haproxy
    - unless: chkconfig --list | grep haproxy
    - require:
      - file: /etc/init.d/haproxy

#设置可以监听非本地IP：
net.ipv4.ip_nonlocal_bind:
  sysctl.present:
  - value: 1

#创建配置目录
haproxy-config-dir:
  file.directory:
    - name: /etc/haproxy
    - mode: 755
    - user: root
    - group: root
