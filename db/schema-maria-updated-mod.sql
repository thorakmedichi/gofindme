
-- gofindme.comment definition

CREATE TABLE `comment` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `comment` mediumtext NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip` int(10) UNSIGNED DEFAULT NULL,
  `parent` enum('trip','location','blog','image') NOT NULL,
  `parent_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.tag definition

CREATE TABLE `tag` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.tag_relation definition

CREATE TABLE `tag_relation` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `related_id` int(10) UNSIGNED NOT NULL,
  `type` enum('image','trip','location','blog') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.`map` definition

CREATE TABLE `map` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `klm_file` varchar(256) DEFAULT NULL,
  `sw_bounds` decimal(9,6) DEFAULT NULL,
  `ne_bounds` decimal(9,6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.country definition

CREATE TABLE `country` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `name` varchar(45) NOT NULL,
  `description` mediumtext NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.image definition
-- This will be used as part of the media library

CREATE TABLE `image` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `filename` varchar(256) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.author definition

CREATE TABLE `author` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `email` varchar(100) DEFAULT NULL,
  `bio` mediumtext DEFAULT NULL,
  `age` smallint(3) UNSIGNED DEFAULT NULL,
  CONSTRAINT `fk_author_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.blog definition
-- Can only have one Author
-- Can only belong to one location
-- Can only have one thumbnail image

CREATE TABLE `blog` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `author_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `status` enum('published','draft') DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  CONSTRAINT `fk_blog_author`
    FOREIGN KEY (`author_id`) REFERENCES `author` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_blog_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.trip definition
-- Can have many Authors (ie multiple people on the trip)
-- Can have multiple locations (ie multiple cities or places within a city)
-- Can only have one thumbnail image

CREATE TABLE `trip` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `map_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `description` mediumtext DEFAULT NULL,
  CONSTRAINT `fk_trip_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_trip_map`
    FOREIGN KEY (`map_id`) REFERENCES `map` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.location definition
-- Can belong to many trips (or none?)
-- Can have many blogs
-- Can only have one country
-- Can only have one map (ie boundaries and center)
-- Can only have one thumbnail image

CREATE TABLE `location` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `country_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `map_id` int(10) UNSIGNED DEFAULT NULL,
  `trip_id` int(10) UNSIGNED DEFAULT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(8,6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  CONSTRAINT `fk_location_country`
    FOREIGN KEY (`country_id`) REFERENCES `country` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_map`
    FOREIGN KEY (`map_id`) REFERENCES `map` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_trip`
    FOREIGN KEY (`trip_id`) REFERENCES `trip` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.location_author definition

CREATE TABLE `location_author` (
  `location_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  CONSTRAINT `fk_location_author_location`
    FOREIGN KEY (`location_id`) REFERENCES `location` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_author_author`
    FOREIGN KEY (`author_id`) REFERENCES `author` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.location_blog definition

CREATE TABLE `location_blog` (
  `location_id` int(10) UNSIGNED NOT NULL,
  `blog_id` int(10) UNSIGNED NOT NULL,
  CONSTRAINT `fk_location_blog_location`
    FOREIGN KEY (`location_id`) REFERENCES `location` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_blog_blog`
    FOREIGN KEY (`blog_id`) REFERENCES `blog` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.location_image definition

CREATE TABLE `location_image` (
  `location_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED NOT NULL,
  `order` tinyint(3) UNSIGNED NOT NULL,
  CONSTRAINT `fk_location_image_location`
    FOREIGN KEY (`location_id`) REFERENCES `location` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_image_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.trip_author definition

CREATE TABLE `trip_author` (
  `trip_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `unique_trip_author` (`trip_id`,`author_id`),
  CONSTRAINT `fk_trip_author_trip`
    FOREIGN KEY (`trip_id`) REFERENCES `trip` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_trip_author_author`
    FOREIGN KEY (`author_id`) REFERENCES `author` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.trip_image definition

CREATE TABLE `trip_image` (
  `trip_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `unique_trip_image` (`trip_id`,`image_id`),
  CONSTRAINT `fk_trip_image_trip`
    FOREIGN KEY (`trip_id`) REFERENCES `trip` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_trip_image_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.trip_location definition

CREATE TABLE `trip_location` (
  `trip_id` int(10) UNSIGNED NOT NULL,
  `location_id` int(10) UNSIGNED NOT NULL,
  CONSTRAINT `fk_trip_location_trip`
    FOREIGN KEY (`trip_id`) REFERENCES `trip` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_trip_location_location`
    FOREIGN KEY (`location_id`) REFERENCES `location` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
