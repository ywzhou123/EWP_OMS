# EWP_OMS
>自动化运维系统（saltstack+django+bootstrap），QQ群342844540，博客http://ywzhou.blog.51cto.com/2785388/d-9

## 数据库:

>进入MySQL Command Line Client

>show databases;

>create database ewp_oms;

>use ewp_oms;

>进入项目路径执行数据库同步

>python manage.py migrate

## EWP_OMS_v2版本说明：

### 与v1版本（OMS）比较：
>V1使用的是salt的python api，即本地API，再通过rpyc异步传输；

>V2改用salt的RSET API，通过http协议通迅。

###  目前已实现功能：
>CMDB资产管理：

>>－机房：设备统计
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/idc.png?raw=true)
>>－硬件服务器：详细信息、主机统计、过滤、数据采集（grains)
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/server.png?raw=true)
>>－操作主机：详细信息、过滤、搜索、初始化安装(salt-ssh minion模块）、数据采集(grains)
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/host.png?raw=true)
>>－网络设备：WEB链接、过滤
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/net.png?raw=true)
>>－操作系统：主机统计
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/system.png?raw=true)
>SALT配置管理：

>>－认证管理：管理key的接受和删除，新增Minions表，用于存储minion(key)、grains、pillar等信息。
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/key.png?raw=true)
>>－接口配置：SALT MASTER端RSET API接口信息，关联机房，多master时配置一个为master角色即可；
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/saltserver.png?raw=true)
        新增配置管理，实时获取环境、配置等信息
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/config.png?raw=true)
>>－命令执行：

>>>－目标选择：client、target类型均可选，同步异步命令均可执行，目标主机通过manage.status命令获取在线minions；

>>>－命令选择：模块+命令选择框级联；

>>>－结果展示：命令通过异步执行时，先展示JID，再向后台请求JID详细结果并使用jsonformat格式化展示；结果保存在mysql中；

>>>－命令结果：读取mysql中的执行命令历史记录并展示；结果为空时条目背景为红色否则绿色。
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/execute.png?raw=true)
>>－本地文件：WEB端的本地文件管理（media目录），实现返回上层目录、创建、删除、改名、上传、下载（有些文件要右键另存不知为啥）、保存功能（移动不太好加，涉及SVN问题），
                   以及结合SVN，实现版本信息显示、提交（增删改）、更新、还原、签出功能；对文件读取做了后缀格式限制和文件大小限制；
                   还可以增加推送功能（cp.get_url）；需要安装SVN模块：pip install svn
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/localfile.png?raw=true)
>>－远程文件：通过salt实现对客户端主机的文件系统管理，可以创建、删除、重命名文件或目录，可以修改文件内容，对文件的访问做了大小和格式的限制；
              如果是SVN副本还会显示版本信息；调用了代码发布功能，实现SVN副本的提交和更新。
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/remotefile.png?raw=true)
>>>－目标选择：根据条件过滤或搜索目标主机；

>>>－文件查看：搜索路径搜索目标主机文件，实现返回上层（..)、判断是目录还是文件、文件内容展示，用的是实时返回，需要对文件格式、大小做限制；
                    计划增加字符替换功能或保存功能（对网络和后端稍有压力）

>>－代码发布：项目开发一般使用svn或git，这里以SVN项目发布为例，新建项目（项目名称、项目主机、项目路径、SVN地址、SVN账号、SVN密码、状态、信息）；
              刷新页面会处理每个项目，获取本地副本信息、如未发布则checkout、如没未安装SVN则pkg.install；可对单个项目进行提交和更新；
              SVN模块命令需要手动添加：https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.svn.html
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/deploy.png?raw=true)
>>－应用部署（开发中）：本地文件管理页面进行sls模块编写、文件上传、提交，代码发布页面将SVN发布到master指定路径（/srv/salt），应用部署页面
                        列出所有sls模块，批量选择主机进行安装并记录结果。

>操作记录：

>>－执行记录：保存salt命令执行记录。
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/result.png?raw=true)
![](https://github.com/ywzhou123/EWP_OMS/tree/master/static/screen/resultinfo.png?raw=true)
## 近期规划：

>Zabbix监控

>Cobber初装



## 长远规划：

>Docker容器

>OpenStack云

>ELK日志