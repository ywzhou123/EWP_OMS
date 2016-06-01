-- MySQL dump 10.13  Distrib 5.7.10, for Win64 (x86_64)
--
-- Host: localhost    Database: ewp_oms
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add 机房',7,'add_idc'),(20,'Can change 机房',7,'change_idc'),(21,'Can delete 机房',7,'delete_idc'),(22,'Can add 系统类型',8,'add_systemtype'),(23,'Can change 系统类型',8,'change_systemtype'),(24,'Can delete 系统类型',8,'delete_systemtype'),(25,'Can add 主机组',9,'add_hostgroup'),(26,'Can change 主机组',9,'change_hostgroup'),(27,'Can delete 主机组',9,'delete_hostgroup'),(28,'Can add 主机详细信息',10,'add_hostdetail'),(29,'Can change 主机详细信息',10,'change_hostdetail'),(30,'Can delete 主机详细信息',10,'delete_hostdetail'),(31,'Can add 服务器',11,'add_server'),(32,'Can change 服务器',11,'change_server'),(33,'Can delete 服务器',11,'delete_server'),(34,'Can add 主机',12,'add_host'),(35,'Can change 主机',12,'change_host'),(36,'Can delete 主机',12,'delete_host'),(37,'Can add 网络设备',13,'add_network'),(38,'Can change 网络设备',13,'change_network'),(39,'Can delete 网络设备',13,'delete_network'),(40,'Can add Salt服务器',14,'add_saltserver'),(41,'Can change Salt服务器',14,'change_saltserver'),(42,'Can delete Salt服务器',14,'delete_saltserver'),(43,'Can add Salt模块',15,'add_module'),(44,'Can change Salt模块',15,'change_module'),(45,'Can delete Salt模块',15,'delete_module'),(46,'Can add Salt命令',16,'add_command'),(47,'Can change Salt命令',16,'change_command'),(48,'Can delete Salt命令',16,'delete_command'),(49,'Can add Salt目标类型',17,'add_targettype'),(50,'Can change Salt目标类型',17,'change_targettype'),(51,'Can delete Salt目标类型',17,'delete_targettype'),(55,'Can add 命令返回结果',19,'add_result'),(56,'Can change 命令返回结果',19,'change_result'),(57,'Can delete 命令返回结果',19,'delete_result');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$zRa3ky001QE4$MxMSl3GNhOoX/ygX4ccDOx7v1CrH788BJvJehJqb/gc=','2016-05-25 07:31:25',1,'admin','','','',1,1,'2016-04-13 02:05:49');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_30a071c9_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_host`
--

DROP TABLE IF EXISTS `cmdb_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_host` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `ip_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `system_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_id` (`ip_id`),
  KEY `CMDB_host_5dc6e1b7` (`server_id`),
  KEY `CMDB_host_d73c1934` (`system_type_id`),
  CONSTRAINT `CMDB_host_ip_id_3588cd4b_fk_CMDB_hostdetail_id` FOREIGN KEY (`ip_id`) REFERENCES `cmdb_hostdetail` (`id`),
  CONSTRAINT `CMDB_host_server_id_1febda6d_fk_CMDB_server_id` FOREIGN KEY (`server_id`) REFERENCES `cmdb_server` (`id`),
  CONSTRAINT `CMDB_host_system_type_id_717743f5_fk_CMDB_systemtype_id` FOREIGN KEY (`system_type_id`) REFERENCES `cmdb_systemtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_host`
--

LOCK TABLES `cmdb_host` WRITE;
/*!40000 ALTER TABLE `cmdb_host` DISABLE KEYS */;
INSERT INTO `cmdb_host` VALUES (1,'2016-04-13',1,'','',1,1,3),(2,'2016-04-13',1,'','',2,2,3),(3,'2016-04-13',1,'','',3,2,1),(4,'2016-04-13',1,'','',4,2,2),(5,'2016-04-13',1,'','',5,2,1),(6,'2016-04-27',1,'','',6,2,1),(7,'2016-05-25',1,'','',7,2,1);
/*!40000 ALTER TABLE `cmdb_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_host_group`
--

DROP TABLE IF EXISTS `cmdb_host_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_host_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_id` int(11) NOT NULL,
  `hostgroup_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host_id` (`host_id`,`hostgroup_id`),
  KEY `CMDB_host_group_hostgroup_id_694d6228_fk_CMDB_hostgroup_id` (`hostgroup_id`),
  CONSTRAINT `CMDB_host_group_host_id_74ba8c6c_fk_CMDB_host_id` FOREIGN KEY (`host_id`) REFERENCES `cmdb_host` (`id`),
  CONSTRAINT `CMDB_host_group_hostgroup_id_694d6228_fk_CMDB_hostgroup_id` FOREIGN KEY (`hostgroup_id`) REFERENCES `cmdb_hostgroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_host_group`
--

LOCK TABLES `cmdb_host_group` WRITE;
/*!40000 ALTER TABLE `cmdb_host_group` DISABLE KEYS */;
INSERT INTO `cmdb_host_group` VALUES (3,3,1),(4,3,3),(1,4,1),(2,4,2),(6,5,4),(9,6,1),(10,7,4);
/*!40000 ALTER TABLE `cmdb_host_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_hostdetail`
--

DROP TABLE IF EXISTS `cmdb_hostdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_hostdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` char(39) NOT NULL,
  `tgt_id` varchar(50) NOT NULL,
  `fqdn` varchar(50) NOT NULL,
  `domain` varchar(50) NOT NULL,
  `hwaddr_interfaces` varchar(150) NOT NULL,
  `cpu_model` varchar(50) NOT NULL,
  `kernel` varchar(50) NOT NULL,
  `os` varchar(50) NOT NULL,
  `osarch` varchar(50) NOT NULL,
  `osrelease` varchar(50) NOT NULL,
  `productname` varchar(50) NOT NULL,
  `serialnumber` varchar(50) NOT NULL,
  `server_id` varchar(50) NOT NULL,
  `virtual` varchar(50) NOT NULL,
  `salt_status` tinyint(1) NOT NULL,
  `zbx_status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_hostdetail`
--

LOCK TABLES `cmdb_hostdetail` WRITE;
/*!40000 ALTER TABLE `cmdb_hostdetail` DISABLE KEYS */;
INSERT INTO `cmdb_hostdetail` VALUES (1,'10.99.1.8','','','','','','','','','','','','','',0,0),(2,'10.188.1.36','','','','','','','','','','','','','',0,0),(3,'10.188.1.41','saltminion01-41.ewp.com','saltminion01-41.ewp.com','ewp.com','{u\'lo\': u\'00:00:00:00:00:00\', u\'eth0\': u\'f2:ab:53:d3:43:8c\'}','Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz','Linux','CentOS','x86_64','6.5','','','742001097','',1,0),(4,'10.188.1.42','saltminion02-42.ewp.com','saltminion02-42.ewp.com','ewp.com','{u\'Citrix PV Network Adapter #0\': u\'DE:C5:56:54:DB:DE\'}','Intel64 Family 6 Model 44 Stepping 2, GenuineIntel','Windows','Windows','','2008ServerR2','','','1650395528','',1,0),(5,'10.188.1.40','saltmaster-40.ewp.com','saltmaster-40.ewp.com','ewp.com','{u\'lo\': u\'00:00:00:00:00:00\', u\'eth0\': u\'9a:1e:fe:94:a7:6e\'}','Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz','Linux','CentOS','','6.5','','','2024588289','',1,0),(6,'10.188.1.43','saltminion03-43.ewp.com','','','','','','','','','','','','',1,0),(7,'10.188.1.50','','','','','','','','','','','','','',0,0);
/*!40000 ALTER TABLE `cmdb_hostdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_hostgroup`
--

DROP TABLE IF EXISTS `cmdb_hostgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_hostgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_hostgroup`
--

LOCK TABLES `cmdb_hostgroup` WRITE;
/*!40000 ALTER TABLE `cmdb_hostgroup` DISABLE KEYS */;
INSERT INTO `cmdb_hostgroup` VALUES (2,'iis'),(4,'master'),(1,'minion'),(3,'nginx');
/*!40000 ALTER TABLE `cmdb_hostgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_idc`
--

DROP TABLE IF EXISTS `cmdb_idc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_idc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `contact` varchar(100) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `cost` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_idc`
--

LOCK TABLES `cmdb_idc` WRITE;
/*!40000 ALTER TABLE `cmdb_idc` DISABLE KEYS */;
INSERT INTO `cmdb_idc` VALUES (1,'上海神舟机房','DX','上海市XX区XX路XX号','刘备','2016-04-13',NULL,'200元/月'),(2,'江西龙谷机房','DX','江西省XX市XX区XX街XX号','吕布','2016-04-13',NULL,'100元/月'),(3,'北京云雨机房','DX','北京市三里屯SOHO尤衣','17702130583','2016-06-01','2018-06-01','200元/月');
/*!40000 ALTER TABLE `cmdb_idc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_network`
--

DROP TABLE IF EXISTS `cmdb_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `brand` varchar(30) NOT NULL,
  `model` varchar(30) NOT NULL,
  `ip_out` char(39) DEFAULT NULL,
  `ip_in` char(39) DEFAULT NULL,
  `info` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `idc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_out` (`ip_out`),
  UNIQUE KEY `ip_in` (`ip_in`),
  KEY `CMDB_network_idc_id_7fed66f6_fk_CMDB_idc_id` (`idc_id`),
  CONSTRAINT `CMDB_network_idc_id_7fed66f6_fk_CMDB_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `cmdb_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_network`
--

LOCK TABLES `cmdb_network` WRITE;
/*!40000 ALTER TABLE `cmdb_network` DISABLE KEYS */;
INSERT INTO `cmdb_network` VALUES (1,'防火墙2','SANGFOR','AF2.0.77 SP1','23.102.3.28','10.99.1.1','出口路由器','https://23.102.3.28','','',1),(2,'防火墙1','SANGFOR','AF-520','202.101.124.68','10.188.1.1','出口路由器','https://202.101.124.68','','',2);
/*!40000 ALTER TABLE `cmdb_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_server`
--

DROP TABLE IF EXISTS `cmdb_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `location` varchar(30) NOT NULL,
  `start_date` date NOT NULL,
  `status` tinyint(1) NOT NULL,
  `idc_id` int(11) NOT NULL,
  `ip_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_id` (`ip_id`),
  KEY `CMDB_server_idc_id_4604c100_fk_CMDB_idc_id` (`idc_id`),
  CONSTRAINT `CMDB_server_idc_id_4604c100_fk_CMDB_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `cmdb_idc` (`id`),
  CONSTRAINT `CMDB_server_ip_id_5a999cf8_fk_CMDB_hostdetail_id` FOREIGN KEY (`ip_id`) REFERENCES `cmdb_hostdetail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_server`
--

LOCK TABLES `cmdb_server` WRITE;
/*!40000 ALTER TABLE `cmdb_server` DISABLE KEYS */;
INSERT INTO `cmdb_server` VALUES (1,'Open-Test-08','2-22U','2016-04-13',1,1,1),(2,'Ewin-Xen01-36','2-22U','2016-04-13',1,2,2);
/*!40000 ALTER TABLE `cmdb_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cmdb_systemtype`
--

DROP TABLE IF EXISTS `cmdb_systemtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cmdb_systemtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cmdb_systemtype`
--

LOCK TABLES `cmdb_systemtype` WRITE;
/*!40000 ALTER TABLE `cmdb_systemtype` DISABLE KEYS */;
INSERT INTO `cmdb_systemtype` VALUES (1,'Linux'),(4,'VMWare'),(2,'Windows'),(3,'Xen');
/*!40000 ALTER TABLE `cmdb_systemtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_5151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_1c5f563_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2016-04-13 02:06:10','1','上海神舟机房',1,'',7,1),(2,'2016-04-13 02:06:34','2','江西龙谷机房',1,'',7,1),(3,'2016-04-13 02:06:56','1','10.99.1.8',1,'',10,1),(4,'2016-04-13 02:07:08','1','Open-Test-08',1,'',11,1),(5,'2016-04-13 02:07:16','2','10.188.1.36',1,'',10,1),(6,'2016-04-13 02:07:28','2','Ewin-Xen01-36',1,'',11,1),(7,'2016-04-13 02:10:55','1','Linux',1,'',8,1),(8,'2016-04-13 02:11:01','2','Windows',1,'',8,1),(9,'2016-04-13 02:11:11','1','10.99.1.8',1,'',12,1),(10,'2016-04-13 02:11:18','2','10.188.1.36',1,'',12,1),(11,'2016-04-13 02:11:29','3','10.188.1.41',1,'',10,1),(12,'2016-04-13 02:11:42','3','10.188.1.41',1,'',12,1),(13,'2016-04-13 02:11:53','4','10.188.1.42',1,'',10,1),(14,'2016-04-13 02:12:04','1','minion',1,'',9,1),(15,'2016-04-13 02:12:08','2','iis',1,'',9,1),(16,'2016-04-13 02:12:13','4','10.188.1.42',1,'',12,1),(17,'2016-04-13 02:12:21','3','nginx',1,'',9,1),(18,'2016-04-13 02:12:24','3','10.188.1.41',2,'已修改 group 。',12,1),(19,'2016-04-13 03:02:09','1','EWP防火墙',1,'',13,1),(20,'2016-04-13 03:02:24','2','EWIN防火墙',1,'',13,1),(21,'2016-04-13 03:10:14','3','Xen',1,'',8,1),(22,'2016-04-13 03:10:22','4','VMWare',1,'',8,1),(23,'2016-04-13 03:10:47','1','10.99.1.8',2,'已修改 system_type 。',12,1),(24,'2016-04-13 03:10:52','2','10.188.1.36',2,'已修改 system_type 。',12,1),(25,'2016-04-13 03:16:55','1','TEST',1,'',15,1),(26,'2016-04-13 03:17:32','2','CMDMOD',1,'',15,1),(27,'2016-04-13 03:18:10','3','GRAINS',1,'',15,1),(28,'2016-04-13 03:18:43','4','SYSMOD',1,'',15,1),(29,'2016-04-13 03:19:57','1','test.ping',1,'',16,1),(30,'2016-04-13 03:20:02','2','cmd.run',1,'',16,1),(31,'2016-04-13 03:20:07','3','grains.items',1,'',16,1),(32,'2016-04-13 03:20:22','4','grains.item',1,'',16,1),(33,'2016-04-13 03:20:42','5','sys.doc',1,'',16,1),(43,'2016-04-13 03:30:33','1','glob',1,'',17,1),(44,'2016-04-13 03:30:38','2','pcre',1,'',17,1),(45,'2016-04-13 03:30:43','3','list',1,'',17,1),(46,'2016-04-13 03:30:47','4','grain',1,'',17,1),(47,'2016-04-13 03:30:52','5','grain_pcre',1,'',17,1),(48,'2016-04-13 03:30:56','6','pillar',1,'',17,1),(49,'2016-04-13 03:31:00','7','pillar_pcre',1,'',17,1),(50,'2016-04-13 03:31:03','8','nodegroup',1,'',17,1),(51,'2016-04-13 03:31:08','9','range',1,'',17,1),(52,'2016-04-13 03:31:13','10','compound',1,'',17,1),(53,'2016-04-13 05:56:44','5','10.188.1.40',1,'',10,1),(54,'2016-04-13 05:57:09','4','master',1,'',9,1),(55,'2016-04-13 05:57:14','5','10.188.1.40',1,'',12,1),(56,'2016-04-13 05:58:30','3','https://10.188.1.40:8000',1,'',14,1),(57,'2016-04-15 02:55:17','1','983240623497852',1,'',19,1),(58,'2016-04-15 02:57:12','1','983240623497852',2,'没有字段被修改。',19,1),(59,'2016-04-15 03:02:55','1','983240623497852',2,'已修改 user 。',19,1),(60,'2016-04-15 03:03:15','2','22323232',1,'',19,1),(61,'2016-04-15 03:04:59','3','3',1,'',19,1),(62,'2016-04-15 05:38:10','3','https://111.75.222.136:8000',2,'已修改 url 。',14,1),(63,'2016-04-18 01:58:19','3','https://111.75.222.136:8001',2,'已修改 url 。',14,1),(64,'2016-04-18 02:02:04','3','https://111.75.222.136:8000',2,'已修改 url 。',14,1),(65,'2016-04-18 06:32:14','4','10.188.1.42',2,'已修改 tgt_id 。',10,1),(66,'2016-04-18 06:32:29','5','10.188.1.40',2,'已修改 tgt_id 。',10,1),(67,'2016-04-18 06:32:32','5','10.188.1.40',2,'没有字段被修改。',12,1),(68,'2016-04-18 07:12:26','4','10.188.1.42',2,'没有字段被修改。',10,1),(70,'2016-04-19 02:37:49','6','cmd.script',1,'',16,1),(71,'2016-04-19 02:45:33','7','cmd.shell',1,'',16,1),(72,'2016-04-20 01:39:05','5','SVN',1,'',15,1),(73,'2016-04-20 01:44:55','8','svn.checkout',1,'',16,1),(74,'2016-04-20 01:45:05','9','svn.add',1,'',16,1),(75,'2016-04-20 01:45:10','10','svn.commit',1,'',16,1),(76,'2016-04-20 01:45:22','11','svn.diff',1,'',16,1),(77,'2016-04-20 01:45:30','12','svn.info',1,'',16,1),(78,'2016-04-20 01:45:48','13','svn.remove',1,'',16,1),(79,'2016-04-20 01:46:01','14','svn.status',1,'',16,1),(80,'2016-04-20 01:46:18','15','svn.switch',1,'',16,1),(81,'2016-04-20 01:46:28','16','svn.update',1,'',16,1),(82,'2016-04-20 02:13:32','6','STATE',1,'',15,1),(83,'2016-04-20 02:13:57','17','state.sls',1,'',16,1),(84,'2016-04-20 02:14:29','18','state.highstate',1,'',16,1),(85,'2016-04-20 02:14:54','19','state.running',1,'',16,1),(86,'2016-04-27 03:04:44','6','10.188.1.43',1,'',10,1),(87,'2016-04-27 03:04:55','6','10.188.1.43',1,'',12,1),(88,'2016-04-27 03:15:53','6','10.188.1.43',2,'已修改 salt_status 。',10,1),(89,'2016-04-27 03:15:56','6','10.188.1.43',2,'没有字段被修改。',12,1),(90,'2016-04-27 03:32:34','6','10.188.1.43',2,'已修改 salt_status 。',10,1),(91,'2016-04-27 03:32:36','6','10.188.1.43',2,'没有字段被修改。',12,1),(92,'2016-05-03 06:28:25','7','FILE',1,'',15,1),(93,'2016-05-03 06:29:33','20','file.readdir',1,'',16,1),(94,'2016-05-03 06:30:39','21','file.append',1,'',16,1),(95,'2016-05-03 06:31:08','22','file.basename',1,'',16,1),(96,'2016-05-03 06:35:30','23','file.directory_exists',1,'',16,1),(97,'2016-05-03 06:35:39','24','file.dirname',1,'',16,1),(98,'2016-05-03 06:35:47','25','file.diskusage',1,'',16,1),(99,'2016-05-03 06:36:23','26','file.find',1,'',16,1),(100,'2016-05-03 06:43:38','27','file.get_managed',1,'',16,1),(101,'2016-05-03 06:43:48','28','file.get_mode',1,'',16,1),(102,'2016-05-03 06:44:46','29','file.grep',1,'',16,1),(103,'2016-05-03 06:45:54','30','file.join',1,'',16,1),(104,'2016-05-03 06:46:17','31','file.lchown',1,'',16,1),(105,'2016-05-03 06:46:26','32','file.line',1,'',16,1),(106,'2016-05-03 06:47:31','33','file.link',1,'',16,1),(107,'2016-05-03 06:48:25','34','file.makedirs',1,'',16,1),(108,'2016-05-03 06:48:51','35','file.manage_file',1,'',16,1),(109,'2016-05-03 06:49:32','36','file.mkdir',1,'',16,1),(110,'2016-05-03 06:49:46','37','file.move',1,'',16,1),(111,'2016-05-03 06:50:18','38','file.open_files',1,'',16,1),(112,'2016-05-03 06:51:37','39','file.prepend',1,'',16,1),(113,'2016-05-03 06:52:33','40','file.psed',1,'',16,1),(114,'2016-05-03 06:56:27','41','file.remove',1,'',16,1),(115,'2016-05-03 06:56:36','42','file.rename',1,'',16,1),(116,'2016-05-03 06:56:43','43','file.replace',1,'',16,1),(117,'2016-05-03 06:57:37','44','file.restore_backup',1,'',16,1),(118,'2016-05-03 06:58:02','45','file.search',1,'',16,1),(119,'2016-05-03 06:58:44','46','file.sed',1,'',16,1),(120,'2016-05-03 07:01:15','47','file.touch',1,'',16,1),(121,'2016-05-03 07:02:26','48','file.write',1,'',16,1),(122,'2016-05-19 05:22:41','3','https://10.188.1.40:8000',2,'已修改 url 。',14,1),(123,'2016-05-25 02:46:28','7','10.188.1.50',1,'',10,1),(124,'2016-05-25 02:47:04','7','10.188.1.50',1,'',12,1),(125,'2016-05-25 02:47:19','3','https://10.188.1.50:8000',2,'已修改 ip 和 url 。',14,1),(126,'2016-05-25 02:47:57','4','https://10.188.1.40:8000',1,'',14,1),(127,'2016-05-26 02:33:11','4','https://10.188.1.40:8000',3,'',14,1),(128,'2016-05-27 06:39:36','3','https://10.188.1.39:8000',2,'已修改 url 。',14,1),(129,'2016-05-27 06:49:08','2','江西龙谷机房 - https://10.188.1.39:8000 - Master',2,'已修改 idc 和 role 。',14,1),(130,'2016-05-31 02:28:44','8','manage',1,'',15,1),(131,'2016-05-31 02:29:10','49','manage.status',1,'',16,1),(132,'2016-05-31 02:29:25','8','MANAGE',2,'已修改 name 。',15,1),(133,'2016-05-31 02:29:31','50','manage.up',1,'',16,1),(134,'2016-05-31 02:29:38','51','manage.down',1,'',16,1),(135,'2016-05-31 02:38:17','9','KEY',1,'',15,1),(136,'2016-05-31 07:31:25','52','KEY - key.list',1,'',16,1),(137,'2016-05-31 07:36:11','52','KEY - key.list_all',2,'已修改 cmd 。',16,1),(138,'2016-05-31 07:45:14','53','MANAGE - manage.versions',1,'',16,1),(139,'2016-05-31 07:47:11','10','saltutil',1,'',15,1),(140,'2016-05-31 07:50:07','54','STATE - state.show_sls',1,'',16,1),(141,'2016-05-31 07:50:32','55','STATE - state.show_top',1,'',16,1),(142,'2016-05-31 07:51:23','56','STATE - state.top',1,'',16,1),(143,'2016-05-31 08:00:40','10','SALTUTIL',2,'已修改 name 。',15,1),(144,'2016-06-01 02:46:07','3','北京云雨机房',1,'',7,1),(145,'2016-06-01 04:04:07','2','EWIN防火墙',2,'已修改 ip_out 和 url 。',13,1),(146,'2016-06-01 04:04:17','2','防火墙1',2,'已修改 name 。',13,1),(147,'2016-06-01 04:04:54','1','防火墙2',2,'已修改 name，ip_out 和 url 。',13,1),(148,'2016-06-01 04:04:59','2','防火墙1',2,'已修改 url 。',13,1),(149,'2016-06-01 04:05:04','2','防火墙1',2,'已修改 url 。',13,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(12,'CMDB','host'),(10,'CMDB','hostdetail'),(9,'CMDB','hostgroup'),(7,'CMDB','idc'),(13,'CMDB','network'),(11,'CMDB','server'),(8,'CMDB','systemtype'),(5,'contenttypes','contenttype'),(16,'SALT','command'),(15,'SALT','module'),(19,'SALT','result'),(14,'SALT','saltserver'),(17,'SALT','targettype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'CMDB','0001_initial','2016-04-13 02:04:05'),(2,'contenttypes','0001_initial','2016-04-13 02:04:06'),(3,'auth','0001_initial','2016-04-13 02:04:17'),(4,'admin','0001_initial','2016-04-13 02:04:23'),(5,'contenttypes','0002_remove_content_type_name','2016-04-13 02:04:25'),(6,'auth','0002_alter_permission_name_max_length','2016-04-13 02:04:26'),(7,'auth','0003_alter_user_email_max_length','2016-04-13 02:04:27'),(8,'auth','0004_alter_user_username_opts','2016-04-13 02:04:27'),(9,'auth','0005_alter_user_last_login_null','2016-04-13 02:04:28'),(10,'auth','0006_require_contenttypes_0002','2016-04-13 02:04:28'),(11,'sessions','0001_initial','2016-04-13 02:04:29'),(12,'CMDB','0002_auto_20160413_1113','2016-04-13 03:13:28'),(13,'SALT','0001_initial','2016-04-13 03:13:32'),(14,'SALT','0002_result','2016-04-15 02:15:47'),(15,'SALT','0003_auto_20160415_1054','2016-04-15 02:54:15'),(16,'SALT','0004_auto_20160415_1056','2016-04-15 02:57:01'),(17,'SALT','0005_auto_20160415_1102','2016-04-15 03:02:19'),(18,'SALT','0006_auto_20160415_1104','2016-04-15 03:04:47'),(19,'SALT','0007_auto_20160415_1130','2016-04-15 03:30:51'),(20,'SALT','0008_result_result','2016-04-15 05:28:39'),(21,'CMDB','0003_auto_20160418_0856','2016-04-18 00:56:57'),(22,'SALT','0009_auto_20160418_1646','2016-04-18 08:46:07'),(23,'SALT','0010_auto_20160419_0943','2016-04-19 01:43:31'),(24,'SALT','0011_upload','2016-04-20 08:32:15'),(25,'SALT','0012_saltserver_status','2016-05-25 03:03:23'),(26,'SALT','0013_auto_20160526_1139','2016-05-26 03:39:32'),(27,'SALT','0014_auto_20160527_1443','2016-05-27 06:43:35'),(28,'SALT','0015_auto_20160527_1448','2016-05-27 06:48:54'),(29,'SALT','0016_auto_20160530_1510','2016-05-30 07:11:08'),(30,'SALT','0017_auto_20160531_1104','2016-05-31 03:04:08');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4w76qf0iyhphtd3h5dvw0imphpcxf60p','N2YzZjYzOTE1MjhhYzdmNmZjNTFhMGJiNjY3MDI1NDQ0YTAwMjIwZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjU2MzU5ZDc4OTAzMGVhOTBiNmZlYzhlMmRhZTY0ODExNTg0ODBhNGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-06-08 07:31:25'),('frrc8eh5llyq3ebmvczyc1j7d1snqvqr','N2YzZjYzOTE1MjhhYzdmNmZjNTFhMGJiNjY3MDI1NDQ0YTAwMjIwZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjU2MzU5ZDc4OTAzMGVhOTBiNmZlYzhlMmRhZTY0ODExNTg0ODBhNGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-04-27 02:05:55'),('omav8od1gbnnhitrdmj8k9c34e7izilj','N2YzZjYzOTE1MjhhYzdmNmZjNTFhMGJiNjY3MDI1NDQ0YTAwMjIwZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjU2MzU5ZDc4OTAzMGVhOTBiNmZlYzhlMmRhZTY0ODExNTg0ODBhNGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-05-11 02:12:56'),('yywgabrmhd93c6oambr5amy03136rxmc','N2YzZjYzOTE1MjhhYzdmNmZjNTFhMGJiNjY3MDI1NDQ0YTAwMjIwZDp7Il9hdXRoX3VzZXJfaGFzaCI6IjU2MzU5ZDc4OTAzMGVhOTBiNmZlYzhlMmRhZTY0ODExNTg0ODBhNGEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2016-05-25 06:29:23');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salt_command`
--

DROP TABLE IF EXISTS `salt_command`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salt_command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cmd` varchar(40) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cmd` (`cmd`),
  KEY `SALT_command_c9799665` (`module_id`),
  CONSTRAINT `SALT_command_module_id_27be132e_fk_SALT_module_id` FOREIGN KEY (`module_id`) REFERENCES `salt_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salt_command`
--

LOCK TABLES `salt_command` WRITE;
/*!40000 ALTER TABLE `salt_command` DISABLE KEYS */;
INSERT INTO `salt_command` VALUES (1,'test.ping',1),(2,'cmd.run',2),(3,'grains.items',3),(4,'grains.item',3),(5,'sys.doc',4),(6,'cmd.script',2),(7,'cmd.shell',2),(8,'svn.checkout',5),(9,'svn.add',5),(10,'svn.commit',5),(11,'svn.diff',5),(12,'svn.info',5),(13,'svn.remove',5),(14,'svn.status',5),(15,'svn.switch',5),(16,'svn.update',5),(17,'state.sls',6),(18,'state.highstate',6),(19,'state.running',6),(20,'file.readdir',7),(21,'file.append',7),(22,'file.basename',7),(23,'file.directory_exists',7),(24,'file.dirname',7),(25,'file.diskusage',7),(26,'file.find',7),(27,'file.get_managed',7),(28,'file.get_mode',7),(29,'file.grep',7),(30,'file.join',7),(31,'file.lchown',7),(32,'file.line',7),(33,'file.link',7),(34,'file.makedirs',7),(35,'file.manage_file',7),(36,'file.mkdir',7),(37,'file.move',7),(38,'file.open_files',7),(39,'file.prepend',7),(40,'file.psed',7),(41,'file.remove',7),(42,'file.rename',7),(43,'file.replace',7),(44,'file.restore_backup',7),(45,'file.search',7),(46,'file.sed',7),(47,'file.touch',7),(48,'file.write',7),(49,'manage.status',8),(50,'manage.up',8),(51,'manage.down',8),(52,'key.list_all',9),(53,'manage.versions',8),(54,'state.show_sls',6),(55,'state.show_top',6),(56,'state.top',6);
/*!40000 ALTER TABLE `salt_command` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salt_module`
--

DROP TABLE IF EXISTS `salt_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salt_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salt_module`
--

LOCK TABLES `salt_module` WRITE;
/*!40000 ALTER TABLE `salt_module` DISABLE KEYS */;
INSERT INTO `salt_module` VALUES (2,'CMDMOD'),(7,'FILE'),(3,'GRAINS'),(9,'KEY'),(8,'MANAGE'),(10,'SALTUTIL'),(6,'STATE'),(5,'SVN'),(4,'SYSMOD'),(1,'TEST');
/*!40000 ALTER TABLE `salt_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salt_result`
--

DROP TABLE IF EXISTS `salt_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salt_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `arg` varchar(255) NOT NULL,
  `jid` varchar(50) NOT NULL,
  `minions` varchar(500) NOT NULL,
  `user` varchar(50) NOT NULL,
  `datetime` datetime NOT NULL,
  `client` varchar(20) NOT NULL,
  `fun` varchar(50) NOT NULL,
  `tgt_type` varchar(20) NOT NULL,
  `idc_id` int(11) NOT NULL,
  `result` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salt_result`
--

LOCK TABLES `salt_result` WRITE;
/*!40000 ALTER TABLE `salt_result` DISABLE KEYS */;
INSERT INTO `salt_result` VALUES (117,'','20160417143402195201','saltminion01-41.ewp.com,saltminion02-42','admin','2016-04-17 06:33:29','local_async','test.ping','glob',2,'{\"saltminion02-42\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(119,'hostname','20160417160928873076','saltminion01-41.ewp.com','admin','2016-04-17 08:08:55','local_async','cmd.run','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": \"saltminion01-41.ewp.com\"}}'),(120,'','20160417175106155884','saltminion02-42,saltminion01-41.ewp.com','admin','2016-04-17 09:50:32','local_async','grains.items','list',2,'{\"saltminion02-42\": {\"return\": {\"biosversion\": \"Revision: 1.221\", \"kernel\": \"Windows\", \"domain\": \"ewp.com\", \"zmqversion\": \"4.1.2\", \"kernelrelease\": \"6.1.7600\", \"motherboard\": {\"serialnumber\": null, \"productname\": null}, \"pythonpath\": [\"c:\\\\salt\\\\bin\\\\Scripts\", \"c:\\\\salt\\\\bin\\\\python27.zip\", \"c:\\\\salt\\\\bin\\\\DLLs\", \"c:\\\\salt\\\\bin\\\\lib\", \"c:\\\\salt\\\\bin\\\\lib\\\\plat-win\", \"c:\\\\salt\\\\bin\\\\lib\\\\lib-tk\", \"c:\\\\salt\\\\bin\", \"c:\\\\salt\\\\bin\\\\lib\\\\site-packages\", \"c:\\\\salt\\\\bin\\\\lib\\\\site-packages\\\\win32\", \"c:\\\\salt\\\\bin\\\\lib\\\\site-packages\\\\win32\\\\lib\", \"c:\\\\salt\\\\bin\\\\lib\\\\site-packages\\\\Pythonwin\"], \"serialnumber\": \"21968ff9-05b8-26d0-1516-2400bf270c97\", \"ip_interfaces\": {\"Citrix PV Network Adapter #0\": [\"10.188.1.42\", \"fe80::9c8c:6ea5:58cb:8247\"]}, \"shell\": \"/bin/sh\", \"mem_total\": 2044, \"saltversioninfo\": [2015, 8, 3, 0], \"timezone\": \"(UTC+08:00)\\u5317\\u4eac\\uff0c\\u91cd\\u5e86\\uff0c\\u9999\\u6e2f\\u7279\\u522b\\u884c\\u653f\\u533a\\uff0c\\u4e4c\\u9c81\\u6728\\u9f50\", \"id\": \"saltminion02-42\", \"osrelease\": \"2008ServerR2\", \"ps\": \"tasklist.exe\", \"server_id\": 1650395528, \"ip6_interfaces\": {\"Citrix PV Network Adapter #0\": [\"fe80::9c8c:6ea5:58cb:8247\"]}, \"num_cpus\": 4, \"hwaddr_interfaces\": {\"Citrix PV Network Adapter #0\": \"DE:C5:56:54:DB:DE\"}, \"ip4_interfaces\": {\"Citrix PV Network Adapter #0\": [\"10.188.1.42\"]}, \"osfullname\": \"Microsoft Windows Server 2008 R2 Enterprise\", \"master\": \"saltmaster-40\", \"ipv4\": [\"10.188.1.42\"], \"ipv6\": [\"fe80::9c8c:6ea5:58cb:8247\"], \"osversion\": \"6.1.7600\", \"localhost\": \"saltminion02-42\", \"virtual_subtype\": \"HVM domU\", \"fqdn_ip4\": [\"127.0.0.1\"], \"fqdn_ip6\": [], \"nodename\": \"saltminion02-42\", \"saltversion\": \"2015.8.3\", \"saltpath\": \"c:\\\\salt\\\\bin\\\\lib\\\\site-packages\\\\salt\", \"pythonversion\": [2, 7, 10, \"final\", 0], \"host\": \"saltminion02-42\", \"os_family\": \"Windows\", \"gpus\": [], \"manufacturer\": \"Xen\", \"num_gpus\": 0, \"virtual\": \"Xen\", \"cpu_model\": \"Intel64 Family 6 Model 44 Stepping 2, GenuineIntel\", \"fqdn\": \"saltminion02-42.ewp.com\", \"pythonexecutable\": \"c:\\\\salt\\\\bin\\\\python.exe\", \"productname\": \"HVM domU\", \"cpuarch\": \"AMD64\", \"osmanufacturer\": \"Microsoft Corporation\", \"locale_info\": {\"detectedencoding\": \"cp437\", \"defaultlanguage\": \"zh_CN\", \"defaultencoding\": \"cp936\"}, \"path\": \"C:\\\\Windows\\\\system32;C:\\\\Windows;C:\\\\Windows\\\\System32\\\\Wbem;C:\\\\Windows\\\\System32\\\\WindowsPowerShell\\\\v1.0\\\\;;c:\\\\salt\\\\bin\\\\lib\\\\site-packages\\\\pywin32_system32;/bin;/sbin;/usr/bin;/usr/sbin;/usr/local/bin;c:\\\\salt\\\\bin\\\\lib\\\\site-packages\\\\pywin32_system32\", \"os\": \"Windows\", \"windowsdomain\": \"WORKGROUP\"}, \"out\": \"nested\"}, \"saltminion01-41.ewp.com\": {\"return\": {\"kernel\": \"Linux\", \"domain\": \"ewp.com\", \"zmqversion\": \"4.0.5\", \"kernelrelease\": \"2.6.32-431.el6.x86_64\", \"selinux\": {\"enforced\": \"Disabled\", \"enabled\": false}, \"ip_interfaces\": {\"lo\": [\"127.0.0.1\", \"::1\"], \"eth0\": [\"10.188.1.41\", \"fe80::f0ab:53ff:fed3:438c\"]}, \"shell\": \"/bin/sh\", \"mem_total\": 992, \"saltversioninfo\": [2015, 8, 3, 0], \"osmajorrelease\": \"6\", \"SSDs\": [\"xvda\", \"dm-0\", \"dm-1\"], \"mdadm\": [], \"id\": \"saltminion01-41.ewp.com\", \"osrelease\": \"6.5\", \"ps\": \"ps -efH\", \"server_id\": 742001097, \"ip6_interfaces\": {\"lo\": [\"::1\"], \"eth0\": [\"fe80::f0ab:53ff:fed3:438c\"]}, \"num_cpus\": 4, \"hwaddr_interfaces\": {\"lo\": \"00:00:00:00:00:00\", \"eth0\": \"f2:ab:53:d3:43:8c\"}, \"init\": \"upstart\", \"ip4_interfaces\": {\"lo\": [\"127.0.0.1\"], \"eth0\": [\"10.188.1.41\"]}, \"osfullname\": \"CentOS\", \"master\": \"10.188.1.40\", \"virtual_subtype\": \"Xen PV DomU\", \"ipv6\": [\"::1\", \"fe80::f0ab:53ff:fed3:438c\"], \"cpu_flags\": [\"fpu\", \"de\", \"tsc\", \"msr\", \"pae\", \"cx8\", \"sep\", \"cmov\", \"pat\", \"clflush\", \"mmx\", \"fxsr\", \"sse\", \"sse2\", \"ss\", \"ht\", \"syscall\", \"nx\", \"lm\", \"rep_good\", \"aperfmperf\", \"unfair_spinlock\", \"pni\", \"pclmulqdq\", \"ssse3\", \"cx16\", \"pcid\", \"sse4_1\", \"sse4_2\", \"popcnt\", \"aes\", \"hypervisor\", \"lahf_lm\", \"arat\", \"epb\", \"dts\"], \"ipv4\": [\"10.188.1.41\", \"127.0.0.1\"], \"localhost\": \"saltminion01-41.ewp.com\", \"lsb_distrib_id\": \"CentOS\", \"fqdn_ip4\": [\"10.188.1.41\"], \"fqdn_ip6\": [], \"nodename\": \"saltminion01-41.ewp.com\", \"saltversion\": \"2015.8.3\", \"lsb_distrib_release\": \"6.5\", \"pythonpath\": [\"/usr/bin\", \"/usr/lib64/python26.zip\", \"/usr/lib64/python2.6\", \"/usr/lib64/python2.6/plat-linux2\", \"/usr/lib64/python2.6/lib-tk\", \"/usr/lib64/python2.6/lib-old\", \"/usr/lib64/python2.6/lib-dynload\", \"/usr/lib64/python2.6/site-packages\", \"/usr/lib/python2.6/site-packages\"], \"saltpath\": \"/usr/lib/python2.6/site-packages/salt\", \"pythonversion\": [2, 6, 6, \"final\", 0], \"host\": \"saltminion01-41\", \"os_family\": \"RedHat\", \"oscodename\": \"Final\", \"osfinger\": \"CentOS-6\", \"num_gpus\": 0, \"virtual\": \"xen\", \"cpu_model\": \"Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz\", \"fqdn\": \"saltminion01-41.ewp.com\", \"pythonexecutable\": \"/usr/bin/python2.6\", \"osarch\": \"x86_64\", \"cpuarch\": \"x86_64\", \"lsb_distrib_codename\": \"Final\", \"osrelease_info\": [6, 5], \"locale_info\": {\"detectedencoding\": \"UTF-8\", \"defaultlanguage\": \"en_US\", \"defaultencoding\": \"UTF8\"}, \"gpus\": [], \"path\": \"/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin\", \"os\": \"CentOS\"}, \"out\": \"nested\"}}'),(121,'cmd.run','20160417175121947303','saltminion02-42,saltminion01-41.ewp.com','admin','2016-04-17 09:50:48','local_async','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {\"cmd.run\": \"\\n    Execute the passed command and return the output as a string\\n\\n    Note that ``env`` represents the environment variables for the command, and\\n    should be formatted as a dict, or a YAML string which resolves to a dict.\\n\\n    cmd:\\n        The command to run. ex: \'ls -lart /home\'\\n\\n    cwd\\n        The current working directory to execute the command in, defaults to\\n        /root\\n\\n    stdin\\n        A string of standard input can be specified for the command to be run using\\n        the ``stdin`` parameter. This can be useful in cases where sensitive\\n        information must be read from standard input.:\\n\\n    runas\\n        User to run script as.\\n\\n    shell\\n        Shell to execute under. Defaults to the system default shell.\\n\\n    python_shell\\n        If False, let python handle the positional arguments. Set to True\\n        to use shell features, such as pipes or redirection\\n\\n    env\\n        A list of environment variables to be set prior to execution.\\n        Example:\\n\\n            salt://scripts/foo.sh:\\n              cmd.script:\\n                - env:\\n                  - BATCH: \'yes\'\\n\\n        Warning:\\n\\n            The above illustrates a common PyYAML pitfall, that **yes**,\\n            **no**, **on**, **off**, **true**, and **false** are all loaded as\\n            boolean ``True`` and ``False`` values, and must be enclosed in\\n            quotes to be used as strings. More info on this (and other) PyYAML\\n            idiosyncrasies can be found :doc:`here\\n            </topics/troubleshooting/yaml_idiosyncrasies>`.\\n\\n        Variables as values are not evaluated. So $PATH in the following\\n        example is a literal \'$PATH\':\\n\\n            salt://scripts/bar.sh:\\n              cmd.script:\\n                - env: \\\"PATH=/some/path:$PATH\\\"\\n\\n        One can still use the existing $PATH by using a bit of Jinja:\\n\\n            {% set current_path = salt[\'environ.get\'](\'PATH\', \'/bin:/usr/bin\') %}\\n\\n            mycommand:\\n              cmd.run:\\n                - name: ls -l /\\n                - env:\\n                  - PATH: {{ [current_path, \'/my/special/bin\']|join(\':\') }}\\n\\n     clean_env:\\n        Attempt to clean out all other shell environment variables and set\\n        only those provided in the \'env\' argument to this function.\\n\\n    template\\n        If this setting is applied then the named templating engine will be\\n        used to render the downloaded file. Currently jinja, mako, and wempy\\n        are supported\\n\\n    rstrip\\n        Strip all whitespace off the end of output before it is returned.\\n\\n    umask\\n         The umask (in octal) to use when running the command.\\n\\n    output_loglevel\\n        Control the loglevel at which the output from the command is logged.\\n        Note that the command being run will still be logged (loglevel: DEBUG)\\n        regardless, unless ``quiet`` is used for this value.\\n\\n    timeout\\n        A timeout in seconds for the executed process to return.\\n\\n    use_vt\\n        Use VT utils (saltstack) to stream the command output more\\n        interactively to the console and the logs.\\n        This is experimental.\\n\\n\\n    Warning:\\n\\n        This function does not process commands through a shell\\n        unless the python_shell flag is set to True. This means that any\\n        shell-specific functionality such as \'echo\' or the use of pipes,\\n        redirection or &&, should either be migrated to cmd.shell or\\n        have the python_shell=True flag set here.\\n\\n        The use of python_shell=True means that the shell will accept _any_ input\\n        including potentially malicious commands such as \'good_command;rm -rf /\'.\\n        Be absolutely certain that you have sanitized your input prior to using\\n        python_shell=True\\n\\n    CLI Example:\\n\\n        salt \'*\' cmd.run \\\"ls -l | awk \'/foo/{print \\\\$2}\'\\\"\\n\\n    The template arg can be set to \'jinja\' or another supported template\\n    engine to render the command arguments before execution.\\n    For example:\\n\\n        salt \'*\' cmd.run template=jinja \\\"ls -l /tmp/{{grains.id}} | awk \'/foo/{print \\\\$2}\'\\\"\\n\\n    Specify an alternate shell with the shell parameter:\\n\\n        salt \'*\' cmd.run \\\"Get-ChildItem C:\\\\ \\\" shell=\'powershell\'\\n\\n    A string of standard input can be specified for the command to be run using\\n    the ``stdin`` parameter. This can be useful in cases where sensitive\\n    information must be read from standard input.:\\n\\n        salt \'*\' cmd.run \\\"grep f\\\" stdin=\'one\\\\ntwo\\\\nthree\\\\nfour\\\\nfive\\\\n\'\\n\\n    If an equal sign (``=``) appears in an argument to a Salt command it is\\n    interpreted as a keyword argument in the format ``key=val``. That\\n    processing can be bypassed in order to pass an equal sign through to the\\n    remote shell command by manually specifying the kwarg:\\n\\n        salt \'*\' cmd.run cmd=\'sed -e s/=/:/g\'\\n    \"}}}'),(122,'','20160417182320674553','saltminion01-41.ewp.com,saltminion02-42','admin','2016-04-17 10:22:47','local_async','test.ping','glob',2,'{\"saltminion02-42\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(123,'','20160417182720259444','saltminion01-41.ewp.com,saltminion02-42','admin','2016-04-17 10:26:46','local_async','test.ping','glob',2,'{\"saltminion02-42\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(124,'hostname','20160417182733498083','saltminion01-41.ewp.com','admin','2016-04-17 10:27:00','local_async','cmd.run','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": \"saltminion01-41.ewp.com\"}}'),(125,'sys.doc','20160418095127081112','saltminion01-41.ewp.com','admin','2016-04-18 01:50:56','local_async','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {\"sys.doc\": \"\\n    Return the docstrings for all modules. Optionally, specify a module or a\\n    function to narrow the selection.\\n\\n    The strings are aggregated into a single document on the master for easy\\n    reading.\\n\\n    Multiple modules/functions can be specified.\\n\\n    CLI Example:\\n\\n        salt \'*\' sys.doc\\n        salt \'*\' sys.doc sys\\n        salt \'*\' sys.doc sys.doc\\n        salt \'*\' sys.doc network.traceroute user.info\\n\\n    Modules can be specified as globs.\\n\\n    New in version 2015.5.0\\n\\n        salt \'*\' sys.doc \'sys.*\'\\n        salt \'*\' sys.doc \'sys.list_*\'\\n    \"}}}'),(126,'sys.doc','20160418095709187297','saltminion01-41.ewp.com','admin','2016-04-18 01:56:38','local_async','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {\"sys.doc\": \"\\n    Return the docstrings for all modules. Optionally, specify a module or a\\n    function to narrow the selection.\\n\\n    The strings are aggregated into a single document on the master for easy\\n    reading.\\n\\n    Multiple modules/functions can be specified.\\n\\n    CLI Example:\\n\\n        salt \'*\' sys.doc\\n        salt \'*\' sys.doc sys\\n        salt \'*\' sys.doc sys.doc\\n        salt \'*\' sys.doc network.traceroute user.info\\n\\n    Modules can be specified as globs.\\n\\n    New in version 2015.5.0\\n\\n        salt \'*\' sys.doc \'sys.*\'\\n        salt \'*\' sys.doc \'sys.list_*\'\\n    \"}}}'),(127,'','20160418100326904564','saltminion01-41.ewp.com','admin','2016-04-18 02:02:56','local_async','test.ping','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}}'),(128,'','20160418105943180866','10.188.1.40,saltminion01-41.ewp.com,saltminion02-42','admin','2016-04-18 02:59:12','local_async','test.ping','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}, \"10.188.1.40\": {\"return\": true}}'),(129,'','20160418110144471066','10.188.1.40,saltminion01-41.ewp.com,saltminion02-42','admin','2016-04-18 03:01:13','local_async','test.ping','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}, \"10.188.1.40\": {\"return\": true}}'),(130,'','20160418110224503354','saltminion02-42','admin','2016-04-18 03:01:53','local_async','test.ping','list',2,'{\"saltminion02-42\": {\"return\": true}}'),(131,'','20160418150608210407','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-18 07:05:38','local_async','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(132,'hostname','20160418151307703644','saltminion02-42.ewp.com','admin','2016-04-18 07:12:37','local_async','cmd.run','glob',2,'{\"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}}'),(133,'hostname','20160418151420485192','saltminion02-42.ewp.com','admin','2016-04-18 07:13:50','local_async','cmd.run','glob',2,'{\"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}}'),(134,'hostname','20160418151512685737','saltminion02-42.ewp.com','admin','2016-04-18 07:14:42','local_async','cmd.run','glob',2,'{\"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}}'),(135,'hostname','20160418151636923252','saltminion02-42.ewp.com','admin','2016-04-18 07:16:07','local_async','cmd.run','glob',2,'{\"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}}'),(136,'hostname','20160418151759671144','saltminion02-42.ewp.com','admin','2016-04-18 07:17:29','local_async','cmd.run','glob',2,'{\"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}}'),(137,'','20160418153504016701','saltminion01-41.ewp.com','admin','2016-04-18 07:34:34','local_async','test.ping','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}}'),(138,'','20160418153605444819','saltminion02-42.ewp.com','admin','2016-04-18 07:35:35','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(139,'','20160418154927163059','saltminion02-42.ewp.com','admin','2016-04-18 07:48:57','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(140,'','20160418155141100285','saltminion02-42.ewp.com','admin','2016-04-18 07:51:11','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(141,'','20160418155216728942','saltminion02-42.ewp.com','admin','2016-04-18 07:51:46','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(142,'','20160418160134639723','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-18 08:01:04','local_async','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(143,'','20160418160211811732','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-18 08:01:41','local_async','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(144,'','20160418160508047881','saltminion02-42.ewp.com','admin','2016-04-18 08:04:37','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(145,'','20160418160554751598','saltminion02-42.ewp.com','admin','2016-04-18 08:05:24','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(146,'','20160418160906714186','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-18 08:08:36','local_async','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion02-42.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(147,'hostname','20160418160959530208','saltminion02-42.ewp.com','admin','2016-04-18 08:09:29','local_async','cmd.run','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}}'),(148,'','20160418161437196992','saltminion02-42.ewp.com','admin','2016-04-18 08:14:07','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(149,'','20160418161636041549','saltminion02-42.ewp.com','admin','2016-04-18 08:16:05','local_async','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(150,'','20160418161802147861','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-18 08:17:32','local_async','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion02-42.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(151,'','20160418165552931284','saltminion01-41.ewp.com','admin','2016-04-18 08:55:22','local_async','test.ping','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}}'),(152,'','','*','admin','2016-04-18 08:56:45','ssh','test.ping','glob',2,'{\"return\": [{\"10.188.1.43\": {\"fun_args\": [], \"jid\": \"20160418165740156840\", \"return\": true, \"retcode\": 0, \"fun\": \"test.ping\", \"id\": \"10.188.1.43\"}}]}'),(153,'svn.add','20160420095254139078','saltminion01-41.ewp.com','admin','2016-04-20 01:52:26','','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {}}}'),(154,'hostname','20160420095533666368','saltminion02-42.ewp.com,saltminion01-41.ewp.com,saltmaster-40.ewp.com','admin','2016-04-20 01:55:05','','cmd.run','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"saltmaster-40.ewp.com\"}, \"saltminion01-41.ewp.com\": {\"return\": \"saltminion01-41.ewp.com\"}}'),(155,'hostname','20160420095908096085','saltminion02-42.ewp.com,saltminion01-41.ewp.com,saltmaster-40.ewp.com','admin','2016-04-20 01:58:11','','cmd.run','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"saltmaster-40.ewp.com\"}, \"saltminion01-41.ewp.com\": {\"return\": \"saltminion01-41.ewp.com\"}}'),(156,'hostname','20160420100114443045','saltminion02-42.ewp.com,saltminion01-41.ewp.com,saltmaster-40.ewp.com','admin','2016-04-20 02:00:17','','cmd.run','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"saltmaster-40.ewp.com\"}, \"saltminion01-41.ewp.com\": {\"return\": \"saltminion01-41.ewp.com\"}}'),(157,'svn.add','20160420100304819413','saltminion01-41.ewp.com','admin','2016-04-20 02:02:08','','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {}}}'),(158,'cmd.run','20160420100344140491','saltminion01-41.ewp.com','admin','2016-04-20 02:02:47','','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {\"cmd.run\": \"\\n    Execute the passed command and return the output as a string\\n\\n    Note that ``env`` represents the environment variables for the command, and\\n    should be formatted as a dict, or a YAML string which resolves to a dict.\\n\\n    cmd:\\n        The command to run. ex: \'ls -lart /home\'\\n\\n    cwd\\n        The current working directory to execute the command in, defaults to\\n        /root\\n\\n    stdin\\n        A string of standard input can be specified for the command to be run using\\n        the ``stdin`` parameter. This can be useful in cases where sensitive\\n        information must be read from standard input.:\\n\\n    runas\\n        User to run script as.\\n\\n    shell\\n        Shell to execute under. Defaults to the system default shell.\\n\\n    python_shell\\n        If False, let python handle the positional arguments. Set to True\\n        to use shell features, such as pipes or redirection\\n\\n    env\\n        A list of environment variables to be set prior to execution.\\n        Example:\\n\\n            salt://scripts/foo.sh:\\n              cmd.script:\\n                - env:\\n                  - BATCH: \'yes\'\\n\\n        Warning:\\n\\n            The above illustrates a common PyYAML pitfall, that **yes**,\\n            **no**, **on**, **off**, **true**, and **false** are all loaded as\\n            boolean ``True`` and ``False`` values, and must be enclosed in\\n            quotes to be used as strings. More info on this (and other) PyYAML\\n            idiosyncrasies can be found :doc:`here\\n            </topics/troubleshooting/yaml_idiosyncrasies>`.\\n\\n        Variables as values are not evaluated. So $PATH in the following\\n        example is a literal \'$PATH\':\\n\\n            salt://scripts/bar.sh:\\n              cmd.script:\\n                - env: \\\"PATH=/some/path:$PATH\\\"\\n\\n        One can still use the existing $PATH by using a bit of Jinja:\\n\\n            {% set current_path = salt[\'environ.get\'](\'PATH\', \'/bin:/usr/bin\') %}\\n\\n            mycommand:\\n              cmd.run:\\n                - name: ls -l /\\n                - env:\\n                  - PATH: {{ [current_path, \'/my/special/bin\']|join(\':\') }}\\n\\n     clean_env:\\n        Attempt to clean out all other shell environment variables and set\\n        only those provided in the \'env\' argument to this function.\\n\\n    template\\n        If this setting is applied then the named templating engine will be\\n        used to render the downloaded file. Currently jinja, mako, and wempy\\n        are supported\\n\\n    rstrip\\n        Strip all whitespace off the end of output before it is returned.\\n\\n    umask\\n         The umask (in octal) to use when running the command.\\n\\n    output_loglevel\\n        Control the loglevel at which the output from the command is logged.\\n        Note that the command being run will still be logged (loglevel: DEBUG)\\n        regardless, unless ``quiet`` is used for this value.\\n\\n    timeout\\n        A timeout in seconds for the executed process to return.\\n\\n    use_vt\\n        Use VT utils (saltstack) to stream the command output more\\n        interactively to the console and the logs.\\n        This is experimental.\\n\\n\\n    Warning:\\n\\n        This function does not process commands through a shell\\n        unless the python_shell flag is set to True. This means that any\\n        shell-specific functionality such as \'echo\' or the use of pipes,\\n        redirection or &&, should either be migrated to cmd.shell or\\n        have the python_shell=True flag set here.\\n\\n        The use of python_shell=True means that the shell will accept _any_ input\\n        including potentially malicious commands such as \'good_command;rm -rf /\'.\\n        Be absolutely certain that you have sanitized your input prior to using\\n        python_shell=True\\n\\n    CLI Example:\\n\\n        salt \'*\' cmd.run \\\"ls -l | awk \'/foo/{print \\\\$2}\'\\\"\\n\\n    The template arg can be set to \'jinja\' or another supported template\\n    engine to render the command arguments before execution.\\n    For example:\\n\\n        salt \'*\' cmd.run template=jinja \\\"ls -l /tmp/{{grains.id}} | awk \'/foo/{print \\\\$2}\'\\\"\\n\\n    Specify an alternate shell with the shell parameter:\\n\\n        salt \'*\' cmd.run \\\"Get-ChildItem C:\\\\ \\\" shell=\'powershell\'\\n\\n    A string of standard input can be specified for the command to be run using\\n    the ``stdin`` parameter. This can be useful in cases where sensitive\\n    information must be read from standard input.:\\n\\n        salt \'*\' cmd.run \\\"grep f\\\" stdin=\'one\\\\ntwo\\\\nthree\\\\nfour\\\\nfive\\\\n\'\\n\\n    If an equal sign (``=``) appears in an argument to a Salt command it is\\n    interpreted as a keyword argument in the format ``key=val``. That\\n    processing can be bypassed in order to pass an equal sign through to the\\n    remote shell command by manually specifying the kwarg:\\n\\n        salt \'*\' cmd.run cmd=\'sed -e s/=/:/g\'\\n    \"}}}'),(159,'git.checkout','20160420100422047278','saltminion01-41.ewp.com','admin','2016-04-20 02:03:25','','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {}}}'),(160,'git','20160420100908027288','saltminion01-41.ewp.com','admin','2016-04-20 02:08:11','','sys.doc','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": {}}}'),(161,'','20160420112001551324','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-20 03:19:04','','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion02-42.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(162,'hostname','20160420112144144774','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-20 03:20:47','','cmd.run','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"saltmaster-40.ewp.com\"}, \"saltminion02-42.ewp.com\": {\"return\": \"saltminion02-42\"}, \"saltminion03-43.ewp.com\": {\"return\": \"salt_minion03-43.ewp.com\"}, \"saltminion01-41.ewp.com\": {\"return\": \"saltminion01-41.ewp.com\"}}'),(163,'','20160420112951473437','saltminion02-42.ewp.com','admin','2016-04-20 03:28:54','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(164,'','20160420113109742044','saltminion02-42.ewp.com','admin','2016-04-20 03:30:12','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(165,'','20160420113411145328','saltminion02-42.ewp.com','admin','2016-04-20 03:33:14','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(166,'','20160420113745493613','saltminion02-42.ewp.com','admin','2016-04-20 03:36:48','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(167,'','20160420114048200803','saltminion02-42.ewp.com','admin','2016-04-20 03:39:51','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(168,'','20160420114204105892','saltminion02-42.ewp.com','admin','2016-04-20 03:41:07','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(169,'','20160420114249817026','saltminion02-42.ewp.com','admin','2016-04-20 03:41:52','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(170,'','20160420114405919792','saltminion02-42.ewp.com','admin','2016-04-20 03:43:08','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(171,'','20160420114433770612','saltminion02-42.ewp.com','admin','2016-04-20 03:43:36','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(172,'','20160420114456056249','saltminion02-42.ewp.com','admin','2016-04-20 03:43:59','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(173,'','20160420114531667396','saltminion02-42.ewp.com','admin','2016-04-20 03:44:34','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(174,'','20160420114626297248','saltminion02-42.ewp.com','admin','2016-04-20 03:45:29','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(175,'','20160420115240480633','saltminion02-42.ewp.com','admin','2016-04-20 03:51:43','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(176,'','20160420131029951821','saltminion02-42.ewp.com','admin','2016-04-20 05:09:32','','test.ping','list',2,'{\"saltminion02-42.ewp.com\": {\"return\": true}}'),(177,'minion.install','20160427110609411398','saltminion03-43.ewp.com','admin','2016-04-27 03:05:16','','state.sls','list',2,'{\"saltminion03-43.ewp.com\": {\"return\": [\"No matching sls found for \'minion.install\' in env \'base\'\"], \"out\": \"highstate\"}}'),(178,'minions.install','20160427110746895558','saltminion03-43.ewp.com','admin','2016-04-27 03:06:54','','state.sls','list',2,'{}'),(179,'minions.install','20160427110843563320','saltminion03-43.ewp.com','admin','2016-04-27 03:07:51','','state.sls','list',2,'{}'),(180,'minions','20160427113359122078','saltminion03-43.ewp.com','admin','2016-04-27 03:33:06','','state.sls','list',2,'{}'),(181,'','20160427113719292836','saltminion03-43.ewp.com','admin','2016-04-27 03:36:26','','state.highstate','list',2,'{}'),(182,'minions.install','20160427135037844272','208-87-35-104.securehost.com','admin','2016-04-27 05:49:44','','state.sls','pcre',2,'{\"208-87-35-104.securehost.com\": {\"return\": {\"file_|-epel_repo_|-/etc/yum.repos.d/epel.repo_|-managed\": {\"comment\": \"File /etc/yum.repos.d/epel.repo is in the correct state\", \"name\": \"/etc/yum.repos.d/epel.repo\", \"start_time\": \"13:50:43.706413\", \"result\": true, \"duration\": 69.264, \"__run_num__\": 0, \"changes\": {}}, \"service_|-salt_service_|-salt-minion_|-running\": {\"comment\": \"The service salt-minion is already running\", \"name\": \"salt-minion\", \"start_time\": \"13:50:53.156331\", \"result\": true, \"duration\": 147.311, \"__run_num__\": 3, \"changes\": {}}, \"pkg_|-salt_pkg_|-salt-minion_|-installed\": {\"comment\": \"Package salt-minion is already installed\", \"name\": \"salt-minion\", \"start_time\": \"13:50:50.748160\", \"result\": true, \"duration\": 2386.522, \"__run_num__\": 1, \"changes\": {}}, \"file_|-salt_conf_|-/etc/salt/minion_|-managed\": {\"comment\": \"File /etc/salt/minion is in the correct state\", \"name\": \"/etc/salt/minion\", \"start_time\": \"13:50:53.135515\", \"result\": true, \"duration\": 17.909, \"__run_num__\": 2, \"changes\": {}}}, \"out\": \"highstate\"}}'),(183,'test.ping','20160427140437688458','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:03:44','','local_async','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}, \"saltminion01-41.ewp.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}, \"saltminion02-42.ewp.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}, \"208-87-35-104.securehost.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}}'),(184,'test.ping','20160427140745362725','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:06:52','','local_async','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}, \"saltminion01-41.ewp.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}, \"saltminion02-42.ewp.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}, \"208-87-35-104.securehost.com\": {\"return\": \"\'local_async\' is not available.\", \"out\": \"nested\"}}'),(185,'test.ping','20160427140806296040','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:07:13','','local','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"\'local\' is not available.\", \"out\": \"nested\"}, \"saltminion01-41.ewp.com\": {\"return\": \"\'local\' is not available.\", \"out\": \"nested\"}, \"saltminion02-42.ewp.com\": {\"return\": \"\'local\' is not available.\", \"out\": \"nested\"}, \"208-87-35-104.securehost.com\": {\"return\": \"\'local\' is not available.\", \"out\": \"nested\"}}'),(186,'','20160427140854161797','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:08:00','','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}, \"saltminion02-42.ewp.com\": {\"return\": true}, \"208-87-35-104.securehost.com\": {\"return\": true}}'),(187,'','20160427141730457834','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:16:37','','test.ping','glob',2,''),(188,'','20160427141750690922','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:16:57','','test.ping','glob',2,''),(189,'','20160427141809226412','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:17:16','','test.ping','glob',2,''),(190,'','20160427141850490446','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:17:57','','test.ping','glob',2,''),(191,'','20160427142041632587','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:19:48','','test.ping','glob',2,''),(192,'','20160427142101584450','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:20:08','','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}, \"saltminion02-42.ewp.com\": {\"return\": true}, \"208-87-35-104.securehost.com\": {\"return\": true}}'),(193,'','20160427142459770882','208-87-35-104.securehost.com,salt_minion03-43.ewp.com,saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-04-27 06:24:06','','test.ping','glob',2,''),(194,'/srv/salt','20160503144219480893','saltmaster-40.ewp.com','admin','2016-05-03 06:40:54','','file.readdir','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": [\".\", \"..\", \"test.txt\", \"test.sls\", \"minions\"]}}'),(195,'/etc/salt','20160504130232716097','saltmaster-40.ewp.com','admin','2016-05-04 05:01:07','','file.readdir','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": [\".\", \"..\", \"roster\", \"minion\", \"cloud.deploy.d\", \"proxy\", \"cloud.conf.d\", \"cloud.maps.d\", \"master.rpmnew\", \"pki\", \"proxy.rpmnew\", \"minion.rpmnew\", \"cloud.providers.d\", \"minion.d\", \"master\", \"master.d\", \"minion_id\", \"cloud\", \"cloud.profiles.d\"]}}'),(196,'/srv/salt/1/2/3','20160505132946645681','saltmaster-40.ewp.com','admin','2016-05-05 05:28:22','','file.mkdir','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": null}}'),(197,'/srv/salt/1','20160505133000070923','saltmaster-40.ewp.com','admin','2016-05-05 05:28:35','','file.mkdir','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": null}}'),(198,'/srv/salt/1/2/3','20160505133048771773','saltmaster-40.ewp.com','admin','2016-05-05 05:29:24','','file.makedirs','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"Directory \'/srv/salt/1/2\' already exists\"}}'),(199,'/srv/salt/a/b/c/d','20160505133159947951','saltmaster-40.ewp.com','admin','2016-05-05 05:30:35','','file.mkdir','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": null}}'),(200,'/srv/salt/a/b/c/d','20160505133750676404','saltmaster-40.ewp.com','admin','2016-05-05 05:36:26','','file.mkdir','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": null}}'),(201,'/srv/salt/test.py','20160505144140906331','saltmaster-40.ewp.com','admin','2016-05-05 06:40:16','','file.touch','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}}'),(202,'/srv/salt/test.py','20160505144229466865','saltmaster-40.ewp.com','admin','2016-05-05 06:41:04','','file.touch','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}}'),(203,'/srv/salt/test.text','20160505144322201226','saltmaster-40.ewp.com','admin','2016-05-05 06:41:57','','file.touch','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}}'),(204,'/srv/salt/test.txt','20160505144440595588','saltmaster-40.ewp.com','admin','2016-05-05 06:43:15','','file.touch','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}}'),(205,'/srv/salt2/test.txt','20160505144811055575','saltmaster-40.ewp.com','admin','2016-05-05 06:46:46','','file.touch','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"ERROR: No such file or directory\", \"out\": \"nested\"}}'),(206,'/srv/salt2/test.txt','20160505145347274514','saltmaster-40.ewp.com','admin','2016-05-05 06:52:22','','file.touch','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"ERROR: No such file or directory\", \"out\": \"nested\"}}'),(207,'/srv/salt/test.txt,\"123123123\"','20160505161311362032','saltmaster-40.ewp.com','admin','2016-05-05 08:11:46','','file.write','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"Wrote 0 lines to \\\"/srv/salt/test.txt,\\\"123123123\\\"\\\"\"}}'),(208,'/srv/salt/test.txt \"123123123\"','20160505161333432257','saltmaster-40.ewp.com','admin','2016-05-05 08:12:08','','file.write','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"Wrote 0 lines to \\\"/srv/salt/test.txt \\\"123123123\\\"\\\"\"}}'),(209,'[/srv/salt/test.txt,\"123123123\"]','20160505161419267972','saltmaster-40.ewp.com','admin','2016-05-05 08:12:54','','file.write','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"The minion function caused an exception: Traceback (most recent call last):\\n  File \\\"/usr/lib/python2.6/site-packages/salt/minion.py\\\", line 1071, in _thread_return\\n    return_data = func(*args, **kwargs)\\n  File \\\"/usr/lib/python2.6/site-packages/salt/modules/file.py\\\", line 2584, in write\\n    with salt.utils.fopen(path, \\\"w\\\") as ofile:\\n  File \\\"/usr/lib/python2.6/site-packages/salt/utils/__init__.py\\\", line 1204, in fopen\\n    fhandle = open(*args, **kwargs)\\nIOError: [Errno 2] No such file or directory: \'[/srv/salt/test.txt,\\\"123123123\\\"]\'\\n\", \"out\": \"nested\"}}'),(210,'/srv/salt/test.txt,args=\"123123123\"','20160505163000928727','saltmaster-40.ewp.com','admin','2016-05-05 08:28:35','','file.write','list',2,'{\"saltmaster-40.ewp.com\": {\"return\": \"Wrote 0 lines to \\\"/srv/salt/test.txt,args=\\\"123123123\\\"\\\"\"}}'),(211,'','20160520144521870362','saltmaster-40.ewp.com,saltminion01-41.ewp.com,saltminion02-42.ewp.com,saltminion03-43.ewp.com','admin','2016-05-20 06:43:54','','test.ping','glob',2,'{\"saltmaster-40.ewp.com\": {\"return\": true}, \"saltminion02-42.ewp.com\": {\"return\": true}, \"saltminion03-43.ewp.com\": {\"return\": true}, \"saltminion01-41.ewp.com\": {\"return\": true}}'),(212,'','20160520145511625631','saltminion01-41.ewp.com','admin','2016-05-20 06:53:44','','test.ping','list',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}}'),(213,'','20160526160701705459','saltmaster-50.ewp.com','admin','2016-05-26 08:05:32','','test.ping','glob',2,''),(214,'','20160526162421247175','saltmaster-50.ewp.com','admin','2016-05-26 08:22:52','','test.ping','glob',2,''),(215,'','20160526162855514390','saltmaster-50.ewp.com','admin','2016-05-26 08:27:26','','test.ping','glob',2,''),(216,'','20160526163746987271','saltmaster-50.ewp.com','admin','2016-05-26 08:36:17','','test.ping','glob',2,''),(217,'','20160526164442210035','saltmaster-50.ewp.com','admin','2016-05-26 08:43:13','','test.ping','glob',2,''),(218,'','20160526164737302057','saltmaster-50.ewp.com','admin','2016-05-26 08:46:08','','test.ping','glob',2,''),(219,'','20160526164946693766','saltmaster-50.ewp.com','admin','2016-05-26 08:48:17','','test.ping','glob',2,'{\"saltmaster-50.ewp.com\": {\"return\": true}}'),(220,'','20160526165259784092','saltmaster-50.ewp.com','admin','2016-05-26 08:51:30','','test.ping','glob',2,''),(221,'','20160526165352055982','saltmaster-50.ewp.com','admin','2016-05-26 08:52:22','','test.ping','glob',2,'{}'),(222,'','20160526165654344364','saltmaster-50.ewp.com','admin','2016-05-26 08:55:25','','test.ping','glob',2,'{\"saltmaster-50.ewp.com\": {\"return\": true}}'),(223,'','20160526165948198884','saltmaster-50.ewp.com','admin','2016-05-26 08:58:19','','test.ping','glob',2,'{\"saltmaster-50.ewp.com\": {\"return\": true}}'),(230,'','20160530150012055243','saltminion01-41.ewp.com','admin','2016-05-30 06:58:37','local_async','test.ping','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}}'),(232,'','20160530150529648027','saltminion01-41.ewp.com','admin','2016-05-30 07:03:54','local_async','test.ping','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": true}}'),(235,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:11:20','local','test.ping','glob',2,''),(236,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:20:01','local','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': True}'),(237,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:23:51','local','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': True}'),(238,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:26:34','local','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': True}'),(239,'','20160530152820084371','saltminion01-41.ewp.com','admin','2016-05-30 07:26:45','local_async','test.ping','glob',2,''),(240,'','20160530153543101720','saltminion01-41.ewp.com','admin','2016-05-30 07:34:08','local_async','test.ping','glob',2,''),(241,'','20160530153746192106','saltminion01-41.ewp.com','admin','2016-05-30 07:36:11','local_async','test.ping','glob',2,''),(242,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:36:43','local','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': True}'),(243,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:37:55','local','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': True}'),(244,'','','saltminion01-41.ewp.com','admin','2016-05-30 07:38:08','local','grains.items','glob',2,'{u\'saltminion01-41.ewp.com\': {u\'kernel\': u\'Linux\', u\'domain\': u\'ewp.com\', u\'zmqversion\': u\'4.0.5\', u\'kernelrelease\': u\'2.6.32-431.el6.x86_64\', u\'selinux\': {u\'enforced\': u\'Disabled\', u\'enabled\': False}, u\'ip_interfaces\': {u\'lo\': [u\'127.0.0.1\', u\'::1\'], u\'eth0\': [u\'10.188.1.41\', u\'fe80::f0ab:53ff:fed3:438c\']}, u\'fqdn_ip6\': [], u\'mem_total\': 992, u\'saltversioninfo\': [2015, 8, 3, 0], u\'SSDs\': [u\'xvda\', u\'dm-0\', u\'dm-1\'], u\'mdadm\': [], u\'id\': u\'saltminion01-41.ewp.com\', u\'osrelease\': u\'6.5\', u\'ps\': u\'ps -efH\', u\'server_id\': 742001097, u\'fqdn\': u\'saltminion01-41.ewp.com\', u\'ip6_interfaces\': {u\'lo\': [u\'::1\'], u\'eth0\': [u\'fe80::f0ab:53ff:fed3:438c\']}, u\'num_cpus\': 4, u\'hwaddr_interfaces\': {u\'lo\': u\'00:00:00:00:00:00\', u\'eth0\': u\'f2:ab:53:d3:43:8c\'}, u\'osfullname\': u\'CentOS\', u\'ip4_interfaces\': {u\'lo\': [u\'127.0.0.1\'], u\'eth0\': [u\'10.188.1.41\']}, u\'virtual_subtype\': u\'Xen PV DomU\', u\'init\': u\'upstart\', u\'master\': u\'10.188.1.39\', u\'lsb_distrib_id\': u\'CentOS\', u\'ipv6\': [u\'::1\', u\'fe80::f0ab:53ff:fed3:438c\'], u\'cpu_flags\': [u\'fpu\', u\'de\', u\'tsc\', u\'msr\', u\'pae\', u\'cx8\', u\'sep\', u\'cmov\', u\'pat\', u\'clflush\', u\'mmx\', u\'fxsr\', u\'sse\', u\'sse2\', u\'ss\', u\'ht\', u\'syscall\', u\'nx\', u\'lm\', u\'rep_good\', u\'aperfmperf\', u\'unfair_spinlock\', u\'pni\', u\'pclmulqdq\', u\'ssse3\', u\'cx16\', u\'pcid\', u\'sse4_1\', u\'sse4_2\', u\'popcnt\', u\'aes\', u\'hypervisor\', u\'lahf_lm\', u\'arat\', u\'epb\', u\'dts\'], u\'localhost\': u\'saltminion01-41.ewp.com\', u\'ipv4\': [u\'10.188.1.41\', u\'127.0.0.1\'], u\'fqdn_ip4\': [u\'10.188.1.41\'], u\'shell\': u\'/bin/sh\', u\'nodename\': u\'saltminion01-41.ewp.com\', u\'saltversion\': u\'2015.8.3\', u\'lsb_distrib_release\': u\'6.5\', u\'pythonpath\': [u\'/usr/bin\', u\'/usr/lib64/python26.zip\', u\'/usr/lib64/python2.6\', u\'/usr/lib64/python2.6/plat-linux2\', u\'/usr/lib64/python2.6/lib-tk\', u\'/usr/lib64/python2.6/lib-old\', u\'/usr/lib64/python2.6/lib-dynload\', u\'/usr/lib64/python2.6/site-packages\', u\'/usr/lib/python2.6/site-packages\'], u\'saltpath\': u\'/usr/lib/python2.6/site-packages/salt\', u\'pythonversion\': [2, 6, 6, u\'final\', 0], u\'host\': u\'saltminion01-41\', u\'os_family\': u\'RedHat\', u\'oscodename\': u\'Final\', u\'osfinger\': u\'CentOS-6\', u\'num_gpus\': 0, u\'virtual\': u\'xen\', u\'cpu_model\': u\'Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz\', u\'osmajorrelease\': u\'6\', u\'pythonexecutable\': u\'/usr/bin/python2.6\', u\'osarch\': u\'x86_64\', u\'cpuarch\': u\'x86_64\', u\'lsb_distrib_codename\': u\'Final\', u\'osrelease_info\': [6, 5], u\'locale_info\': {u\'detectedencoding\': u\'UTF-8\', u\'defaultlanguage\': u\'en_US\', u\'defaultencoding\': u\'UTF8\'}, u\'gpus\': [], u\'path\': u\'/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin\', u\'os\': u\'CentOS\'}}'),(245,'hostname','20160530154921846640','saltminion01-41.ewp.com','admin','2016-05-30 07:47:46','local_async','cmd.run','glob',2,'{u\'saltminion01-41.ewp.com\': {u\'return\': u\'saltminion01-41.ewp.com\'}}'),(246,'hostnanme','20160530155512470502','saltminion01-41.ewp.com','admin','2016-05-30 07:53:37','local_async','cmd.run','glob',2,''),(247,'','20160530155536057771','saltminion01-41.ewp.com','admin','2016-05-30 07:54:01','local_async','test.ping','glob',2,''),(248,'','20160530155609202667','saltminion01-41.ewp.com','admin','2016-05-30 07:54:34','local_async','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': {u\'return\': True}}'),(249,'ls /etc/salt','','saltminion01-41.ewp.com','admin','2016-05-30 08:18:31','local','cmd.run','glob',2,'{u\'saltminion01-41.ewp.com\': u\'cloud\\ncloud.conf.d\\ncloud.deploy.d\\ncloud.maps.d\\ncloud.profiles.d\\ncloud.providers.d\\nmaster\\nminion\\nminion.d\\nminion_id\\npki\\nproxy\\nroster\'}'),(250,'','','','admin','2016-05-31 02:30:00','runner','manage.status','glob',2,'{u\'down\': [], u\'up\': [u\'saltminion01-41.ewp.com\']}'),(251,'','','','admin','2016-05-31 02:30:09','runner','manage.up','glob',2,'[u\'saltminion01-41.ewp.com\']'),(252,'','20160531110017563793','','admin','2016-05-31 02:58:44','runner_async','manage.status','glob',2,'{u\'10.188.1.39_master\': {u\'return\': {u\'jid\': u\'20160531110017563793\', u\'return\': {u\'down\': [], u\'up\': [u\'saltminion01-41.ewp.com\']}, u\'success\': True, u\'_stamp\': u\'2016-05-31T03:00:18.463370\', u\'user\': u\'salt\', u\'fun\': u\'runner.manage.status\'}}}'),(253,'os','20160531144020756005','saltminion01-41.ewp.com','admin','2016-05-31 06:38:46','local_async','grains.item','glob',2,'{u\'saltminion01-41.ewp.com\': {u\'return\': {u\'os\': u\'CentOS\'}, u\'out\': u\'nested\'}}'),(254,'','20160531144035821288','saltminion01-41.ewp.com','admin','2016-05-31 06:39:01','local_async','test.ping','glob',2,'{u\'saltminion01-41.ewp.com\': {u\'return\': True}}'),(255,'','','saltminion01-41.ewp.com','admin','2016-05-31 06:39:19','runner','manage.up','glob',2,'[u\'saltminion01-41.ewp.com\']'),(256,'','','saltminion01-41.ewp.com','admin','2016-05-31 06:39:37','runner','manage.status','glob',2,'{u\'down\': [], u\'up\': [u\'saltminion01-41.ewp.com\']}'),(257,'','','','admin','2016-05-31 06:44:23','runner','manage.up','glob',2,'[u\'saltminion01-41.ewp.com\']'),(258,'','','','admin','2016-05-31 06:46:01','runner','manage.up','glob',2,'[u\'saltminion01-41.ewp.com\']'),(259,'','','','admin','2016-05-31 06:46:41','runner','manage.status','glob',2,'{u\'down\': [], u\'up\': [u\'saltminion01-41.ewp.com\']}'),(260,'','20160531144820818070','','admin','2016-05-31 06:46:46','runner_async','manage.status','glob',2,'{u\'10.188.1.39_master\': {u\'return\': {u\'jid\': u\'20160531144820818070\', u\'return\': {u\'down\': [], u\'up\': [u\'saltminion01-41.ewp.com\']}, u\'success\': True, u\'_stamp\': u\'2016-05-31T06:48:21.807747\', u\'user\': u\'salt\', u\'fun\': u\'runner.manage.status\'}}}'),(261,'host','','*','admin','2016-05-31 06:47:22','local','grains.item','glob',2,'{u\'saltminion01-41.ewp.com\': {u\'host\': u\'saltminion01-41\'}}'),(262,'host','','*','admin','2016-05-31 06:48:02','runner','manage.status','glob',2,'{u\'down\': [], u\'up\': [u\'saltminion01-41.ewp.com\']}'),(263,'','','','admin','2016-05-31 07:21:42','runner','manage.status','glob',2,'{\"down\": [], \"up\": [\"saltminion01-41.ewp.com\"]}'),(264,'','','','admin','2016-05-31 07:25:37','runner','manage.status','glob',2,'{\"down\": [], \"up\": [\"saltminion01-41.ewp.com\"]}'),(265,'','20160531152749241862','saltminion01-41.ewp.com','admin','2016-05-31 07:26:15','local_async','grains.items','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": {\"kernel\": \"Linux\", \"domain\": \"ewp.com\", \"zmqversion\": \"4.0.5\", \"kernelrelease\": \"2.6.32-431.el6.x86_64\", \"selinux\": {\"enforced\": \"Disabled\", \"enabled\": false}, \"ip_interfaces\": {\"lo\": [\"127.0.0.1\", \"::1\"], \"eth0\": [\"10.188.1.41\", \"fe80::f0ab:53ff:fed3:438c\"]}, \"shell\": \"/bin/sh\", \"mem_total\": 992, \"saltversioninfo\": [2015, 8, 3, 0], \"osmajorrelease\": \"6\", \"SSDs\": [\"xvda\", \"dm-0\", \"dm-1\"], \"mdadm\": [], \"id\": \"saltminion01-41.ewp.com\", \"osrelease\": \"6.5\", \"ps\": \"ps -efH\", \"server_id\": 742001097, \"ip6_interfaces\": {\"lo\": [\"::1\"], \"eth0\": [\"fe80::f0ab:53ff:fed3:438c\"]}, \"num_cpus\": 4, \"hwaddr_interfaces\": {\"lo\": \"00:00:00:00:00:00\", \"eth0\": \"f2:ab:53:d3:43:8c\"}, \"init\": \"upstart\", \"ip4_interfaces\": {\"lo\": [\"127.0.0.1\"], \"eth0\": [\"10.188.1.41\"]}, \"osfullname\": \"CentOS\", \"master\": \"10.188.1.39\", \"virtual_subtype\": \"Xen PV DomU\", \"ipv6\": [\"::1\", \"fe80::f0ab:53ff:fed3:438c\"], \"cpu_flags\": [\"fpu\", \"de\", \"tsc\", \"msr\", \"pae\", \"cx8\", \"sep\", \"cmov\", \"pat\", \"clflush\", \"mmx\", \"fxsr\", \"sse\", \"sse2\", \"ss\", \"ht\", \"syscall\", \"nx\", \"lm\", \"rep_good\", \"aperfmperf\", \"unfair_spinlock\", \"pni\", \"pclmulqdq\", \"ssse3\", \"cx16\", \"pcid\", \"sse4_1\", \"sse4_2\", \"popcnt\", \"aes\", \"hypervisor\", \"lahf_lm\", \"arat\", \"epb\", \"dts\"], \"ipv4\": [\"10.188.1.41\", \"127.0.0.1\"], \"localhost\": \"saltminion01-41.ewp.com\", \"lsb_distrib_id\": \"CentOS\", \"fqdn_ip4\": [\"10.188.1.41\"], \"fqdn_ip6\": [], \"nodename\": \"saltminion01-41.ewp.com\", \"saltversion\": \"2015.8.3\", \"lsb_distrib_release\": \"6.5\", \"pythonpath\": [\"/usr/bin\", \"/usr/lib64/python26.zip\", \"/usr/lib64/python2.6\", \"/usr/lib64/python2.6/plat-linux2\", \"/usr/lib64/python2.6/lib-tk\", \"/usr/lib64/python2.6/lib-old\", \"/usr/lib64/python2.6/lib-dynload\", \"/usr/lib64/python2.6/site-packages\", \"/usr/lib/python2.6/site-packages\"], \"saltpath\": \"/usr/lib/python2.6/site-packages/salt\", \"pythonversion\": [2, 6, 6, \"final\", 0], \"host\": \"saltminion01-41\", \"os_family\": \"RedHat\", \"oscodename\": \"Final\", \"osfinger\": \"CentOS-6\", \"num_gpus\": 0, \"virtual\": \"xen\", \"cpu_model\": \"Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz\", \"fqdn\": \"saltminion01-41.ewp.com\", \"pythonexecutable\": \"/usr/bin/python2.6\", \"osarch\": \"x86_64\", \"cpuarch\": \"x86_64\", \"lsb_distrib_codename\": \"Final\", \"osrelease_info\": [6, 5], \"locale_info\": {\"detectedencoding\": \"UTF-8\", \"defaultlanguage\": \"en_US\", \"defaultencoding\": \"UTF8\"}, \"gpus\": [], \"path\": \"/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin\", \"os\": \"CentOS\"}, \"out\": \"nested\"}}'),(266,'','','','admin','2016-05-31 07:31:39','wheel','key.list','glob',2,'{\"tag\": \"salt/wheel/20160531153313879370\", \"data\": {\"jid\": \"20160531153313879370\", \"return\": \"Exception occurred in wheel key.list: Traceback (most recent call last):\\n  File \\\"/usr/lib/python2.6/site-packages/salt/client/mixins.py\\\", line 320, in low\\n    expected_extra_kws=CLIENT_INTERNAL_KEYWORDS\\n  File \\\"/usr/lib/python2.6/site-packages/salt/utils/__init__.py\\\", line 989, in format_call\\n    used_args_count\\nSaltInvocationError: list_ takes at least 1 argument (0 given)\\n\", \"success\": true, \"_stamp\": \"2016-05-31T07:33:13.915011\", \"tag\": \"salt/wheel/20160531153313879370\", \"user\": \"salt\", \"fun\": \"wheel.key.list\"}}'),(267,'','','','admin','2016-05-31 07:37:09','wheel','key.list_all','glob',2,'{\"tag\": \"salt/wheel/20160531153843322907\", \"data\": {\"jid\": \"20160531153843322907\", \"return\": {\"local\": [\"master.pem\", \"master.pub\"], \"minions_rejected\": [], \"minions_denied\": [], \"minions_pre\": [], \"minions\": [\"saltminion01-41.ewp.com\"]}, \"success\": true, \"_stamp\": \"2016-05-31T07:38:43.335977\", \"tag\": \"salt/wheel/20160531153843322907\", \"user\": \"salt\", \"fun\": \"wheel.key.list_all\"}}'),(268,'','20160531154511643361','','admin','2016-05-31 07:43:37','runner_async','manage.up','glob',2,'{\"10.188.1.39_master\": {\"return\": {\"jid\": \"20160531154511643361\", \"return\": [\"saltminion01-41.ewp.com\"], \"success\": true, \"_stamp\": \"2016-05-31T07:45:12.564946\", \"user\": \"salt\", \"fun\": \"runner.manage.up\"}}}'),(269,'','','','admin','2016-05-31 07:59:07','runner','manage.versions','glob',2,'{\"Master\": \"2016.3.0\", \"Minion requires update\": {\"saltminion01-41.ewp.com\": \"2015.8.3\"}}'),(270,'','20160531160130550231','*','admin','2016-05-31 07:59:56','local_async','state.show_top','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": {}}}'),(271,'','20160601103517482365','saltminion01-41.ewp.com','admin','2016-06-01 02:33:45','local_async','grains.items','glob',2,'{\"saltminion01-41.ewp.com\": {\"return\": {\"kernel\": \"Linux\", \"domain\": \"ewp.com\", \"zmqversion\": \"4.0.5\", \"kernelrelease\": \"2.6.32-431.el6.x86_64\", \"selinux\": {\"enforced\": \"Disabled\", \"enabled\": false}, \"ip_interfaces\": {\"lo\": [\"127.0.0.1\", \"::1\"], \"eth0\": [\"10.188.1.41\", \"fe80::f0ab:53ff:fed3:438c\"]}, \"shell\": \"/bin/sh\", \"mem_total\": 992, \"saltversioninfo\": [2015, 8, 3, 0], \"osmajorrelease\": \"6\", \"SSDs\": [\"xvda\", \"dm-0\", \"dm-1\"], \"mdadm\": [], \"id\": \"saltminion01-41.ewp.com\", \"osrelease\": \"6.5\", \"ps\": \"ps -efH\", \"server_id\": 742001097, \"ip6_interfaces\": {\"lo\": [\"::1\"], \"eth0\": [\"fe80::f0ab:53ff:fed3:438c\"]}, \"num_cpus\": 4, \"hwaddr_interfaces\": {\"lo\": \"00:00:00:00:00:00\", \"eth0\": \"f2:ab:53:d3:43:8c\"}, \"init\": \"upstart\", \"ip4_interfaces\": {\"lo\": [\"127.0.0.1\"], \"eth0\": [\"10.188.1.41\"]}, \"osfullname\": \"CentOS\", \"master\": \"10.188.1.39\", \"virtual_subtype\": \"Xen PV DomU\", \"ipv6\": [\"::1\", \"fe80::f0ab:53ff:fed3:438c\"], \"cpu_flags\": [\"fpu\", \"de\", \"tsc\", \"msr\", \"pae\", \"cx8\", \"sep\", \"cmov\", \"pat\", \"clflush\", \"mmx\", \"fxsr\", \"sse\", \"sse2\", \"ss\", \"ht\", \"syscall\", \"nx\", \"lm\", \"rep_good\", \"aperfmperf\", \"unfair_spinlock\", \"pni\", \"pclmulqdq\", \"ssse3\", \"cx16\", \"pcid\", \"sse4_1\", \"sse4_2\", \"popcnt\", \"aes\", \"hypervisor\", \"lahf_lm\", \"arat\", \"epb\", \"dts\"], \"ipv4\": [\"10.188.1.41\", \"127.0.0.1\"], \"localhost\": \"saltminion01-41.ewp.com\", \"lsb_distrib_id\": \"CentOS\", \"fqdn_ip4\": [\"10.188.1.41\"], \"fqdn_ip6\": [], \"nodename\": \"saltminion01-41.ewp.com\", \"saltversion\": \"2015.8.3\", \"lsb_distrib_release\": \"6.5\", \"pythonpath\": [\"/usr/bin\", \"/usr/lib64/python26.zip\", \"/usr/lib64/python2.6\", \"/usr/lib64/python2.6/plat-linux2\", \"/usr/lib64/python2.6/lib-tk\", \"/usr/lib64/python2.6/lib-old\", \"/usr/lib64/python2.6/lib-dynload\", \"/usr/lib64/python2.6/site-packages\", \"/usr/lib/python2.6/site-packages\"], \"saltpath\": \"/usr/lib/python2.6/site-packages/salt\", \"pythonversion\": [2, 6, 6, \"final\", 0], \"host\": \"saltminion01-41\", \"os_family\": \"RedHat\", \"oscodename\": \"Final\", \"osfinger\": \"CentOS-6\", \"num_gpus\": 0, \"virtual\": \"xen\", \"cpu_model\": \"Intel(R) Xeon(R) CPU           E5606  @ 2.13GHz\", \"fqdn\": \"saltminion01-41.ewp.com\", \"pythonexecutable\": \"/usr/bin/python2.6\", \"osarch\": \"x86_64\", \"cpuarch\": \"x86_64\", \"lsb_distrib_codename\": \"Final\", \"osrelease_info\": [6, 5], \"locale_info\": {\"detectedencoding\": \"UTF-8\", \"defaultlanguage\": \"en_US\", \"defaultencoding\": \"UTF8\"}, \"gpus\": [], \"path\": \"/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin\", \"os\": \"CentOS\"}, \"out\": \"nested\"}}');
/*!40000 ALTER TABLE `salt_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salt_saltserver`
--

DROP TABLE IF EXISTS `salt_saltserver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salt_saltserver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(20) NOT NULL,
  `idc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `SALT_saltserver_0869e37a` (`idc_id`),
  CONSTRAINT `SALT_saltserver_idc_id_236e28f2_fk_CMDB_idc_id` FOREIGN KEY (`idc_id`) REFERENCES `cmdb_idc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salt_saltserver`
--

LOCK TABLES `salt_saltserver` WRITE;
/*!40000 ALTER TABLE `salt_saltserver` DISABLE KEYS */;
INSERT INTO `salt_saltserver` VALUES (2,'https://10.188.1.39:8000','salt','salt','Master',2);
/*!40000 ALTER TABLE `salt_saltserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salt_targettype`
--

DROP TABLE IF EXISTS `salt_targettype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salt_targettype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salt_targettype`
--

LOCK TABLES `salt_targettype` WRITE;
/*!40000 ALTER TABLE `salt_targettype` DISABLE KEYS */;
INSERT INTO `salt_targettype` VALUES (10,'compound'),(1,'glob'),(4,'grain'),(5,'grain_pcre'),(3,'list'),(8,'nodegroup'),(2,'pcre'),(6,'pillar'),(7,'pillar_pcre'),(9,'range');
/*!40000 ALTER TABLE `salt_targettype` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-01 12:08:01
