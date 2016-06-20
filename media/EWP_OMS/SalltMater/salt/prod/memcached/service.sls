include:
    - memcached.install
    - user.www
#比较简单，生产环境下建议使用supervisor来管理memcached进程
memcached-service:
    cmd.run:
        - name: /usr/local/memcached/bin/memcached -d
        - unless: netstat -ntlp | grep 11211
        - require:
          - cmd: memcached-source-install
          - user: www-user-group