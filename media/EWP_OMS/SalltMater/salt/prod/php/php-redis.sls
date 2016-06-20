# wget https://pecl.php.net/get/redis-2.2.7.tgz
redis-plugin:
    file.managed:
        - name: /usr/local/src/phpredis-2.2.7.tgz
        - source: salt://php/files/phpredis-2.2.7.tgz
        - user: root
        - group: root
        - mode: 755
    cmd.run:
        -    name: cd /usr/local/src && tar zxf phpredis-2.
    phpredis-2.2.7&& /usr/local/php-fastcgi/bin/phpize && .
--with-php-config=/usr/local/php-fastcgi/bin/php-config && 
install
        -    unless: test -f /usr/local/php-fastcgi/lib/php
*/redis.so
require:
- file: redis-plugin
- cmd: php-install
/usr/local/php-fastcgi/etc/php.ini:
    file.append:
        - text:
          - extension=redis.so