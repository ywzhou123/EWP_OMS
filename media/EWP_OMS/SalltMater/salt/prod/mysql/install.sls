{% set mysql_install_dir = '/webdata/opt/local' %}
{% set configure_args= '-DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DENABLED_LOCAL_INFILE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSET=utf8 -DWITH_USER=mysql -DWITH_EMBEDDED_SERVER=OFF' %}

include:
  - epel.install

/tmp/mysql-5.6.10.tar.gz:
  file.managed:
    - source: salt://mysql/files/mysql-5.6.10.tar.gz
    - mode: 755
    - user: root
    - unless: test -e /tmp/mysql-5.6.10.tar.gz 

install_dep_pkg:
  cmd.run: 
    - name: yum install ncurses-devel zlib-devel perl-DBI perl-DBD-mysql perl-Time-HiRes perl-IO-Socket-SSL perl-Term-ReadKey cmake -y &>/dev/null
 
install_mysql_source:
  cmd.run: 
    - name: cd /tmp && rm -rf mysql-5.6.10 && tar -zxf mysql-5.6.10.tar.gz && cd mysql-5.6.10 && mkdir -p {{mysql_install_dir}} && cmake -DCMAKE_INSTALL_PREFIX={{mysql_install_dir}}/mysql -DMYSQL_DATADIR={{mysql_install_dir}}/mysql/data {{configure_args}} &>/dev/null && make &>/dev/null && make install &>/dev/null
    - required:
      - file: /tmp/mysql-5.6.10.tar.gz
    - unless: test -e {{mysql_install_dir}}/mysql/bin/mysqld

add_mysql_user:
  user.present:
    - name: mysql
    - system: Ture
    - shell: /sbin/nologin
    - gid_from_name: Ture
    - createhome: False
    
/etc/my.cnf:
  file.managed:
    - source: salt://mysql/files/my.cnf
    - mode: 755
    - user: root
    - template: jinja
    - defaults:
        datadir: {{mysql_install_dir}}/mysql/data
        basedir: {{mysql_install_dir}}/mysql

/etc/init.d/mysqld:
  file.managed:
    - source: salt://mysql/files/mysqld
    - template: jinja
    - defaults:
        datadir: {{mysql_install_dir}}/mysql/data
        basedir: {{mysql_install_dir}}/mysql
    - mode: 755
    - user: root

init_mysql_data:
  cmd.run: 
    - name: cd {{mysql_install_dir}}/mysql && ./scripts/mysql_install_db --user=mysql --datadir={{mysql_install_dir}}/mysql/data  --basedir={{mysql_install_dir}}/mysql &>/dev/null
    - required:
      - cmd: install_mysql_source
    - unless: test -e {{mysql_install_dir}}/mysql/data/mysql/user.frm

add_chkconfig:
  cmd.run: 
    - name: chkconfig --level 35 mysqld on 
    - required:
      - file: /etc/init.d/mysqld
    - unless: chkconfig --list|grep mysqld &>/dev/null
    
    
chown_mysql_dir:
  cmd.run:
    - name: chown -R mysql.mysql {{mysql_install_dir }}/mysql && chown -R mysql.mysql {{mysql_install_dir}}/mysql/data
    - required:
      - cmd: install_mysql_source
      - user: add_mysql_user

