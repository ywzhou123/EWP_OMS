{% set memcached_install_dir='/webdata/opt/local' %}
include:
  - epel.install


install_compile_env:
  cmd.run:
    - name: yum install gcc make -y &>/dev/null

/tmp/libevent-2.0.21-stable.tar.gz:
  file.managed:
    - source: salt://memcached/files/libevent-2.0.21-stable.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/libevent-2.0.21-stable.tar.gz
    
/tmp/memcached-1.4.25.tar.gz:
  file.managed:
    - source: salt://memcached/files/memcached-1.4.25.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/memcached-1.4.25.tar.gz


install_libevent:
  cmd.run:
    - name: cd /tmp && rm -rf libevent-2.0.21-stable && tar -xzf libevent-2.0.21-stable.tar.gz && cd libevent-2.0.21-stable && ./configure --prefix=/usr/local/libevent &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/libevent-2.0.21-stable.tar.gz
      - cmd: install_compile_env
    - unless: test -d /usr/local/libevent

install_memcached:
  cmd.run:
    - name: cd /tmp/ && rm -rf memcached-1.4.25 && tar -zxf memcached-1.4.25.tar.gz && cd memcached-1.4.25 && mkdir -p {{memcached_install_dir}} && ./configure --prefix={{memcached_install_dir}}/memcached --with-libevent=/usr/local/libevent &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/memcached-1.4.25.tar.gz
      - cmd: install_libevent
      - cmd: install_compile_env
    - unless: test -d {{ memcached_install_dir }}/memcached/bin
