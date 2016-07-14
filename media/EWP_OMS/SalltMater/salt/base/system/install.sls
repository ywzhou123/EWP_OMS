
/etc/profile:
  cmd.run:
    - name: echo 'HISTTIMEFORMAT="%F %T `whoami`"' >>/etc/profile
    - unless: grep HISTTIMEFORMAT /etc/profile &>/dev/null 

install_lrzsz:
  cmd.run:
    - name: yum install lrzsz -y &>/dev/null
    - unless: rpm -qa|grep lrzsz

net.ipv4.conf.default.accept_source_route:
  sysctl.present:
    - value: 0
kernel.core_uses_pid:
  sysctl.present:
    - value: 1
vm.swappiness:
  sysctl.present:
    - value: 0
net.ipv4.tcp_tw_reuse:
  sysctl.present:
    - value: 1
net.ipv4.tcp_tw_recycle:
  sysctl.present:
    - value: 1
net.ipv4.tcp_fin_timeout:
  sysctl.present:
    - value: 15
net.ipv4.tcp_keepalive_time:
  sysctl.present:
    - value: 1200
net.ipv4.ip_local_port_range:
  sysctl.present:
    - value: 1024 65532
net.core.netdev_max_backlog:
  sysctl.present:
    - value: 30000
net.ipv4.tcp_timestamps:
  sysctl.present:
    - value: 0


