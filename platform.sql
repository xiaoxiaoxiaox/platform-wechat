#已授权的信息
CREATE TABLE `wx_auth_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `authorizer_appid` varchar(50) NOT NULL DEFAULT '' COMMENT '授权小程序的 appid',
  `authorizer_access_token` varchar(255) NOT NULL DEFAULT '' COMMENT '授权小程序的 access_token',
  `authorizer_refresh_token` varchar(255) NOT NULL DEFAULT '' COMMENT '授权小程序的 refresh_token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'access_token 的生命周期（秒）',
  `func_info` text COMMENT '权限集合',
  `is_auth` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否授权',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `authorizer_appid` (`authorizer_appid`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

