install.sls
#将PCRE的安装包含进来
include:
    - pcre.install
    - user.www
#Nginx编译安装
nginx-source-install:
    file.managed:
        - name: /usr/local/src/nginx-1.9.1.tar.gz
        - source: salt://nginx/files/nginx-1.9.1.tar.gz
        - user: root
        - group: root
        - mode: 755
    cmd.run:
        - name: cd /usr/local/src && tar zxf nginx-1.9.1.ta
--with-file-aio --with-http_dav_module
--with-pcre=/usr/local/src/pcre-8.37 && make && make instal
www:www /usr/local/nginx
        - unless: test -d /usr/local/nginx
        - require:
          - user: www-user-group
          - file: nginx-source-install
          - pkg: pkg-init
          - cmd: pcre-source-install