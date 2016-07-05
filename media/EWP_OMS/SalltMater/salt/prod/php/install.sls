{% set php_install_dir = '/webdata/opt/local' %}
{% set configure_args = '--with-fpm-user=www --with-fpm-group=www   --with-openssl --enable-fpm --with-mysql --with-mysqli --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=shared --enable-xml --with-curl --with-mhash --with-mcrypt --with-gd --enable-gd-native-ttf --with-xsl --with-ldap --with-ldap-sasl --without-pear --enable-zip --enable-soap --enable-mbstring --enable-sockets --enable-pcntl --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --disable-rpath --enable-mbregex --with-xmlrpc --enable-wddx --enable-ftp' %}

include:
  - epel.install

/tmp/php-5.6.16.tar.gz:
  file.managed:
    - source: salt://php/files/php-5.6.16.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/php-5.6.16.tar.gz

/tmp/phpredis-2.2.4.tar.gz:
  file.managed:
    - source: salt://php/files/phpredis-2.2.4.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/phpredis-2.2.4.tar.gz

/tmp/libmemcached-1.0.18.tar.gz:
  file.managed:
    - source: salt://php/files/libmemcached-1.0.18.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/libmemcached-1.0.18.tar.gz

/tmp/php-memcached.tar.gz:
  file.managed:
    - source: salt://php/files/php-memcached.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/php-memcached.tar.gz


/tmp/memcache-3.0.5.tgz:
  file.managed:
    - source: salt://php/files/memcache-3.0.5.tgz
    - mode: 755
    - user: root
    - unless: test -e /tmp/memcache-3.0.5.tgz

add_run_user:
  user.present:
    - shell: /sbin/nologin
    - name: www
    - gid_from_name: Ture
    - createhome: False
    - system: Ture

install_dep_pkg:
  cmd.run:
    - name: yum install gcc gcc-c++ cmake make openldap openldap-devel  libxslt libsxlt-devel  libxslt-devel gd-devel libxml2-devel curl-devel libpng-devel libjpeg-turbo-devel freetype-devel libmcrypt-devel libmcrypt php-mbstring mhash-devel libcurl-devel pcre-devel openssl-devel ncurses-devel bison-devel zlib-devel mysql-server -y &>/dev/null
    
install_php_source:
  cmd.run:
    - name: cp -frp /usr/lib64/libldap* /usr/lib/ && cd /tmp && rm -rf php-5.6.16 && tar -zxf php-5.6.16.tar.gz && cd php-5.6.16 && mkdir -p {{php_install_dir }} && ./configure --prefix={{php_install_dir}}/php {{configure_args}} &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - cmd: install_dep_pkg
      - file: /tmp/php-5.6.16.tar.gz
    - unless: test -e {{php_install_dir}}/php/bin/php

install_libmemcached:
  cmd.run:
    - name: cd /tmp && rm -rf libmemcached-1.0.18 && tar -zxf libmemcached-1.0.18.tar.gz && cd libmemcached-1.0.18 && ./configure --prefix=/usr/local/libmemcached --with-memcached &>/dev/null && make &>/dev/null && make install
    - required:
      - file: /tmp/libmemcached-1.0.18.tar.gz
      - cmd: install_pkg_memcached
    - unless: test -d /usr/local/libmemcached

install_pkg_memcached:
  cmd.run:
    - name: yum install memcached php-devel -y



install_php_memcache:
  cmd.run:
    - name: cd /tmp && rm -rf memcache-3.0.5 && tar -zxf memcache-3.0.5.tgz && cd memcache-3.0.5 && {{php_install_dir}}/php/bin/phpize &>/dev/null && ./configure --with-php-config={{php_install_dir}}/php/bin/php-config --enable-memcache &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/memcache-3.0.5.tgz
      - cmd: install_php_source
    - unless: find {{php_install_dir}}/php -name 'memcache.so'|grep 'memcache.so' &>/dev/null

install_php_memcached:
  cmd.run:
    - name: cd /tmp && rm -rf php-memcached && tar -zxf php-memcached.tar.gz && cd php-memcached && {{php_install_dir}}/php/bin/phpize &>/dev/null && ./configure --with-php-config={{php_install_dir}}/php/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/php-memcached.tar.gz 
      - cmd: install_php_source
    - unless: find {{php_install_dir}}/php -name 'memcached.so'|grep 'memcached.so' &>/dev/null

install_php_redis:
  cmd.run:
    - name: cd /tmp && rm -rf phpredis-2.2.4 && tar -zxf phpredis-2.2.4.tar.gz && cd phpredis-2.2.4 && {{php_install_dir}}/php/bin/phpize &>/dev/null && ./configure --with-php-config={{php_install_dir}}/php/bin/php-config --enable-redis &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/phpredis-2.2.4.tar.gz 
      - cmd: install_php_source
    - unless: find {{php_install_dir}}/php -name 'redis.so'|grep 'redis.so' &>/dev/null

copy_php_ini:
  file.managed:
    - source: salt://php/files/php.ini
    - name: {{php_install_dir}}/php/lib/php.ini
    - mode: 755
    - user: www
    - required:
      - cmd: install_php_source

copy_php_fpm:
  file.managed:
    - source: salt://php/files/php-fpm.conf
    - name: {{php_install_dir}}/php/etc/php-fpm.conf
    - mode: 755
    - user: www
    - required:
      - cmd: install_php_source
  
  


