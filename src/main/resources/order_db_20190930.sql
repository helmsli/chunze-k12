-- MySQL dump 10.13  Distrib 5.5.25, for linux2.6 (x86_64)
--
-- Host: localhost    Database: order_db_study
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
-- Table structure for table `order_childs`
--

DROP TABLE IF EXISTS `order_childs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_childs` (
  `catetory` varchar(32) DEFAULT NULL COMMENT '对各种订单进行分类，以区别一个应用中不同类型的订单:例如：买家购买订单，买家退货订单',
  `order_id` varchar(128) DEFAULT NULL COMMENT '后四位UUUU是按照用户或者别的主键进行分库的规则；\r\n后5位到后7位XXX是按照一定的规则进行分区的；\r\nyyyyyyyXXXUUUU\r\n其中yyyyyyy是变长的。',
  `child_category` varchar(32) DEFAULT NULL,
  `child_orderId` varchar(128) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='该订单派生出来的子订单信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_childs`
--

LOCK TABLES `order_childs` WRITE;
/*!40000 ALTER TABLE `order_childs` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_childs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_context__data`
--

DROP TABLE IF EXISTS `order_context__data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_context__data` (
  `partition_id` varchar(16) DEFAULT NULL COMMENT '°´ÕÕ´´½¨Ê±¼ä¼Ó²½Öèid·ÖÇø',
  `category` varchar(32) DEFAULT NULL,
  `order_id` varchar(128) DEFAULT NULL COMMENT 'ºóËÄÎ»UUUUÊÇ°´ÕÕÓÃ»§»òÕß±ðµÄÖ÷¼ü½øÐÐ·Ö¿âµÄ¹æÔò£»\nºó5Î»µ½ºó7Î»XXXÊÇ°´ÕÕÒ»¶¨µÄ¹æÔò½øÐÐ·ÖÇøµÄ£»\nyyyyyyyXXXUUUU\nÆäÖÐyyyyyyyÊÇ±ä³¤µÄ¡£',
  `data_key` varchar(64) DEFAULT NULL,
  `step_id` varchar(32) DEFAULT NULL,
  `flow_id` varchar(128) DEFAULT NULL COMMENT '±êÊ¶Ò»¸ö¶©µ¥ÖÐµÄ¾ßÌåÁ÷³Ì',
  `context_data` blob COMMENT 'ÔÚorder_context_data±íÖÐ£¬Èç¹ûflowidÎª¿Õ£¬ÔòÊý¾Ý±£´æÔÚdata±íÖÐ£¬Èç¹ûflowid²»Îª¿Õ£¬ÔòÊý¾Ý±£´æµ½order_flowÖÐ',
  KEY `index_orderid` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_context__data`
--

LOCK TABLES `order_context__data` WRITE;
/*!40000 ALTER TABLE `order_context__data` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_context__data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_flow`
--

DROP TABLE IF EXISTS `order_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_flow` (
  `partition_id` varchar(16) DEFAULT NULL COMMENT '按照创建时间加步骤id分区',
  `catetory` varchar(32) DEFAULT NULL,
  `order_id` varchar(128) DEFAULT NULL COMMENT '后四位UUUU是按照用户或者别的主键进行分库的规则；\r\n后5位到后7位XXX是按照一定的规则进行分区的；\r\nyyyyyyyXXXUUUU\r\n其中yyyyyyy是变长的。',
  `owner_key` varchar(256) DEFAULT NULL COMMENT '订单归属关键字，比如买家订单，则需要保存买家的用户ID',
  `step_id` varchar(32) DEFAULT NULL,
  `flow_id` varchar(128) DEFAULT NULL COMMENT '标识一个订单中的具体流程',
  `current_status` int(11) DEFAULT NULL,
  `data_key` varchar(64) DEFAULT NULL,
  `context_data` varchar(4096) DEFAULT NULL COMMENT '在order_context_data表中，如果flowid为空，则数据保存在data表中，如果flowid不为空，则数据保存到order_flow中',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `retry_times` varchar(1024) DEFAULT '0' COMMENT '任务失败后重做信息，保存json信息',
  `ret_code` varchar(128) DEFAULT NULL COMMENT '错误和描述',
  `ret_msg` varchar(1024) DEFAULT NULL,
  KEY `index_order_flow` (`order_id`,`partition_id`,`step_id`,`flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按照订单ID和业务关键字分区\r\n按照用户分库：按照XXX分区，一个分区支持40万的数据，一个订单包括20步，一个分区支持';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_flow`
--

LOCK TABLES `order_flow` WRITE;
/*!40000 ALTER TABLE `order_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_flow_def`
--

DROP TABLE IF EXISTS `order_flow_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_flow_def` (
  `catetory` varchar(32) DEFAULT NULL COMMENT '对各种订单进行分类，以区别一个应用中不同类型的订单:例如：买家购买订单，买家退货订单',
  `category_name` varchar(128) DEFAULT NULL,
  `version` varchar(32) DEFAULT NULL COMMENT '标识订单系统的版本，以用来支持后续版本升级；',
  `orderId_category` varchar(256) DEFAULT NULL COMMENT '支持的订单ID生成规则，包括以时间为规则；随机数规则；按照用户和自定义数据分区',
  `deploy_id` varchar(32) DEFAULT NULL COMMENT '主要是为了支持大数据，大并发，针对该类型的订单定义一些常量，以用来支持ngix路由；',
  `steps` varchar(1024) DEFAULT NULL COMMENT '保存步骤信息，其中以;分割步骤信息，以:分割每一个步骤中的字段，主要包括，步骤描述信息和步骤ID；例如：包含两部，第一步是购买，第二步是付款；个数如下：\r\nbuy:01;pay:02;',
  `finished_step` varchar(32) DEFAULT NULL COMMENT '指明该订单结束的状态'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单流程定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_flow_def`
--

LOCK TABLES `order_flow_def` WRITE;
/*!40000 ALTER TABLE `order_flow_def` DISABLE KEYS */;
INSERT INTO `order_flow_def` VALUES ('openAccount','openAccount','0.1','{\"defId\":1,\"dbId\":\"0001\",\"dbIdLength\":4,\"partitionIdLength\":3,\"partitionStartId\":\"500\",\"partitionNum\":1}','1','11','11'),('extension','extension','0.1','{\"defId\":1,\"dbId\":\"0001\",\"dbIdLength\":4,\"partitionIdLength\":3,\"partitionStartId\":\"600\",\"partitionNum\":1}','1','4','4'),('baby_info','baby_info','0.1','{\"defId\":\"1\",\"dbId\":\"0001\",\"dbIdLength\":\"4\",\"partitionIdLength\":\"3\",\"partitionStartId\":\"103\",\"partitionNum\":\"1\"}','1','3','3'),('baby_id','baby_id','0.1','{\"defId\":\"1\",\"dbId\":\"0001\",\"dbIdLength\":\"4\",\"partitionIdLength\":\"3\",\"partitionStartId\":\"103\",\"partitionNum\":\"1\"}','1','3','3'),('babyMainTask','babyMainTask','0.1','{\"defId\":1,\"dbId\":\"0001\",\"dbIdLength\":4,\"partitionIdLength\":3,\"partitionStartId\":\"100\",\"partitionNum\":1}','1','1','1');
/*!40000 ALTER TABLE `order_flow_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_flow_stepdef`
--

DROP TABLE IF EXISTS `order_flow_stepdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_flow_stepdef` (
  `catetory` varchar(32) DEFAULT NULL COMMENT '对各种订单进行分类，以区别一个应用中不同类型的订单:例如：买家购买订单，买家退货订单',
  `step_id` varchar(32) DEFAULT NULL,
  `step_name` varchar(128) DEFAULT NULL,
  `task_in` varchar(2048) DEFAULT NULL COMMENT '填写进入该步骤的时候需要调用的外部任务。就是个URl，即该步骤需要调用的rest的ajax请求。\r\n如果为null，进入该步骤不需要调用外部接口，需要等待外部程序调用触发进入下一个环节；',
  `task_out_error` varchar(1024) DEFAULT NULL COMMENT '定义执行完任务失败后根据返回数值控制状态跳转，这个字段需要填写表格，以；分割行，以，分割列\r\n格式如下：\r\n错误码支持区间配置；支持离散的；\r\n类型(0-单值，1-区间，2-离散数值)返回数值错误码,步骤,是否通知运维(0--不通知，其余通知）;\r\n',
  `task_out_succ` varchar(1024) DEFAULT NULL COMMENT '定义执行完任务成功后根据返回数值控制状态跳转\r\n格式如下：\r\n\r\n0,步骤;\r\n',
  `task_out_default` varchar(1024) DEFAULT NULL COMMENT '注释参见task_out_error',
  `run_type` varchar(32) DEFAULT NULL COMMENT '任务运行类型，定时任务，立即执行任务',
  `run_info` varchar(1024) DEFAULT NULL COMMENT '保存任务类型对应的任务信息，比如定时任务，需要保存定时任务执行的信息；立即执行任务，可以配置优先级，延迟时间等信息;是否需要后台重做',
  `retry_times` varchar(1024) DEFAULT NULL COMMENT '任务失败后重做信息，保存json信息'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_flow_stepdef`
--

LOCK TABLES `order_flow_stepdef` WRITE;
/*!40000 ALTER TABLE `order_flow_stepdef` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_flow_stepdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_main`
--

DROP TABLE IF EXISTS `order_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_main` (
  `partition_id` varchar(32) DEFAULT NULL,
  `catetory` varchar(32) DEFAULT NULL,
  `order_id` varchar(128) DEFAULT NULL,
  `parent_order_id` varchar(128) DEFAULT NULL,
  `parent_order_category` varchar(32) DEFAULT NULL,
  `owner_key` varchar(256) DEFAULT NULL,
  `current_step` varchar(32) DEFAULT NULL,
  `current_status` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_finished` int(11) DEFAULT NULL,
  `flow_id` varchar(128) DEFAULT NULL,
  `creat_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50100 PARTITION BY KEY (partition_id)
PARTITIONS 4 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_main`
--

LOCK TABLES `order_main` WRITE;
/*!40000 ALTER TABLE `order_main` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_main1`
--

DROP TABLE IF EXISTS `order_main1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_main1` (
  `partition_id` int(32) DEFAULT NULL,
  `catetory` varchar(32) DEFAULT NULL,
  `order_id` varchar(128) DEFAULT NULL,
  `parent_order_id` varchar(128) DEFAULT NULL,
  `parent_order_category` varchar(32) DEFAULT NULL,
  `owner_key` varchar(256) DEFAULT NULL,
  `current_step` varchar(32) DEFAULT NULL,
  `current_status` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_finished` int(11) DEFAULT NULL,
  `flow_id` varchar(128) DEFAULT NULL,
  `creat_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_main1`
--

LOCK TABLES `order_main1` WRITE;
/*!40000 ALTER TABLE `order_main1` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_main1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_running`
--

DROP TABLE IF EXISTS `order_running`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_running` (
  `catetory` varchar(32) DEFAULT NULL COMMENT '对各种订单进行分类，以区别一个应用中不同类型的订单:例如：买家购买订单，买家退货订单',
  `partition_id` varchar(16) DEFAULT NULL COMMENT '按照创建时间加步骤id分区',
  `order_id` varchar(128) DEFAULT NULL COMMENT '后四位UUUU是按照用户或者别的主键进行分库的规则；\r\n后5位到后7位XXX是按照一定的规则进行分区的；\r\nyyyyyyyXXXUUUU\r\n其中yyyyyyy是变长的。',
  `create_time` datetime DEFAULT NULL,
  `flow_id` varchar(128) DEFAULT NULL COMMENT '标识一个订单中的具体流程'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_running`
--

LOCK TABLES `order_running` WRITE;
/*!40000 ALTER TABLE `order_running` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_running` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `subsid` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useramount`
--

DROP TABLE IF EXISTS `useramount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `useramount` (
  `userId` varchar(128) NOT NULL,
  `amountId` varchar(128) NOT NULL,
  `amount` bigint(20) DEFAULT '0' COMMENT '0',
  PRIMARY KEY (`userId`,`amountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useramount`
--

LOCK TABLES `useramount` WRITE;
/*!40000 ALTER TABLE `useramount` DISABLE KEYS */;
/*!40000 ALTER TABLE `useramount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useramountlog`
--

DROP TABLE IF EXISTS `useramountlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `useramountlog` (
  `userId` varchar(128) NOT NULL,
  `amountId` varchar(128) NOT NULL,
  `ownerKey` varchar(128) NOT NULL,
  PRIMARY KEY (`userId`,`amountId`,`ownerKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useramountlog`
--

LOCK TABLES `useramountlog` WRITE;
/*!40000 ALTER TABLE `useramountlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `useramountlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userorder`
--

DROP TABLE IF EXISTS `userorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userorder` (
  `createTime` datetime DEFAULT NULL,
  `userId` varchar(128) DEFAULT NULL,
  `orderId` varchar(128) DEFAULT NULL COMMENT '订单编号',
  `category` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `orderDataType` varchar(256) DEFAULT NULL,
  `orderData` blob,
  `updateTime` datetime DEFAULT NULL,
  KEY `Idx_userOrder_orderid` (`createTime`,`userId`,`orderId`),
  KEY `idx_userOrder_status` (`createTime`,`userId`,`status`,`orderId`),
  KEY `index_userorder_id1` (`createTime`,`userId`,`category`,`orderId`),
  KEY `index_userorder_status1` (`createTime`,`userId`,`category`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (to_days(createTime))
SUBPARTITION BY KEY (userId)
SUBPARTITIONS 100
(PARTITION p0 VALUES LESS THAN (737029) ENGINE = InnoDB,
 PARTITION p1 VALUES LESS THAN (737060) ENGINE = InnoDB,
 PARTITION p2 VALUES LESS THAN (737091) ENGINE = InnoDB,
 PARTITION p3 VALUES LESS THAN (737119) ENGINE = InnoDB,
 PARTITION p4 VALUES LESS THAN (737150) ENGINE = InnoDB,
 PARTITION p5 VALUES LESS THAN (737180) ENGINE = InnoDB,
 PARTITION p6 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userorder`
--

LOCK TABLES `userorder` WRITE;
/*!40000 ALTER TABLE `userorder` DISABLE KEYS */;
INSERT INTO `userorder` VALUES ('2017-12-30 00:00:00','519274381030001','519274381030001','baby_info',0,NULL,'{\"babyId\":\"519274381030001\",\"babyName\":\"zhangsan\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:45:28\"}','2019-07-24 11:45:28'),('2017-12-30 00:00:00','29901725','29901725','baby_id',0,NULL,'1','2019-09-06 14:36:38'),('2017-12-30 00:00:00','519274731030001','519274731030001','baby_info',0,NULL,'{\"babyId\":\"519274731030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 14:36:05\"}','2019-07-30 14:36:05'),('2017-12-30 00:00:00','519274041030001','519274041030001','baby_info',0,NULL,'{\"babyId\":\"519274041030001\",\"babyName\":\"\",\"sex\":1,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:22:09\"}','2019-07-24 10:22:09'),('2017-12-30 00:00:00','519274221030001','519274221030001','baby_info',0,NULL,'{\"babyId\":\"519274221030001\",\"babyName\":\"cvvbb\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:15:04\"}','2019-07-24 11:15:04'),('2017-12-30 00:00:00','11201','11201','baby_info',0,NULL,'{\"userId\":\"112\",\"babyId\":\"11201\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-09-06 14:36:06\"}','2019-09-06 14:36:06'),('2017-12-30 00:00:00','519274231030001','519274231030001','baby_info',0,NULL,'{\"babyId\":\"519274231030001\",\"babyName\":\"cvvbb\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:15:26\"}','2019-07-24 11:15:26'),('2017-12-30 00:00:00','519274721030001','519274721030001','baby_info',0,NULL,'{\"babyId\":\"519274721030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 14:36:05\"}','2019-07-30 14:36:05'),('2017-12-30 00:00:00','519274781030001','519274781030001','baby_info',0,NULL,'{\"babyId\":\"519274781030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 15:22:04\"}','2019-07-30 15:22:04'),('2017-12-30 00:00:00','519274491030001','519274491030001','baby_info',0,NULL,'{\"babyId\":\"519274491030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:23:23\"}','2019-07-24 14:23:23'),('2017-12-30 00:00:00','519274211030001','519274211030001','baby_info',0,NULL,'{\"babyId\":\"519274211030001\",\"babyName\":\"cvvbb\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:14:07\"}','2019-07-24 11:14:07'),('2017-12-30 00:00:00','519274471030001','519274471030001','baby_info',0,NULL,'{\"babyId\":\"519274471030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:22:11\"}','2019-07-24 14:22:11'),('2017-12-30 00:00:00','519274741030001','519274741030001','baby_info',0,NULL,'{\"babyId\":\"519274741030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 14:36:05\"}','2019-07-30 14:36:05'),('2017-12-30 00:00:00','29903727','#b123#c1#t1#','babyMainTask',2,NULL,'{\"userId\":\"29903727\",\"babyId\":\"123\",\"taskId\":557290391000001,\"taskType\":1,\"taskTitle\":\"课堂内容口述\",\"courseType\":1,\"periodType\":5,\"period\":[\"1\",\"4\"],\"isValid\":true,\"content\":\"由学生向家长复述在课堂上学习的知识点并进行录音;加深孩子对知识点的理解，提高孩子的表述和总结能力;使家长了解孩子课堂学习情况；\",\"isComplete\":false,\"completeProgress\":0}','2019-09-23 16:36:06'),('2017-12-30 00:00:00','29903727','#b123#c1#t2#','babyMainTask',2,NULL,'{\"userId\":\"29903727\",\"babyId\":\"123\",\"taskId\":557290401000001,\"taskType\":2,\"taskTitle\":\"随堂练习\",\"courseType\":1,\"periodType\":5,\"period\":[\"1\",\"2\"],\"isValid\":true,\"content\":\"由学生向家长复述在课堂上学习的知识点并进行录音;加深孩子对知识点的理解，提高孩子的表述和总结能力;使家长了解孩子课堂学习情况；\",\"isComplete\":false,\"completeProgress\":0}','2019-09-23 16:36:06'),('2017-12-30 00:00:00','29903727','#b123#c1#t3#','babyMainTask',2,NULL,'{\"userId\":\"29903727\",\"babyId\":\"123\",\"taskId\":557290411000001,\"taskType\":3,\"taskTitle\":\"口算、速算练习\",\"courseType\":1,\"periodType\":5,\"period\":[\"1\",\"3\"],\"isValid\":true,\"content\":\"由学生向家长复述在课堂上学习的知识点并进行录音;加深孩子对知识点的理解，提高孩子的表述和总结能力;使家长了解孩子课堂学习情况；\",\"isComplete\":false,\"completeProgress\":0}','2019-09-23 16:36:06'),('2017-12-30 00:00:00','519274441030001','519274441030001','baby_info',0,NULL,'{\"babyId\":\"519274441030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:19:05\"}','2019-07-24 14:19:05'),('2017-12-30 00:00:00','519274521030001','519274521030001','baby_info',0,NULL,'{\"babyId\":\"519274521030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:31:38\"}','2019-07-24 14:31:38'),('2017-12-30 00:00:00','519274641030001','519274641030001','baby_info',0,NULL,'{\"babyId\":\"519274641030001\",\"babyName\":\"aaa\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 10:38:15\"}','2019-07-25 10:38:15'),('2017-12-30 00:00:00','519274091030001','519274091030001','baby_info',0,NULL,'{\"babyId\":\"519274091030001\",\"babyName\":\"\",\"sex\":1,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:28:22\"}','2019-07-24 10:28:22'),('2017-12-30 00:00:00','519274111030001','519274111030001','baby_info',0,NULL,'{\"babyId\":\"519274111030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:04:16\"}','2019-07-24 11:04:16'),('2017-12-30 00:00:00','519274411030001','519274411030001','baby_info',0,NULL,'{\"babyId\":\"519274411030001\",\"babyName\":\"4554646\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:12:03\"}','2019-07-24 14:12:03'),('2017-12-30 00:00:00','519274481030001','519274481030001','baby_info',0,NULL,'{\"babyId\":\"519274481030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:22:26\"}','2019-07-24 14:22:26'),('2017-12-30 00:00:00','519274551030001','519274551030001','baby_info',0,NULL,'{\"babyId\":\"519274551030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:36:32\"}','2019-07-24 14:36:32'),('2017-12-30 00:00:00','112','112','baby_id',0,NULL,'6','2019-09-06 17:22:29'),('2017-12-30 00:00:00','519274131030001','519274131030001','baby_info',0,NULL,'{\"babyId\":\"519274131030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:04:36\"}','2019-07-24 11:04:36'),('2017-12-30 00:00:00','519274371030001','519274371030001','baby_info',0,NULL,'{\"babyId\":\"519274371030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:43:45\"}','2019-07-24 11:43:45'),('2017-12-30 00:00:00','519274661030001','519274661030001','baby_info',0,NULL,'{\"babyId\":\"519274661030001\",\"babyName\":\"qqq\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 10:57:36\"}','2019-07-25 10:57:36'),('2017-12-30 00:00:00','11203','11203','baby_info',0,NULL,'{\"userId\":\"112\",\"babyId\":\"11203\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-09-06 14:36:21\"}','2019-09-06 14:36:21'),('2017-12-30 00:00:00','11202','11202','baby_info',0,NULL,'{\"userId\":\"112\",\"babyId\":\"11202\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-09-06 14:36:18\"}','2019-09-06 14:36:18'),('2017-12-30 00:00:00','519274121030001','519274121030001','baby_info',0,NULL,'{\"babyId\":\"519274121030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:04:16\"}','2019-07-24 11:04:16'),('2017-12-30 00:00:00','519274171030001','519274171030001','baby_info',0,NULL,'{\"babyId\":\"519274171030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:10:04\"}','2019-07-24 11:10:04'),('2017-12-30 00:00:00','519274531030001','519274531030001','baby_info',0,NULL,'{\"babyId\":\"519274531030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:35:28\"}','2019-07-24 14:35:28'),('2017-12-30 00:00:00','519274261030001','519274261030001','baby_info',0,NULL,'{\"babyId\":\"519274261030001\",\"babyName\":\"cvvbb\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:31:12\"}','2019-07-24 11:31:12'),('2017-12-30 00:00:00','519274391030001','519274391030001','baby_info',0,NULL,'{\"babyId\":\"519274391030001\",\"babyName\":\"4554646\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:11:23\"}','2019-07-24 14:11:23'),('2017-12-30 00:00:00','519274191030001','519274191030001','baby_info',0,NULL,'{\"babyId\":\"519274191030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:11:07\"}','2019-07-24 11:11:07'),('2017-12-30 00:00:00','519274321030001','519274321030001','baby_info',0,NULL,'{\"babyId\":\"519274321030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:39:56\"}','2019-07-24 11:39:56'),('2017-12-30 00:00:00','519274051030001','519274051030001','baby_info',0,NULL,'{\"babyId\":\"519274051030001\",\"babyName\":\"\",\"sex\":1,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:23:23\"}','2019-07-24 10:23:23'),('2017-12-30 00:00:00','519274311030001','519274311030001','baby_info',0,NULL,'{\"babyId\":\"519274311030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:39:13\"}','2019-07-24 11:39:13'),('2017-12-30 00:00:00','519274601030001','519274601030001','baby_info',0,NULL,'{\"babyId\":\"519274601030001\",\"babyName\":\"liudehua\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 10:25:58\"}','2019-07-25 10:25:58'),('2017-12-30 00:00:00','519274671030001','519274671030001','baby_info',0,NULL,'{\"babyId\":\"519274671030001\",\"babyName\":\"sdcc\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 11:03:47\"}','2019-07-25 11:03:47'),('2017-12-30 00:00:00','519274701030001','519274701030001','baby_info',0,NULL,'{\"babyId\":\"519274701030001\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-07-25 17:04:12\"}','2019-07-25 17:04:12'),('2017-12-30 00:00:00','519274021030001','519274021030001','baby_info',0,NULL,'{\"babyId\":\"519274021030001\",\"babyName\":\"zhangsan\",\"sex\":0,\"schoolArea\":\"132129\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:08:50\"}','2019-07-24 10:08:50'),('2017-12-30 00:00:00','519274101030001','519274101030001','baby_info',0,NULL,'{\"babyId\":\"519274101030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:04:16\"}','2019-07-24 11:04:16'),('2017-12-30 00:00:00','519274201030001','519274201030001','baby_info',0,NULL,'{\"babyId\":\"519274201030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:13:39\"}','2019-07-24 11:13:39'),('2017-12-30 00:00:00','519274341030001','519274341030001','baby_info',0,NULL,'{\"babyId\":\"519274341030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:41:42\"}','2019-07-24 11:41:42'),('2017-12-30 00:00:00','519274571030001','519274571030001','baby_info',0,NULL,'{\"babyId\":\"519274571030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:37:28\"}','2019-07-24 14:37:28'),('2017-12-30 00:00:00','519274621030001','519274621030001','baby_info',0,NULL,'{\"babyId\":\"519274621030001\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"grade\":4,\"createTime\":\"2019-07-25 10:32:19\"}','2019-07-25 10:32:19'),('2017-12-30 00:00:00','519274691030001','519274691030001','baby_info',0,NULL,'{\"babyId\":\"519274691030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 15:39:06\"}','2019-07-25 15:39:06'),('2017-12-30 00:00:00','519274751030001','519274751030001','baby_info',0,NULL,'{\"babyId\":\"519274751030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 15:22:03\"}','2019-07-30 15:22:03'),('2017-12-30 00:00:00','11206','11206','baby_info',0,NULL,'{\"userId\":\"112\",\"babyId\":\"11206\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-09-06 17:22:29\"}','2019-09-06 17:22:29'),('2017-12-30 00:00:00','519274061030001','519274061030001','baby_info',0,NULL,'{\"babyId\":\"519274061030001\",\"babyName\":\"\",\"sex\":1,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:24:18\"}','2019-07-24 10:24:18'),('2017-12-30 00:00:00','519274681030001','519274681030001','baby_info',0,NULL,'{\"babyId\":\"519274681030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 15:39:03\"}','2019-07-25 15:39:03'),('2017-12-30 00:00:00','519274761030001','519274761030001','baby_info',0,NULL,'{\"babyId\":\"519274761030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 15:22:04\"}','2019-07-30 15:22:04'),('2017-12-30 00:00:00','519274001030001','519274001030001','baby_info',0,NULL,'{\"babyId\":\"519274001030001\",\"babyName\":\"babaaaa\",\"babyAvatar\":\"https://study.cootel.com/storagegroup/M00/00/5E/rBIKSV06n6CAe5TbABBUEYEf2Oc410.png\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"香港特别行政区 香港城区中西区\",\"bookCategory\":2,\"term\":0,\"grade\":4,\"session\":0,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-24 10:07:07\",\"updateTime\":\"2019-07-26 17:08:54\"}','2019-07-26 17:08:54'),('2017-12-30 00:00:00','519274291030001','519274291030001','baby_info',0,NULL,'{\"babyId\":\"519274291030001\",\"babyName\":\"ccccs\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:32:17\"}','2019-07-24 11:32:17'),('2017-12-30 00:00:00','519274431030001','519274431030001','baby_info',0,NULL,'{\"babyId\":\"519274431030001\",\"babyName\":\"4554646\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:13:20\"}','2019-07-24 14:13:20'),('2017-12-30 00:00:00','519274451030001','519274451030001','baby_info',0,NULL,'{\"babyId\":\"519274451030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:22:08\"}','2019-07-24 14:22:08'),('2017-12-30 00:00:00','519274611030001','519274611030001','baby_info',0,NULL,'{\"babyId\":\"519274611030001\",\"babyName\":\"hhhh\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 10:28:20\"}','2019-07-25 10:28:20'),('2017-12-30 00:00:00','519274651030001','519274651030001','baby_info',0,NULL,'{\"babyId\":\"519274651030001\",\"babyName\":\"aaaaa\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 10:44:43\"}','2019-07-25 10:44:43'),('2017-12-30 00:00:00','519274791030001','519274791030001','baby_info',0,NULL,'{\"babyId\":\"519274791030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 15:22:04\"}','2019-07-30 15:22:04'),('2017-12-30 00:00:00','519274081030001','519274081030001','baby_info',0,NULL,'{\"babyId\":\"519274081030001\",\"babyName\":\"\",\"sex\":1,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:28:08\"}','2019-07-24 10:28:08'),('2017-12-30 00:00:00','519274141030001','519274141030001','baby_info',0,NULL,'{\"babyId\":\"519274141030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:05:01\"}','2019-07-24 11:05:01'),('2017-12-30 00:00:00','519274151030001','519274151030001','baby_info',0,NULL,'{\"babyId\":\"519274151030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:09:01\"}','2019-07-24 11:09:01'),('2017-12-30 00:00:00','519274421030001','519274421030001','baby_info',0,NULL,'{\"babyId\":\"519274421030001\",\"babyName\":\"4554646\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:13:15\"}','2019-07-24 14:13:15'),('2017-12-30 00:00:00','519274161030001','519274161030001','baby_info',0,NULL,'{\"babyId\":\"519274161030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:09:39\"}','2019-07-24 11:09:39'),('2017-12-30 00:00:00','519274241030001','519274241030001','baby_info',0,NULL,'{\"babyId\":\"519274241030001\",\"babyName\":\"cvvbb\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:15:30\"}','2019-07-24 11:15:30'),('2017-12-30 00:00:00','519274331030001','519274331030001','baby_info',0,NULL,'{\"babyId\":\"519274331030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:40:01\"}','2019-07-24 11:40:01'),('2017-12-30 00:00:00','519274351030001','519274351030001','baby_info',0,NULL,'{\"babyId\":\"519274351030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:42:38\"}','2019-07-24 11:42:38'),('2017-12-30 00:00:00','519274591030001','519274591030001','baby_info',0,NULL,'{\"babyId\":\"519274591030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:39:17\"}','2019-07-24 14:39:17'),('2017-12-30 00:00:00','519274771030001','519274771030001','baby_info',0,NULL,'{\"babyId\":\"519274771030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 15:22:04\"}','2019-07-30 15:22:04'),('2017-12-30 00:00:00','2990172501','2990172501','baby_info',0,NULL,'{\"userId\":\"29901725\",\"babyId\":\"2990172501\",\"babyName\":\"小明\",\"babyAvatar\":\"https://c-ssl.duitang.com/uploads/item/201809/26/20180926162125_vjbwi.jpg\",\"sex\":0,\"areaCode\":0,\"bookCategory\":0,\"term\":1,\"grade\":3,\"session\":2016,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-09-06 14:36:38\"}','2019-09-06 14:36:38'),('2017-12-30 00:00:00','519274301030001','519274301030001','baby_info',0,NULL,'{\"babyId\":\"519274301030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:36:10\"}','2019-07-24 11:36:10'),('2017-12-30 00:00:00','519274511030001','519274511030001','baby_info',0,NULL,'{\"babyId\":\"519274511030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:24:01\"}','2019-07-24 14:24:01'),('2017-12-30 00:00:00','519274011030001','519274011030001','baby_info',0,NULL,'{\"babyId\":\"519274011030001\",\"babyName\":\"zhangsan\",\"sex\":0,\"schoolArea\":\"132129\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:08:00\"}','2019-07-24 10:08:00'),('2017-12-30 00:00:00','519274251030001','519274251030001','baby_info',0,NULL,'{\"babyId\":\"519274251030001\",\"babyName\":\"cvvbb\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:30:44\"}','2019-07-24 11:30:44'),('2017-12-30 00:00:00','519274541030001','519274541030001','baby_info',0,NULL,'{\"babyId\":\"519274541030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:36:28\"}','2019-07-24 14:36:28'),('2017-12-30 00:00:00','519274711030001','519274711030001','baby_info',0,NULL,'{\"babyId\":\"519274711030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"term\":0,\"grade\":1,\"session\":2018,\"provinceId\":0,\"cityId\":0,\"areaId\":0,\"createTime\":\"2019-07-30 14:36:05\"}','2019-07-30 14:36:05'),('2017-12-30 00:00:00','11204','11204','baby_info',0,NULL,'{\"userId\":\"112\",\"babyId\":\"11204\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-09-06 17:04:29\"}','2019-09-06 17:04:29'),('2017-12-30 00:00:00','519274461030001','519274461030001','baby_info',0,NULL,'{\"babyId\":\"519274461030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:22:10\"}','2019-07-24 14:22:10'),('2017-12-30 00:00:00','519274581030001','519274581030001','baby_info',0,NULL,'{\"babyId\":\"519274581030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:38:06\"}','2019-07-24 14:38:06'),('2017-12-30 00:00:00','519274071030001','519274071030001','baby_info',0,NULL,'{\"babyId\":\"519274071030001\",\"babyName\":\"\",\"sex\":1,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:24:57\"}','2019-07-24 10:24:57'),('2017-12-30 00:00:00','519274181030001','519274181030001','baby_info',0,NULL,'{\"babyId\":\"519274181030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:10:29\"}','2019-07-24 11:10:29'),('2017-12-30 00:00:00','519274281030001','519274281030001','baby_info',0,NULL,'{\"babyId\":\"519274281030001\",\"babyName\":\"ccccs\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:32:10\"}','2019-07-24 11:32:10'),('2017-12-30 00:00:00','519274361030001','519274361030001','baby_info',0,NULL,'{\"babyId\":\"519274361030001\",\"babyName\":\"gkvvvw\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:42:45\"}','2019-07-24 11:42:45'),('2017-12-30 00:00:00','519274031030001','519274031030001','baby_info',0,NULL,'{\"babyId\":\"519274031030001\",\"babyName\":\"zhangsan\",\"sex\":0,\"schoolArea\":\"132129\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 10:09:59\"}','2019-07-24 10:09:59'),('2017-12-30 00:00:00','519274501030001','519274501030001','baby_info',0,NULL,'{\"babyId\":\"519274501030001\",\"babyName\":\"nxnxn\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:23:52\"}','2019-07-24 14:23:52'),('2017-12-30 00:00:00','519274271030001','519274271030001','baby_info',0,NULL,'{\"babyId\":\"519274271030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 11:32:03\"}','2019-07-24 11:32:03'),('2017-12-30 00:00:00','519274401030001','519274401030001','baby_info',0,NULL,'{\"babyId\":\"519274401030001\",\"babyName\":\"4554646\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:11:56\"}','2019-07-24 14:11:56'),('2017-12-30 00:00:00','519274561030001','519274561030001','baby_info',0,NULL,'{\"babyId\":\"519274561030001\",\"babyName\":\"\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-24 14:37:16\"}','2019-07-24 14:37:16'),('2017-12-30 00:00:00','519274631030001','519274631030001','baby_info',0,NULL,'{\"babyId\":\"519274631030001\",\"babyName\":\"liud\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"110108\",\"bookCategory\":1,\"grade\":1,\"createTime\":\"2019-07-25 10:36:40\"}','2019-07-25 10:36:40'),('2017-12-30 00:00:00','11205','11205','baby_info',0,NULL,'{\"userId\":\"112\",\"babyId\":\"11205\",\"babyName\":\"baby-02\",\"babyAvatar\":\"/img2.jpg\",\"sex\":1,\"areaCode\":0,\"schoolArea\":\"beijing2\",\"bookCategory\":2,\"term\":2,\"grade\":4,\"session\":2015,\"provinceName\":\"北京市\",\"provinceId\":110000,\"cityName\":\"北京城区\",\"cityId\":110100,\"areaName\":\"东城区\",\"areaId\":110101,\"createTime\":\"2019-09-06 17:19:57\"}','2019-09-06 17:19:57');
/*!40000 ALTER TABLE `userorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'order_db_study'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-30 10:07:36
