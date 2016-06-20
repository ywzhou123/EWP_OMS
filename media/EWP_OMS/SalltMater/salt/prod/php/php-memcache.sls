# wget https://pecl.php.net/get/memcache-2.2.7.tgz
memcache-plugin:
    file.managed:
        - name: /usr/local/src/memcache-2.2.7.tgz
        - source: salt://php/files/memcache-2.2.7.tgz
        - user: root
        - group: root
        - mode: 755
    cmd.run:
        - name: cd /usr/local/src && tar zxf memcache-2.2.7
memcache-2.2.7&& /usr/local/php-fastcgi/bin/phpize && ./con
--enable-memcache
--with-php-config=/usr/local/php-fastcgi/bin/php-config && 
install
        - unless: test -f
/usr/local/php-fastcgi/lib/php/extensions/*/memcache.so
require:
        - file: memcache-plugin
        - cmd: php-install
/usr/local/php-fastcgi/etc/php.ini:
    file.append:
        - text:
          - extension=memcache.so