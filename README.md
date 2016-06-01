# EWP_OMS
>自动化运维系统（saltstack+django+bootstrap），QQ群342844540，博客http://ywzhou.blog.51cto.com/2785388/d-9

## 导入数据库文件:
>    root密码abc@123
>    进入MySQL Command Line Client
>    >show databases;
>    >create database ewp_oms;
>    >use ewp_oms;
>    >source /path/ewp_oms.sql;

## EWP_OMS_v2版本说明：

###  与v1版本（OMS）比较：
>    V1使用的是salt的python api，即本地API，再通过rpyc异步传输；
>    V2改用salt的RSET API，通过http协议通迅。

###  目前已实现功能：
>    CMDB资产管理：
>      －机房：设备统计
>      －硬件服务器：详细信息、主机统计、过滤、数据采集（grains)
>      －操作主机：详细信息、过滤、搜索、初始化安装(salt-ssh minion模块）、数据采集(grains)
>      －网络设备：WEB链接、过滤
>      －操作系统：主机统计
>    SALT配置管理：
>      －认证管理：管理key的接受和删除
>      －接口配置：SALT MASTER端RSET API接口信息，关联机房，多master时配置一个为master角色即可。
>      －命令执行：
>        －目标选择：client、target类型均可选，同步异步命令均可执行，目标主机通过manage.status命令获取在线minions；
>        －命令选择：模块+命令选择框级联；
>        －结果展示：命令通过异步执行时，先展示JID，再向后台请求JID详细结果并使用jsonformat格式化展示；结果保存在mysql中；
>      －命令结果：读取mysql中的执行命令历史记录并展示；结果为空时条目背景为红色否则绿色。
>      －本地文件：WEB端的本地文件管理（media目录），实现返回上层目录、创建、删除、改名、上传、下载（有些文件要右键另存不知为啥）、保存功能（移动不太好加，涉及SVN问题），
                   以及结合SVN，实现版本信息显示、提交（增删改）、更新、还原、签出功能；对文件读取做了后缀格式限制和文件大小限制；
                   还可以增加推送功能（cp.get_url）；
>      －远程文件（需要修改）：
>        －目标选择：根据条件过滤或搜索目标主机；
>        －文件查看：搜索路径搜索目标主机文件，实现返回上层（..)、判断是目录还是文件、文件内容展示，用的是实时返回，需要对文件格式、大小做限制；
                    计划增加字符替换功能或保存功能（对网络和后端稍有压力）
>      －代码发布（待开发）：项目开发一般使用svn或git，这里以SVN项目发布为例，实现新建项目（项目名称、项目主机、项目路径、SVN地址、SVN账号、
                            SVN密码、备注信息）、发布管理（副本状态、SVN信息、SVN更新、SVN提交、SVN分支、SVN还原等）、操作记录等功能；

##  近期规划：
>    Zabbix监控
>    Cobber初装

##  长远规划：
>    Docker容器
>    OpenStack云
>    ELK日志