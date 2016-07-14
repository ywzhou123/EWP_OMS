{% set redis_install_dir = '/webdata/opt/local' %}

/tmp/redis-3.2.0.tar.gz:
  file.managed:
    - source: salt://redis/files/redis-3.2.0.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/redis-3.2.0.tar.gz


install_redis:
  cmd.run: 
    - name: cd /tmp && rm -rf redis-3.2.0 && tar -zxf redis-3.2.0.tar.gz && cd redis-3.2.0/src && make &>/dev/null && mkdir -p {{ redis_install_dir }}/redis/{bin,etc,db} && \cp redis-server redis-cli {{redis_install_dir}}/redis/bin 
    - required:
      - file: /tmp/redis-3.2.0.tar.gz
    - unless: test -e {{redis_install_dir}}/redis/bin/redis-server

up_conf:
  file.managed:
    - name: {{redis_install_dir}}/redis/etc/redis.conf
    - source: salt://redis/files/redis.conf
    - mode: 755
    - user: root
 

  
