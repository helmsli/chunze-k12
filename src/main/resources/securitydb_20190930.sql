-- MySQL dump 10.13  Distrib 5.5.25, for linux2.6 (x86_64)
--
-- Host: localhost    Database: securitydb_study
-- ------------------------------------------------------
-- Server version	5.5.25

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
-- Table structure for table `security_allaction`
--

DROP TABLE IF EXISTS `security_allaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_allaction` (
  `actionId` bigint(8) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `action` varchar(128) DEFAULT NULL,
  `system` varchar(32) DEFAULT NULL COMMENT '指明是哪个系统的权限'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_allaction`
--

LOCK TABLES `security_allaction` WRITE;
/*!40000 ALTER TABLE `security_allaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_allaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_role`
--

DROP TABLE IF EXISTS `security_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_role` (
  `roleId` bigint(8) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `createSource` varchar(128) DEFAULT NULL COMMENT '填写创建来源'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_role`
--

LOCK TABLES `security_role` WRITE;
/*!40000 ALTER TABLE `security_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_roleaction`
--

DROP TABLE IF EXISTS `security_roleaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_roleaction` (
  `actionId` bigint(8) DEFAULT NULL,
  `roleId` bigint(8) DEFAULT NULL,
  `description` varchar(128) DEFAULT NULL,
  `action` varchar(128) DEFAULT NULL,
  `authority` tinyint(4) DEFAULT '0' COMMENT '0--可见，可用\n1--不可见\n2--可见不可用',
  `createTime` datetime DEFAULT NULL,
  `createSource` varchar(128) DEFAULT NULL COMMENT '填写创建来源',
  `updateTime` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_roleaction`
--

LOCK TABLES `security_roleaction` WRITE;
/*!40000 ALTER TABLE `security_roleaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_roleaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_user`
--

DROP TABLE IF EXISTS `security_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_user` (
  `userId` bigint(8) unsigned DEFAULT NULL,
  `loginName` varchar(64) DEFAULT NULL,
  `lastName` varchar(32) DEFAULT NULL COMMENT '姓',
  `firstName` varchar(32) DEFAULT NULL COMMENT '名字',
  `displayName` varchar(32) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `passwordExt` varchar(128) DEFAULT '“1.0”' COMMENT '密码版本',
  `email` varchar(64) DEFAULT NULL,
  `emailVerified` tinyint(4) DEFAULT '1' COMMENT '0--审核过\n1--没有审核\n2--审核不过需要修改\n',
  `phone` varchar(32) DEFAULT NULL,
  `phoneCode` varchar(8) DEFAULT NULL COMMENT '电话号码国家码，00开头',
  `phoneVerified` tinyint(4) DEFAULT '1' COMMENT '0--审核过\n1--没有审核\n2--审核不过需要修改\n',
  `sex` tinyint(4) DEFAULT NULL COMMENT '0--男\n1--女',
  `birthday` datetime DEFAULT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  `homeAddress` varchar(256) DEFAULT NULL,
  `businessAddress` varchar(256) DEFAULT NULL,
  `idNo` varchar(128) DEFAULT NULL,
  `idType` tinyint(4) DEFAULT NULL COMMENT '0--身份证\n1--护照',
  `idVerified` tinyint(4) DEFAULT '1' COMMENT '0--审核过\n1--没有审核\n2--审核不过需要修改\n',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态(0:有效 1：无效)\n0--有效\n1--无效\n2--禁用\n3--审核不过\n',
  `roles` varchar(128) DEFAULT '‘0’' COMMENT '拥有的角色，以，分割',
  `extDate` varchar(512) DEFAULT NULL COMMENT '保存扩展数据json',
  `createTime` datetime DEFAULT NULL,
  `createSource` varchar(128) DEFAULT NULL COMMENT '填写创建来源',
  `updateTime` datetime DEFAULT NULL,
  UNIQUE KEY `idx_user_` (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
/*!50100 PARTITION BY KEY (userId)
PARTITIONS 2 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_user`
--

LOCK TABLES `security_user` WRITE;
/*!40000 ALTER TABLE `security_user` DISABLE KEYS */;
INSERT INTO `security_user` VALUES (29901725,NULL,NULL,NULL,'th063eiCNo','3834d43b9ed01e089f23cbb1b698a6f5','0c0e58b82e5f080d1d00cfb9fc6e6d1c',NULL,0,'008615511119999','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-07-23 16:25:07',NULL,'2019-07-25 09:38:05'),(29902725,NULL,NULL,NULL,'RU4074T315','46059cb62c2605de92e92e9c202bc103','0578d5ac35d11e30b91ab55e2f3896fe',NULL,0,'008615321371297','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-07-30 09:51:29',NULL,NULL),(29903725,NULL,NULL,NULL,'hbv5iR8Zn7','20b5902a18625c94e46a241637da8604','48e60694f97c73115c6a3c741bc079cd',NULL,0,'008615210838554','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-08-28 17:34:45',NULL,NULL),(29903727,NULL,NULL,NULL,'P7cn2AQ281','013ff0e769a3b9b70eff8384e6fa10b3','bc9a1899307629425858a59945472e40',NULL,0,'008618500788699','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-09-02 09:37:56',NULL,NULL),(29903728,NULL,NULL,NULL,'HKAk8q3u8z','7c73cd51c42ce368fd4986343b355ad5','7c663bf9c416bdcd12f72ed7efd05cc2',NULL,0,'00861551111999','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-09-09 17:28:12',NULL,NULL),(29903729,NULL,NULL,NULL,'Wk1972t282','bd7da3979d67224cdd820549601dd688','dd5971f0163d3540445e3028b13fdcec',NULL,0,'00861551119999','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-09-09 17:42:11',NULL,NULL),(29903730,NULL,NULL,NULL,'BRM6v00511','b849b7b16dd7ef0c052e17b481a41a04','6d1000a6c4745e8394a18accd9324159',NULL,0,'008613121998704','0086',1,-1,NULL,NULL,NULL,NULL,NULL,-1,-1,0,NULL,NULL,'2019-09-24 16:09:28',NULL,NULL);
/*!40000 ALTER TABLE `security_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_user_email`
--

DROP TABLE IF EXISTS `security_user_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_user_email` (
  `email` varchar(64) DEFAULT NULL,
  `userId` bigint(8) unsigned DEFAULT NULL,
  UNIQUE KEY `idx_email` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
/*!50100 PARTITION BY KEY (email)
PARTITIONS 2 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_user_email`
--

LOCK TABLES `security_user_email` WRITE;
/*!40000 ALTER TABLE `security_user_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_user_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_user_idno`
--

DROP TABLE IF EXISTS `security_user_idno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_user_idno` (
  `idTotalNo` varchar(128) DEFAULT NULL COMMENT '可能包括，证件国家码，证件类型和证件号码',
  `userId` bigint(8) unsigned DEFAULT NULL,
  UNIQUE KEY `idx_idNo` (`idTotalNo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
/*!50100 PARTITION BY KEY (idTotalNo)
PARTITIONS 2 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_user_idno`
--

LOCK TABLES `security_user_idno` WRITE;
/*!40000 ALTER TABLE `security_user_idno` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_user_idno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_user_phone`
--

DROP TABLE IF EXISTS `security_user_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_user_phone` (
  `phone` varchar(32) DEFAULT NULL,
  `userId` bigint(8) unsigned DEFAULT NULL,
  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
/*!50100 PARTITION BY KEY (phone)
PARTITIONS 2 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_user_phone`
--

LOCK TABLES `security_user_phone` WRITE;
/*!40000 ALTER TABLE `security_user_phone` DISABLE KEYS */;
INSERT INTO `security_user_phone` VALUES ('008615511119999',29901725),('008615321371297',29902725),('008615210838554',29903725),('008618500788699',29903727),('00861551111999',29903728),('00861551119999',29903729),('008613121998704',29903730);
/*!40000 ALTER TABLE `security_user_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'securitydb_study'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-30 10:08:51
