#http://www.memcached.org/files/
include:
    - libevent.install
memcached-source-install:
    file.managed:
        - name: /usr/local/src/memcached-1.4.24.tar.gz
        - source: salt://memcached/files/memcached-1.4.24.t
        - user: root
        - group: root
        - mode: 644
    cmd.run:
        - name: cd /usr/local/src && tar zxf memcached-1.4.
--enable-64bit --with-libevent=/usr/local/libevent && make 
        - unless: test -d /usr/local/memcached
        - require:
          - cmd: libevent-source-install
          - file: memcached-source-install