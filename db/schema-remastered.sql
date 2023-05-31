
-- gofindme.comment definition

CREATE TABLE `comment` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `comment` mediumtext NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ip` int(10) UNSIGNED DEFAULT NULL,
  `parent` enum('trip','location','post','image') NOT NULL,
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
  `type_id` int(10) UNSIGNED NOT NULL,
  `type` enum('image','trip','location','post') NOT NULL,
  CONSTRAINT `fk_tag_relation_tag`
    FOREIGN KEY (`tag_id`) REFERENCES `tag` (id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
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
  `description` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.author definition

CREATE TABLE `author` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` int(10) UNSIGNED NOT NULL,
  `avatar` varchar(256) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `bio` mediumtext DEFAULT NULL,
  `age` smallint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.image definition
-- This will be used as part of the media library

CREATE TABLE `image` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `author_id` int(10) UNSIGNED DEFAULT NULL, -- used to 'copywrite' the image to a specific user
  `filename` varchar(256) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` mediumtext NOT NULL,
  `date` date DEFAULT NULL,
  CONSTRAINT `fk_image_author`
    FOREIGN KEY (`author_id`) REFERENCES `author` (id)
    ON DELETE SET NULL
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- gofindme.post definition
-- Can only have one Author
-- Can only belong to one location
-- Can only have one thumbnail image

CREATE TABLE `post` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `author_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `type_id` int(10) UNSIGNED NOT NULL, -- ie trip_id or location_id
  `type` enum('trip','location') NOT NULL,
  `status` enum('published','draft') DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  CONSTRAINT `fk_post_author`
    FOREIGN KEY (`author_id`) REFERENCES `author` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_post_image`
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
-- Can have many posts
-- Can only have one country
-- Can only have one map (ie boundaries and center)
-- Can only have one thumbnail image
-- Can have many images

CREATE TABLE `location` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `country_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED DEFAULT NULL, -- used for thumbnail
  `map_id` int(10) UNSIGNED DEFAULT NULL,
  `lat` decimal(9,6) NOT NULL,
  `lng` decimal(8,6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  UNIQUE KEY `unique_location` (`lat`,`lng`),
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
    ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- gofindme.location_image definition

CREATE TABLE `location_image` (
  `location_id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL, -- this ensures Author A wont see Author B images if not null
  `order` tinyint(3) UNSIGNED NOT NULL UNIQUE,
  UNIQUE KEY `unique_location_image` (`location_id`,`image_id`),
  CONSTRAINT `fk_location_image_location`
    FOREIGN KEY (`location_id`) REFERENCES `location` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_location_image_image`
    FOREIGN KEY (`image_id`) REFERENCES `image` (id)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
    CONSTRAINT `fk_location_image_author`
    FOREIGN KEY (`author_id`) REFERENCES `author` (id)
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
