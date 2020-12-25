/*
Navicat MariaDB Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 100407
Source Host           : 127.0.0.1:3306
Source Database       : blog

Target Server Type    : MariaDB
Target Server Version : 100407
File Encoding         : 65001

Date: 2020-02-17 15:27:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cate
-- ----------------------------
DROP TABLE IF EXISTS `cate`;
CREATE TABLE `cate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `intro` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cate
-- ----------------------------
INSERT INTO `cate` VALUES ('1', '博客文章', '0', 'article');
INSERT INTO `cate` VALUES ('3', '学习笔记', '0', 'learn');
INSERT INTO `cate` VALUES ('4', '动态网站', '0', 'goweb');
INSERT INTO `cate` VALUES ('5', 'python', '0', 'python');
INSERT INTO `cate` VALUES ('6', 'javascript', '0', 'javascript');

-- ----------------------------
-- Table structure for opts
-- ----------------------------
DROP TABLE IF EXISTS `opts`;
CREATE TABLE `opts` (
  `key` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  `intro` varchar(255) NOT NULL DEFAULT '',
  KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of opts
-- ----------------------------
INSERT INTO `opts` VALUES ('analytic', '<script async src=\"//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js\"></script> ', '统计代码，可以添加百度统计、Google 统计等');
INSERT INTO `opts` VALUES ('auto_summary', '0', '');
INSERT INTO `opts` VALUES ('comment', '{\"clientID\": \"clientIDValue\",\"clientSecret\": \"clientSecretValue\",\"repo\": \"repoValue\",\"owner\": \"zxysilentValue\",\"admin\":[\"adminValue\"],\"distractionFreeMode\":true,\"githubUserName\":\"githubUserNameValue\",\"使用说明\":\"https://github.com/gitalk/gitalk\"}', '评论类型');
INSERT INTO `opts` VALUES ('custom_js', 'console.log(\"https://blog.zxysilent.com\")', '自定义js');
INSERT INTO `opts` VALUES ('introription', 'zxysilent;zxysilent blog;zxyslt;zxyslt blog;', '网站描述');
INSERT INTO `opts` VALUES ('favicon_url', '/favicon.ico', 'favicon');
INSERT INTO `opts` VALUES ('github_url', 'https://github.com/zxysilent', 'GitHub 地址');
INSERT INTO `opts` VALUES ('keywords', 'zxysilent,zxyslt,zxy', '网站关键字');
INSERT INTO `opts` VALUES ('logo_url', '/static/logo.png', 'logo 地址');
INSERT INTO `opts` VALUES ('miitbeian', '蜀ICP备16011344号-2', '网站备案号');
INSERT INTO `opts` VALUES ('page_size', '6', '文章一页显示的条数');
INSERT INTO `opts` VALUES ('site_url', 'https://blog.zxysilent.com', '网站地址');
INSERT INTO `opts` VALUES ('title', 'zxysilent', '网站标题');
INSERT INTO `opts` VALUES ('bili_url', 'https://weibo.com/u/2909680165', '微博地址');

-- ----------------------------
-- Table structure for opts_key
-- ----------------------------
DROP TABLE IF EXISTS `opts_key`;
CREATE TABLE `opts_key` (
  `key` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(2048) NOT NULL DEFAULT '',
  `intro` varchar(255) NOT NULL DEFAULT '',
  KEY `key` (`key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of opts
-- ----------------------------
INSERT INTO `opts_key` VALUES ('kuaiyun_accesskey', '', 'accessKey');
INSERT INTO `opts_key` VALUES ('kuaiyun_secretkey', '', 'secretKey');
INSERT INTO `opts_key` VALUES ('kuaiyun_voucher', '', '用户凭证');
INSERT INTO `opts_key` VALUES ('kuaiyun_resource', '', 'resource');
INSERT INTO `opts_key` VALUES ('kuaiyun_bucketname', '', '空间名');
INSERT INTO `opts_key` VALUES ('kuaiyun_domain', '', '绑定域名');
INSERT INTO `opts_key` VALUES ('kuaiyun_cloudpath', 'web/', '上传目录');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 为文章，1 为页面',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 为草稿，1 为待审核，2 为已拒绝，3 为已经发布',
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'URL 的 pathname',
  `summary` longtext NOT NULL COMMENT '摘要',
  `markdown_content` longtext NOT NULL,
  `content` longtext NOT NULL,
  `allow_comment` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 为允许， 0 为不允许',
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime NOT NULL,
  `is_public` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1 为公开，0 为不公开',
  `comment_num` int(11) NOT NULL DEFAULT 0,
  `options` varchar(4096) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '一些选项，JSON 结构',
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of post
-- ----------------------------
-- ----------------------------
-- Table structure for post_tag
-- ----------------------------
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_tag` (`post_id`,`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_tag
-- ----------------------------


-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `intro` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tag
-- ----------------------------


-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `num` varchar(255) NOT NULL DEFAULT '',
  `pass` varchar(255) NOT NULL DEFAULT '',
  `role` int(11) NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(32) NOT NULL DEFAULT '',
  `ecount` int(11) NOT NULL DEFAULT 0,
  `ltime` datetime NOT NULL,
  `ctime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`num`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'zxysilent', 'zxysilent', '3b861abeaa25fba9d03898324463f7', '1074791424', 'zxysilent@foxmail.com', '', '127.0.0.1', '0', '2020-02-17 15:00:39', '2017-04-05 23:28:35');
