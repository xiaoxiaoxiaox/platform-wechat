SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for wx_auth_callback
-- ----------------------------
DROP TABLE IF EXISTS `wx_auth_callback`;
CREATE TABLE `wx_auth_callback` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` text COMMENT '回调返回信息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment '微信服务器消息回调通知';

-- ----------------------------
-- Table structure for wx_auth_info
-- ----------------------------
DROP TABLE IF EXISTS `wx_auth_info`;
CREATE TABLE `wx_auth_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `authorizer_appid` varchar(50) NOT NULL DEFAULT '' COMMENT '授权小程序的 appid',
  `authorizer_access_token` varchar(255) NOT NULL DEFAULT '' COMMENT '授权小程序的 access_token',
  `authorizer_refresh_token` varchar(255) NOT NULL DEFAULT '' COMMENT '授权小程序的 refresh_token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token 的生命周期（秒）',
  `func_info` text COMMENT '权限集合',
  `is_auth` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否授权',
  `app_version` varchar(20) NOT NULL DEFAULT '0' COMMENT '小程序版本',
  `submit_id` int(11) DEFAULT '0' COMMENT '最新提交的审核id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `authorizer_appid` (`authorizer_appid`) USING BTREE,
  KEY `site_id` (`site_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wx_auto_log
-- ----------------------------
DROP TABLE IF EXISTS `wx_auto_log`;
CREATE TABLE `wx_auto_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL COMMENT '类型 1 提交审核 2 发布',
  `appid` varchar(50) NOT NULL COMMENT 'appid',
  `site_id` varchar(255) NOT NULL COMMENT '0',
  `code` int(10) NOT NULL DEFAULT '0' COMMENT '运行状态码200 成功',
  `msg` varchar(255) NOT NULL DEFAULT '' COMMENT '运行消息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wx_code_draft
-- ----------------------------
DROP TABLE IF EXISTS `wx_code_draft`;
CREATE TABLE `wx_code_draft` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(25) NOT NULL DEFAULT '1.0.0' COMMENT '模板版本号',
  `desc` varchar(100) NOT NULL DEFAULT '初始化' COMMENT '模板描述',
  `draft_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '草稿 ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '草稿上传时间',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为最新',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `draft_id` (`draft_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8  COMMENT='代码草稿，会多次保存，取最新一次';

-- ----------------------------
-- Table structure for wx_code_submit_info
-- ----------------------------
DROP TABLE IF EXISTS `wx_code_submit_info`;
CREATE TABLE `wx_code_submit_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `auditid` int(10) unsigned NOT NULL COMMENT '审核ID',
  `authorizer_appid` varchar(50) NOT NULL DEFAULT '' COMMENT '授权小程序的 appid',
  `template_info` text COMMENT '代码模板信息',
  `upload_app_json` text COMMENT '上传代码时的前端 app.json 配置',
  `item_list` text COMMENT '提交代码到审核时的 item_list 数据',
  `category_list` text COMMENT '所有的分类',
  `page_list` text COMMENT '小程序的页面配置',
  `is_task` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加入队列 0 否 1是',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '9' COMMENT '审核状态, 0 为审核通过，1为审核不通过，2 为审核中',
  `reasons` varchar(500) NOT NULL DEFAULT '' COMMENT '审核不通过的原因',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `auditid` (`auditid`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `authorizer_appid` (`authorizer_appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wx_code_template
-- ----------------------------
DROP TABLE IF EXISTS `wx_code_template`;
CREATE TABLE `wx_code_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_version` varchar(25) NOT NULL DEFAULT '1.0.0' COMMENT '模板版本号',
  `user_desc` varchar(100) NOT NULL DEFAULT '初始化' COMMENT '模板描述',
  `template_id` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '模板 ID',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模板上传时间',
  `app_json` text COMMENT '小程序配置',
  `ext_json` text COMMENT '额外参数配置',
  `ext_page_json` text COMMENT '页面参数配置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `template_id` (`template_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代码模板';

-- ----------------------------
-- Table structure for wx_log
-- ----------------------------
DROP TABLE IF EXISTS `wx_log`;
CREATE TABLE `wx_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) NOT NULL COMMENT '小程序 appid',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '记录名称',
  `data` text COMMENT '具体信息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `appid` (`appid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for wx_miniprogram_info
-- ----------------------------
DROP TABLE IF EXISTS `wx_miniprogram_info`;
CREATE TABLE `wx_miniprogram_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(50) NOT NULL COMMENT '授权方昵称',
  `head_img` varchar(255) NOT NULL COMMENT '授权方头像',
  `service_type_info` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '授权方小程序类型',
  `verify_type_info` tinyint(1) NOT NULL DEFAULT '-1' COMMENT '授权方认证类型，-1代表未认证，0代表微信认证',
  `user_name` varchar(64) NOT NULL COMMENT '小程序的原始ID',
  `signature` varchar(255) NOT NULL COMMENT '帐号介绍',
  `principal_name` varchar(100) NOT NULL COMMENT '小程序的主体名称',
  `business_info` text COMMENT '用以了解以下功能的开通状况（0代表未开通，1代表已开通）： open_store:是否开通微信门店功能 open_scan:是否开通微信扫商品功能 open_pay:是否开通微信支付功能 open_card:是否开通微信卡券功能 open_shake:是否开通微信摇一摇功能',
  `qrcode_url` varchar(255) DEFAULT NULL COMMENT '二维码图片的URL',
  `authorization_info` text COMMENT '授权信息',
  `authorizer_appid` varchar(50) DEFAULT NULL COMMENT '授权方appid',
  `is_miniprogram` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否为小程序授权',
  `miniprogram_info` text COMMENT '小程序信息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `nick_name` (`nick_name`) USING BTREE,
  KEY `user_name` (`user_name`) USING BTREE,
  KEY `is_miniprogram` (`is_miniprogram`) USING BTREE,
  KEY `add_time` (`add_time`) USING BTREE,
  KEY `authorizer_appid` (`authorizer_appid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
