-- MySQL Script generated by MySQL Workbench
-- 08/17/16 16:26:55
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema gofindme
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gofindme` ;

-- -----------------------------------------------------
-- Schema gofindme
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gofindme` DEFAULT CHARACTER SET utf8 ;
USE `gofindme` ;

-- -----------------------------------------------------
-- Table `gofindme`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`country` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`country` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`map` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`map` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `klm_file` VARCHAR(256) NULL,
  `sw_bounds` DECIMAL(9,6) NULL,
  `ne_bounds` DECIMAL(9,6) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`location` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`location` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country_id` INT UNSIGNED NOT NULL,
  `image_id` INT NULL,
  `map_id` INT UNSIGNED NULL,
  `trip_id` INT NULL,
  `lat` DECIMAL(9,6) NOT NULL,
  `lng` DECIMAL(8,6) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `map_id1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `country_id`),
  INDEX `fk_location_image1_idx` (`image_id` ASC),
  INDEX `fk_location_country1_idx` (`country_id` ASC),
  INDEX `fk_location_map1_idx` (`map_id1` ASC),
  CONSTRAINT `fk_location_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `gofindme`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `gofindme`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_map1`
    FOREIGN KEY (`map_id1`)
    REFERENCES `gofindme`.`map` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`location_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`location_image` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`location_image` (
  `location_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NOT NULL,
  `order` TINYINT(3) UNSIGNED NOT NULL,
  CONSTRAINT `fk_image_location_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `gofindme`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`trip_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`trip_image` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`trip_image` (
  `trip_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NOT NULL,
  `order` INT UNSIGNED NOT NULL,
  CONSTRAINT `fk_image_trip_trip1`
    FOREIGN KEY (`trip_id`)
    REFERENCES `gofindme`.`trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`image` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`image` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(256) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT(65000) NOT NULL,
  `date` DATE NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_image_image_location1`
    FOREIGN KEY (`id`)
    REFERENCES `gofindme`.`location_image` (`image_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_image_trip1`
    FOREIGN KEY (`id`)
    REFERENCES `gofindme`.`trip_image` (`image_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`trip`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`trip` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`trip` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `image_id` INT NULL,
  `map_id` INT UNSIGNED NULL,
  `name` VARCHAR(100) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `description` MEDIUMTEXT NULL,
  `map_id1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_trip_image1_idx` (`image_id` ASC),
  INDEX `fk_trip_map1_idx` (`map_id1` ASC),
  CONSTRAINT `fk_trip_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `gofindme`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_map1`
    FOREIGN KEY (`map_id1`)
    REFERENCES `gofindme`.`map` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`trip_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`trip_location` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`trip_location` (
  `trip_id` INT UNSIGNED NOT NULL,
  `location_id` INT UNSIGNED NOT NULL,
  INDEX `fk_trip_has_location_location1_idx` (`location_id` ASC),
  INDEX `fk_trip_has_location_trip_idx` (`trip_id` ASC),
  CONSTRAINT `fk_trip_has_location_trip`
    FOREIGN KEY (`trip_id`)
    REFERENCES `gofindme`.`trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_has_location_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `gofindme`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`author` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`author` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `image_id` INT UNSIGNED NULL,
  `email` VARCHAR(100) NULL,
  `bio` MEDIUMTEXT NULL,
  `age` SMALLINT(3) UNSIGNED NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`trip_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`trip_author` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`trip_author` (
  `trip_id` INT UNSIGNED NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`trip_id`, `author_id`),
  INDEX `fk_trip_has_author_author1_idx` (`author_id` ASC),
  INDEX `fk_trip_has_author_trip1_idx` (`trip_id` ASC),
  CONSTRAINT `fk_trip_has_author_trip1`
    FOREIGN KEY (`trip_id`)
    REFERENCES `gofindme`.`trip` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trip_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `gofindme`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`location_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`location_author` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`location_author` (
  `author_id` INT NOT NULL,
  `location_id` INT UNSIGNED NOT NULL,
  INDEX `fk_author_has_location_location1_idx` (`location_id` ASC),
  INDEX `fk_author_has_location_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_author_has_location_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `gofindme`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_author_has_location_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `gofindme`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`comment` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`comment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `comment` TEXT(65000) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NULL,
  `ip` INT UNSIGNED NULL,
  `parent` ENUM('trip', 'location', 'blog', 'image') NOT NULL,
  `parent_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`tag` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`tag` (
  `id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`tag_relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`tag_relation` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`tag_relation` (
  `id` INT UNSIGNED NOT NULL,
  `tag_id` INT UNSIGNED NOT NULL,
  `related_id` INT UNSIGNED NOT NULL,
  `type` ENUM('image', 'trip', 'location', 'blog') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tag_relation_tag1_idx` (`tag_id` ASC),
  CONSTRAINT `fk_tag_relation_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `gofindme`.`tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`blog` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`blog` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` INT UNSIGNED NOT NULL,
  `status` ENUM('published', 'draft') NULL,
  `title` VARCHAR(255) NOT NULL,
  `excerpt` TEXT(10000) NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`id`, `author_id`),
  INDEX `fk_blog_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_blog_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `gofindme`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gofindme`.`location_blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gofindme`.`location_blog` ;

CREATE TABLE IF NOT EXISTS `gofindme`.`location_blog` (
  `location_id` INT UNSIGNED NOT NULL,
  `blog_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`location_id`, `blog_id`),
  INDEX `fk_location_has_blog1_blog1_idx` (`blog_id` ASC),
  INDEX `fk_location_has_blog1_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_location_has_blog1_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `gofindme`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_location_has_blog1_blog1`
    FOREIGN KEY (`blog_id`)
    REFERENCES `gofindme`.`blog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
