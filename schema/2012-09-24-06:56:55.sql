/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(40) NOT NULL,
  `text` varchar(10000) NOT NULL,
  `writer_id` int(10) unsigned NOT NULL,
  `datetime_create` datetime NOT NULL,
  `datetime_modify` datetime DEFAULT NULL,
  `datetime_delete` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(8) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teatime` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(40) NOT NULL,
  `text` varchar(10000) NOT NULL,
  `text_striped` varchar(10000) DEFAULT NULL,
  `writer_id` int(10) unsigned NOT NULL,
  `datetime_create` datetime NOT NULL,
  `datetime_modify` datetime DEFAULT NULL,
  `datetime_delete` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teatime_cmt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `text` varchar(1000) NOT NULL,
  `datetime_create` datetime NOT NULL,
  `datetime_delete` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`,`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teatime_w` (
  `post_id` int(10) unsigned NOT NULL,
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` char(32) NOT NULL,
  `data` varchar(1024) DEFAULT NULL,
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `techlog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(40) NOT NULL,
  `text` varchar(10000) NOT NULL,
  `writer_id` int(10) unsigned NOT NULL,
  `datetime_create` datetime NOT NULL,
  `datetime_modify` datetime DEFAULT NULL,
  `datetime_delete` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` char(16) NOT NULL,
  `realname` char(32) CHARACTER SET utf8 DEFAULT NULL,
  `password` char(140) NOT NULL,
  `datetime_create` datetime NOT NULL,
  `datetime_access` datetime DEFAULT NULL,
  `datetime_delete` datetime DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `bio` tinytext CHARACTER SET utf8 NOT NULL,
  `email` char(255) NOT NULL,
  `link` char(80) DEFAULT NULL,
  `image_default` varchar(64) DEFAULT NULL,
  `image_thumb` varchar(64) DEFAULT NULL,
  `image_full` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  KEY `user_id` (`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workshop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(40) NOT NULL,
  `text` varchar(10000) NOT NULL,
  `writer_id` int(10) unsigned NOT NULL,
  `datetime_create` datetime NOT NULL,
  `datetime_modify` datetime DEFAULT NULL,
  `datetime_delete` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
