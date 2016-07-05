{%set nginx_install_dir= '/webdata/opt/local' %}
{%set configure_args=' --user=www --group=www  --with-pcre --with-http_upstream_session_sticky_module=shared --with-http_upstream_ip_hash_module=shared  --with-http_sub_module  --with-http_spdy_module' %}
include:
  - epel.install


/tmp/jemalloc-4.0.4.tar.bz2:
  file.managed:
    - source: salt://nginx/files/jemalloc-4.0.4.tar.bz2
    - mode: 755
    - user: root
    - unless: test -e /tmp/jemalloc-4.0.4.tar.bz2

/tmp/tengine-2.1.1.tar.gz:
  file.managed:
    - source: salt://nginx/files/tengine-2.1.1.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/tengine-2.1.1.tar.gz

install_dep_pkgs:
  cmd.run:
    - name: yum install gcc gcc-c++ cmake make pcre-devel openssl-devel ncurses-devel openssl -y &>/dev/null

install_tengine:
  cmd.run:
    - name: cd /tmp && tar -jxf jemalloc-4.0.4.tar.bz2 &>/dev/null && tar -zxf tengine-2.1.1.tar.gz && mkdir -p {{ nginx_install_dir}} && cd tengine-2.1.1 && ./configure --prefix={{nginx_install_dir}}/nginx --with-jemalloc --with-jemalloc=/tmp/jemalloc-4.0.4 {{ configure_args }} &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/tengine-2.1.1.tar.gz
      - file: /tmp/jemalloc-4.0.4.tar.bz2
      - cmd: install_dep_pkgs
    - unless: test -e {{nginx_install_dir}}/nginx/sbin/nginx

add_run_user:
  user.present:
    - shell: /sbin/nologin
    - name: www
    - gid_from_name: Ture
    - createhome: False
    - system: Ture
    
