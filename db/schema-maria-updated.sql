-- gofindme.author definition

CREATE TABLE `author` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `image_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `bio` mediumtext DEFAULT NULL,
  `age` smallint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.blog definition

CREATE TABLE `blog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(10) unsigned NOT NULL,
  `status` enum('published','draft') DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  PRIMARY KEY (`id`,`author_id`),
  KEY `fk_blog_author1_idx` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.comment definition

CREATE TABLE `comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `comment` mediumtext NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip` int(10) unsigned DEFAULT NULL,
  `parent` enum('trip','location','blog','image') NOT NULL,
  `parent_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.country definition

CREATE TABLE `country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.image definition

CREATE TABLE `image` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(256) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.location definition

CREATE TABLE `location` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned NOT NULL,
  `image_id` int(10) DEFAULT NULL,
  `map_id` int(10) unsigned DEFAULT NULL,
  `trip_id` int(10) DEFAULT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(8,6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `map_id1` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.location_author definition

CREATE TABLE `location_author` (
  `author_id` int(10) NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  KEY `fk_author_has_location_location1_idx` (`location_id`),
  KEY `fk_author_has_location_author1_idx` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.location_blog definition

CREATE TABLE `location_blog` (
  `location_id` int(10) unsigned NOT NULL,
  `blog_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`location_id`,`blog_id`),
  KEY `fk_location_has_blog1_blog1_idx` (`blog_id`),
  KEY `fk_location_has_blog1_location1_idx` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.location_image definition

CREATE TABLE `location_image` (
  `location_id` int(10) unsigned NOT NULL,
  `image_id` int(10) unsigned NOT NULL,
  `order` tinyint(3) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.`map` definition

CREATE TABLE `map` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `klm_file` varchar(256) DEFAULT NULL,
  `sw_bounds` decimal(9,6) DEFAULT NULL,
  `ne_bounds` decimal(9,6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.tag definition

CREATE TABLE `tag` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.tag_relation definition

CREATE TABLE `tag_relation` (
  `id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `related_id` int(10) unsigned NOT NULL,
  `type` enum('image','trip','location','blog') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tag_relation_tag1_idx` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.trip definition

CREATE TABLE `trip` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `image_id` int(10) DEFAULT NULL,
  `map_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `map_id1` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_trip_image1_idx` (`image_id`),
  KEY `fk_trip_map1_idx` (`map_id1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.trip_author definition

CREATE TABLE `trip_author` (
  `trip_id` int(10) unsigned NOT NULL,
  `author_id` int(10) NOT NULL,
  PRIMARY KEY (`trip_id`,`author_id`),
  KEY `fk_trip_has_author_author1_idx` (`author_id`),
  KEY `fk_trip_has_author_trip1_idx` (`trip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.trip_image definition

CREATE TABLE `trip_image` (
  `trip_id` int(10) unsigned NOT NULL,
  `image_id` int(10) unsigned NOT NULL,
  `order` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- gofindme.trip_location definition

CREATE TABLE `trip_location` (
  `trip_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  KEY `fk_trip_has_location_location1_idx` (`location_id`),
  KEY `fk_trip_has_location_trip_idx` (`trip_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
