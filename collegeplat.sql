/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : collegeplat

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2019-06-02 21:36:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `activity`
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `uid` int(8) DEFAULT NULL,
  `cid` int(8) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `content` text,
  `flag` int(2) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `cid` (`cid`),
  CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `activity_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `activity_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES ('1', '10', '1', '双选会志愿者', '四川省成都市成都工业学院', '3月23号到3月25号双选会需要25名志愿者', '0');
INSERT INTO `activity` VALUES ('2', '10', '2', '国色天香组队游玩', '双流国色天香', '本周六上午九点组队去国色天香游玩，有意者联系，四到六人。', '0');
INSERT INTO `activity` VALUES ('3', '10', '4', '发传单', '六舍', '需要两名男生在六舍发传单，一天一百，有意者联系18782287405', '0');
INSERT INTO `activity` VALUES ('4', '2', '5', '成都工业学院歌唱比赛', '四川省成都市成都工业学院', '2019年5月6日在长虹会堂举行第一届歌唱比赛，欢迎各位参加', '0');

-- ----------------------------
-- Table structure for `activity_category`
-- ----------------------------
DROP TABLE IF EXISTS `activity_category`;
CREATE TABLE `activity_category` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity_category
-- ----------------------------
INSERT INTO `activity_category` VALUES ('1', '志愿活动');
INSERT INTO `activity_category` VALUES ('2', '外出游玩');
INSERT INTO `activity_category` VALUES ('3', '商业活动');
INSERT INTO `activity_category` VALUES ('4', '兼职信息');
INSERT INTO `activity_category` VALUES ('5', '校园活动');
INSERT INTO `activity_category` VALUES ('6', '其它');

-- ----------------------------
-- Table structure for `activity_join`
-- ----------------------------
DROP TABLE IF EXISTS `activity_join`;
CREATE TABLE `activity_join` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `aid` int(8) DEFAULT NULL,
  `uid` int(8) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL COMMENT '联系方式',
  `content` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `state` int(2) DEFAULT NULL COMMENT '报名状态，0为暂未通过，1为通过',
  `flag` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aid` (`aid`),
  KEY `uid` (`uid`),
  CONSTRAINT `activity_join_ibfk_1` FOREIGN KEY (`aid`) REFERENCES `activity` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `activity_join_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of activity_join
-- ----------------------------
INSERT INTO `activity_join` VALUES ('1', '1', '10', '123', 'qq295186137', 'qwe', '0', '0');
INSERT INTO `activity_join` VALUES ('2', '1', '11', '234', 'qq295186137', '参加', '1', '0');
INSERT INTO `activity_join` VALUES ('3', '2', '11', '234', 'qq295186137', '1234', '0', '0');
INSERT INTO `activity_join` VALUES ('4', '3', '11', '234', '手机18782287405', '参加', '0', '0');
INSERT INTO `activity_join` VALUES ('5', '1', '2', 'aaa', 'qq295186137', '123', '0', '0');
INSERT INTO `activity_join` VALUES ('6', '1', '2', 'aaa', 'qq295186137', '1111', '0', '0');
INSERT INTO `activity_join` VALUES ('7', '4', '2', 'aaa', 'qq295186137', '123', '1', '0');

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `state` int(2) DEFAULT NULL,
  `flag` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', 'admin', 'admin', '0', '0');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `uid` int(8) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `tid` int(8) DEFAULT NULL COMMENT '类型id',
  `content` text,
  `time` datetime DEFAULT NULL,
  `num` int(8) DEFAULT NULL COMMENT '评论数',
  `flag` int(2) DEFAULT '0',
  `img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `tid` (`tid`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `article_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '10', '123', '1', null, '2019-05-16 16:43:08', '0', '1', null);
INSERT INTO `article` VALUES ('2', '10', '测试1', '1', '测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1', '2019-05-16 16:47:48', '0', '0', 'forumimg/1557996424790.png');
INSERT INTO `article` VALUES ('3', '10', '测试1', '1', '测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1测试1', '2019-05-16 16:49:10', '1', '0', 'forumimg/1557996543783.png');
INSERT INTO `article` VALUES ('4', '10', '寻找钥匙', '1', '本周五在德五楼丢失一串钥匙，请拾到者联系18782287405', '2019-05-25 16:11:39', '4', '0', null);

-- ----------------------------
-- Table structure for `article_comment`
-- ----------------------------
DROP TABLE IF EXISTS `article_comment`;
CREATE TABLE `article_comment` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `artid` int(8) DEFAULT NULL,
  `uid` int(8) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `flag` int(2) DEFAULT '0',
  `num` int(8) DEFAULT NULL COMMENT '回复数',
  PRIMARY KEY (`id`),
  KEY `artid` (`artid`),
  KEY `uid` (`uid`),
  CONSTRAINT `article_comment_ibfk_1` FOREIGN KEY (`artid`) REFERENCES `article` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `article_comment_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_comment
-- ----------------------------
INSERT INTO `article_comment` VALUES ('1', '123', '1', '2', '2019-05-17 20:46:37', '0', '2');
INSERT INTO `article_comment` VALUES ('2', '测试ssss', '1', '2', '2019-05-17 16:50:46', '0', '0');
INSERT INTO `article_comment` VALUES ('3', '测试', '2', '2', '2019-05-17 16:52:02', '0', '1');
INSERT INTO `article_comment` VALUES ('4', '测试', '2', '10', '2019-05-17 20:40:28', '0', '0');
INSERT INTO `article_comment` VALUES ('5', 'asddddd', '2', '10', '2019-05-17 20:40:39', '0', '0');
INSERT INTO `article_comment` VALUES ('6', '没看见', '4', '2', '2019-05-25 20:44:27', '0', '2');
INSERT INTO `article_comment` VALUES ('7', '没看见', '4', '2', '2019-05-25 20:49:32', '0', '0');
INSERT INTO `article_comment` VALUES ('8', '123', '4', '2', '2019-05-25 20:52:02', '0', '0');
INSERT INTO `article_comment` VALUES ('9', '测试回复', '4', '2', '2019-05-25 20:56:27', '0', '0');
INSERT INTO `article_comment` VALUES ('10', '测试回复', '4', '2', '2019-05-25 20:58:49', '0', '0');
INSERT INTO `article_comment` VALUES ('11', '111', '3', '2', '2019-05-26 13:10:24', '0', '1');

-- ----------------------------
-- Table structure for `article_multi`
-- ----------------------------
DROP TABLE IF EXISTS `article_multi`;
CREATE TABLE `article_multi` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `comid` int(8) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `uid` int(8) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `flag` int(2) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `comid` (`comid`),
  CONSTRAINT `article_multi_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `article_multi_ibfk_3` FOREIGN KEY (`comid`) REFERENCES `article_comment` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_multi
-- ----------------------------
INSERT INTO `article_multi` VALUES ('1', '1', 'asdadsa', '3', '2019-05-18 19:37:39', '0');
INSERT INTO `article_multi` VALUES ('2', '1', '去去去去去去去', '4', '2019-05-17 19:38:22', '0');
INSERT INTO `article_multi` VALUES ('3', '6', '好的', '2', '2019-05-25 21:33:22', '0');
INSERT INTO `article_multi` VALUES ('4', '6', '测试', '2', '2019-05-25 21:34:41', '0');
INSERT INTO `article_multi` VALUES ('5', '11', '111', '2', '2019-05-26 13:10:28', '0');
INSERT INTO `article_multi` VALUES ('6', '3', '123', '2', '2019-05-31 11:29:56', '0');

-- ----------------------------
-- Table structure for `article_type`
-- ----------------------------
DROP TABLE IF EXISTS `article_type`;
CREATE TABLE `article_type` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_type
-- ----------------------------
INSERT INTO `article_type` VALUES ('1', '失物招领');
INSERT INTO `article_type` VALUES ('2', '租赁');
INSERT INTO `article_type` VALUES ('3', '代办');
INSERT INTO `article_type` VALUES ('4', '学习求助');
INSERT INTO `article_type` VALUES ('5', '生活求助');
INSERT INTO `article_type` VALUES ('6', '其他');

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `user_id` int(8) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '商品描述',
  `flag` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('5', '10', '数据库书', '10', 'goodsimg/1556083724849.jpg', '2019-04-24', '二手七成新，有笔记', '1');
INSERT INTO `goods` VALUES ('6', '10', '笔记本', '5', 'goodsimg/1556083826081.jpg', '2019-04-24', '全新笔记本', '0');
INSERT INTO `goods` VALUES ('7', '10', '小音箱', '10', 'goodsimg/1556083891527.jpg', '2019-04-24', '使用一年多，能够使用蓝牙、存储卡', '0');
INSERT INTO `goods` VALUES ('8', '10', '鼠标', '12', 'goodsimg/1556083964449.jpg', '2019-04-24', '二手罗技鼠标，八成新', '0');
INSERT INTO `goods` VALUES ('9', '10', '数据库书', '12', 'goodsimg/1557045763534.jpg', '2019-05-05', '二手八成新，需要的来6119', '0');
INSERT INTO `goods` VALUES ('10', '2', '华硕笔记本', '2000', 'goodsimg/1558844567018.jpg', '2019-05-26', '二手华硕电脑，使用一年，原价4900买来。', '1');
INSERT INTO `goods` VALUES ('11', '2', '华硕笔记本电脑', '2000', 'goodsimg/1558844899403.jpg', '2019-05-26', '二手六成新，2017年购，原价4900，需要的联系18782287405', '0');

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `to_id` int(8) DEFAULT NULL,
  `from_id` int(8) DEFAULT NULL,
  `good_id` int(8) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sell_id` (`to_id`),
  KEY `buy_id` (`from_id`),
  KEY `good_id` (`good_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`to_id`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`from_id`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `message_ibfk_3` FOREIGN KEY (`good_id`) REFERENCES `goods` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '10', '2', '5', '123', '2019-05-01 18:06:53');
INSERT INTO `message` VALUES ('2', '10', '2', '5', '1234', '2019-05-05 18:07:30');
INSERT INTO `message` VALUES ('3', '10', '2', '5', '123', '2019-05-06 14:35:51');
INSERT INTO `message` VALUES ('4', '10', '2', '5', '你好', '2019-05-06 14:37:12');
INSERT INTO `message` VALUES ('5', '10', '2', '5', '我想要买书', '2019-05-06 14:38:27');
INSERT INTO `message` VALUES ('6', '10', '2', '5', '可以便宜一点吗', '2019-05-06 14:40:36');
INSERT INTO `message` VALUES ('7', '2', '10', '5', '可以', '2019-05-06 14:41:27');
INSERT INTO `message` VALUES ('10', '10', '11', '5', 'asd', '2019-05-08 15:31:11');
INSERT INTO `message` VALUES ('11', '10', '11', '5', '我想买这本书', '2019-05-08 15:31:34');
INSERT INTO `message` VALUES ('12', '2', '10', '5', '来6119拿', '2019-05-08 15:56:13');
INSERT INTO `message` VALUES ('13', '11', '10', '5', '好的', '2019-05-08 15:59:25');
INSERT INTO `message` VALUES ('14', '2', '10', '5', '晚上在', '2019-05-08 15:59:55');
INSERT INTO `message` VALUES ('15', '10', '2', '6', '我想买，可以便宜点吗', '2019-05-26 12:30:26');
INSERT INTO `message` VALUES ('16', '10', '2', '6', '123', '2019-05-26 13:42:55');

-- ----------------------------
-- Table structure for `resource`
-- ----------------------------
DROP TABLE IF EXISTS `resource`;
CREATE TABLE `resource` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `state` int(2) DEFAULT '0',
  `uid` int(8) DEFAULT NULL,
  `flag` int(2) DEFAULT '0',
  `tid` int(8) DEFAULT NULL,
  `num` int(8) DEFAULT '0' COMMENT '下载次数',
  `likenum` int(8) DEFAULT NULL COMMENT '点赞次数',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `tid` (`tid`),
  CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `resource_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource
-- ----------------------------
INSERT INTO `resource` VALUES ('2', '乐帮生活服务平台论文', '乐帮生活服务平台论文', 'file/1558622126785.docx', '1', '10', '0', null, '8', '0');
INSERT INTO `resource` VALUES ('3', '基本模型机', '微机原理专周', 'file/1558691372201.pdsprj', '1', '10', '0', null, '1', '0');
INSERT INTO `resource` VALUES ('4', 'Mybatis学习', 'Mybatis中一对一、一对多、多对多的xml文件写法', 'file/1558789295660.xml', '1', '2', '0', null, '0', '0');

-- ----------------------------
-- Table structure for `resource_type`
-- ----------------------------
DROP TABLE IF EXISTS `resource_type`;
CREATE TABLE `resource_type` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of resource_type
-- ----------------------------

-- ----------------------------
-- Table structure for `traffic`
-- ----------------------------
DROP TABLE IF EXISTS `traffic`;
CREATE TABLE `traffic` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `uid` int(8) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `flag` int(2) DEFAULT '0',
  `tid` int(8) DEFAULT NULL,
  `joinnum` int(8) DEFAULT NULL,
  `neednum` int(8) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `tid` (`tid`),
  CONSTRAINT `traffic_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `traffic_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `traffic_type` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of traffic
-- ----------------------------
INSERT INTO `traffic` VALUES ('1', '2019-05-16 18:17:02', '2019-05-31 18:17:06', '1', '成都工业学院大门到犀浦', '0', '1', '1', '3', '18782287405');
INSERT INTO `traffic` VALUES ('2', '2019-05-31 08:00:00', '2019-05-31 08:28:00', '10', '成都工业学院大门到成都东站', '1', '1', '0', '4', '18782287408');
INSERT INTO `traffic` VALUES ('3', '2019-05-31 01:01:00', '2019-05-31 01:01:00', '10', '111', '1', '1', '0', '1', '1');
INSERT INTO `traffic` VALUES ('4', '2019-05-30 02:02:00', '2019-05-31 02:59:00', '10', '123', '1', '1', '0', '2', '22222');
INSERT INTO `traffic` VALUES ('5', '2019-05-31 05:05:00', '2019-05-31 06:04:00', '2', '学校回安徽', '0', '2', '0', '4', '18782288995');

-- ----------------------------
-- Table structure for `traffic_join`
-- ----------------------------
DROP TABLE IF EXISTS `traffic_join`;
CREATE TABLE `traffic_join` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `tafficId` int(8) DEFAULT NULL,
  `uid` int(8) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `flag` int(2) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tafficId` (`tafficId`),
  KEY `uid` (`uid`),
  CONSTRAINT `traffic_join_ibfk_1` FOREIGN KEY (`tafficId`) REFERENCES `traffic` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `traffic_join_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of traffic_join
-- ----------------------------
INSERT INTO `traffic_join` VALUES ('1', '1', '2', '18782287405', '123', '0');
INSERT INTO `traffic_join` VALUES ('2', '2', '2', '18782287405', '1234', '0');

-- ----------------------------
-- Table structure for `traffic_type`
-- ----------------------------
DROP TABLE IF EXISTS `traffic_type`;
CREATE TABLE `traffic_type` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of traffic_type
-- ----------------------------
INSERT INTO `traffic_type` VALUES ('1', '拼车');
INSERT INTO `traffic_type` VALUES ('2', '组队回家');
INSERT INTO `traffic_type` VALUES ('3', '旅行');
INSERT INTO `traffic_type` VALUES ('4', '接送');
INSERT INTO `traffic_type` VALUES ('5', '其它');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(8) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zz', '123123', 'z', 'a@store.com', '123123132', '2019-03-01', '男', '0', '6c1410c7292540bb8ebc3231cb3627b1');
INSERT INTO `user` VALUES ('2', 'ccc', 'ccc', 'aaa', 'bbb@store.com', '15723689921', '2015-11-04', '男', '0', '9782f3e837ff422b9aee8b6381ccf927bdd9d2ced10d48f4ba4b9f187edf7738');
INSERT INTO `user` VALUES ('3', 'bb', 'bb', '张三', 'bbb@store.com', '15723689921', '1990-02-01', '男', '0', '1258e96181a9457987928954825189000bae305094a042d6bd9d2d35674684e6');
INSERT INTO `user` VALUES ('4', '123444', '123', '123', '123@qq.com', null, '2019-04-11', '男', '0', '19494a6006a840f199c78ab3e08c8aa2');
INSERT INTO `user` VALUES ('5', 'cc', 'cc', '张三', 'bbb@store.com', '15723689921', '2015-11-03', '男', '0', '19f100aa81184c03951c4b840a725b6a98097aa1106a4a38ba1c29f1a496c231');
INSERT INTO `user` VALUES ('6', '1234', '123', '123', '123@qq.com', null, '2019-04-23', '男', '0', '2e63d469a58a4ae1b016e5935d332de9');
INSERT INTO `user` VALUES ('7', '123123', '123', '1', '123@qq.com', null, '2019-04-06', '男', '0', '1f9ee46a33c14472b43aa58d7308c1b3');
INSERT INTO `user` VALUES ('8', '2345', '1', '1', 'a@store.com', null, '2019-03-01', '男', '1', null);
INSERT INTO `user` VALUES ('9', 'bbb', 'bbb', '老王', 'bbb@store.com', '15712344823', '2000-02-01', '男', '0', '71a3a933353347a4bcacff699e6baa9c950a02f6b84e4f6fb8404ca06febfd6f');
INSERT INTO `user` VALUES ('10', '123', '123', '周鹏', '123@qq.com', null, '2019-03-01', '男', '0', '10abb5b0b2914d14a6e086668aade08b');
INSERT INTO `user` VALUES ('11', '234', '123', '234', '123@qq.com', null, '2019-03-01', '男', '0', '90384baa764e467b92bfb1d7fab3288a');
INSERT INTO `user` VALUES ('12', 'aaa', 'aaa', '小王', 'aaa@store.com', '15712344823', '2000-02-01', '男', '1', null);
INSERT INTO `user` VALUES ('13', 'qqq', 'qwe', '123', 'send@plat.com', null, '2017-04-24', '男', '0', '19f209a569dc4438a9b3f83002533b67');
INSERT INTO `user` VALUES ('14', 'zp', '123', 'zzz', 'send@plat.com', null, '2019-04-03', '男', '0', '54d9a1f36bd74572bc0a550ee68768c7');
