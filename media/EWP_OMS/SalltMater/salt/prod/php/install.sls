pkg-php:
    pkg.installed:
        - names:
          - mysql-devel
          - openssl-devel
          - swig
          - libjpeg-turbo
          - libjpeg-turbo-devel
          - libpng
          - libpng-devel
          - freetype
          - freetype-devel
          - libxml2
          - libxml2-devel
          - zlib
          - zlib-devel
          - libcurl
          - libcurl-devel
php-source-install:
    file.managed:
        - name: /usr/local/src/php-5.6.9.tar.gz
        - source: salt://php/files/php-5.6.9.tar.gz
        - user: root
        - group: root
        - mode: 755
    cmd.run:
        - name: cd /usr/local/src && tar zxf php-5.6.9.tar.
php-5.6.9&&  ./configure --prefix=/usr/local/php-fastcgi
--with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql
--with-jpeg-dir --with-png-dir --with-zlib --enable-xml
--with-libxml-dir --with-curl --enable-bcmath --enable-shmo
--enable-sysvsem  --enable-inline-optimization --enable-mbr
--with-openssl --enable-mbstring --with-gd --enable-gd-nati
--with-freetype-dir=/usr/lib64 --with-gettext=/usr/lib64
--enable-sockets --with-xmlrpc --enable-zip --enable-soap
--disable-debug --enable-opcache --enable-zip
--with-config-file-path=/usr/local/php-fastcgi/etc --enable
--with-fpm-user=www --with-fpm-group=www && make && make in
        - require:
          - file: php-source-install
          - user: www-user-group
        - unless: test -d /usr/local/php-fastcgi
pdo-plugin:
    cmd.run:
        - name: cd /usr/local/src/php-5.6.9/ext/pdo_mysql/ 
/usr/local/php-fastcgi/bin/phpize && ./configure
--with-php-config=/usr/local/php-fastcgi/bin/php-config && 
install
        - unless: test -f
/usr/local/php-fastcgi/lib/php/extensions/*/pdo_mysql.so
        - require:
          - cmd: php-source-install
php-ini:
    file.managed:
        - name: /usr/local/php-fastcgi/etc/php.ini
        - source: salt://php/files/php.ini-production
        - user: root
        - group: root
        - mode: 644
php-fpm:
    file.managed:
        - name: /usr/local/php-fastcgi/etc/php-fpm.conf
        - source: salt://php/files/php-fpm.conf.default
        - user: root
        - group: root
        - mode: 644
php-fastcgi-service:
    file.managed:
        - name: /etc/init.d/php-fpm
        - source: salt://php/files/init.d.php-fpm
        - user: root
        - group: root
        - mode: 755
    cmd.run:
        - name: chkconfig --add php-fpm
        - unless: chkconfig --list | grep php-fpm
        - require:
          - file: php-fastcgi-service
    service.running:
        - name: php-fpm
        - enable: True
        - require:
          - cmd: php-fastcgi-service
        - watch:
          - file: php-ini
          - file: php-fpm