# 把PHP和Nginx的安装都引用进来
include:
  - php.install
  - nginx.service
# 管理Nginx配置文件即可
web-bbs:
    file.managed:
        - name: /usr/local/nginx/conf/vhost/bbs.conf
        - source: salt://web/files/bbs.conf
        - user: root
        - group: root
        - mode: 644
        - require:
          - service: php-fastcgi-service
        - watch_in:
          - service: nginx-service