#内核参数优化
#设置本地TCP可以使用的端口范围
net.ipv4.ip_local_port_range:
  sysctl.present:
    - value: 10000 65000
#设置可以打开的最大文件数
fs.file-max:
  sysctl.present:
    - value: 2000000
#开启ip转发
net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
#尽量不使用交换分区
vm.swappiness:
  sysctl.present:
    - value: 0