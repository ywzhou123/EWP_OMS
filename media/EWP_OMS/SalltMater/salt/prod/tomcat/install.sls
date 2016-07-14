{%set jdk_install_dir= '/webdata/opt/local' %}
{%set tomcat_install_dir= '/webdata/opt/local' %}

include:
  - epel.install
/tmp/apache-tomcat-7.0.54.tar.gz:
  file.managed:
    - source: salt://tomcat/files/apache-tomcat-7.0.54.tar.gz
    - mode: 755
    - user: root
    - unless: ls -l /tmp/apache-tomcat-7.0.54.tar.gz

/tmp/jdk-7u71-linux-i586.tar.gz:
  file.managed:
    - source: salt://tomcat/files/jdk-7u71-linux-i586.tar.gz
    - mode: 755
    - root: root
    - unless: ls -l /tmp/jdk-7u71-linux-i586.tar.gz

install_jdk:
  cmd.run:
    - name: cd /tmp && rm -rf jdk1.7.0_71 && tar -zxf jdk-7u71-linux-i586.tar.gz &>/dev/null && mkdir -p {{ jdk_install_dir }} && mv jdk1.7.0_71 {{ jdk_install_dir }}/jdk7
    - required:
      file: /tmp/jdk-7u71-linux-i586.tar.gz
    - unless: test -e {{jdk_install_dir}}/jdk7/bin/java  

install_tomcat:
  cmd.run:
    - name: cd /tmp && rm -rf apache-tomcat-7.0.54 && tar -zxf apache-tomcat-7.0.54.tar.gz &>/dev/null && mkdir -p {{ tomcat_install_dir }} && mv apache-tomcat-7.0.54  {{ tomcat_install_dir }}/tomcat7
    - required:
      file: /tmp/apache-tomcat-7.0.54.tar.gz
    - unless: test -d {{tomcat_install_dir}}/tomcat7/bin

init_env_var:
  cmd.run:
    - name: echo "JAVA_HOME={{ jdk_install_dir }}/jdk7" >>/etc/profile && echo "JRE_HOME={{ jdk_install_dir }}/jdk7/jre" >>/etc/profile && echo 'CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib' >>/etc/profile && echo 'PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >>/etc/profile
    - required:
      - file: /tmp/jdk-7u71-linux-i586.tar.gz
      - file: /tmp/apache-tomcat-7.0.54.tar.gz
    - unless: grep 'JAVA_HOME' /etc/profile &>/dev/null && grep 'JRE_HOME' /etc/profile &>/dev/null && grep 'CLASSPATH' /etc/profile &>/dev/null

install_dep_pkg:
  cmd.run:
    - name: yum install glibc glibc-devel glibc-static glibc-common glibc-headers glibc*.i686 -y &>/dev/null
