-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_bazar_joyeria_el_roble
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_bazar_joyeria_el_roble
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_bazar_joyeria_el_roble` DEFAULT CHARACTER SET utf8 ;
USE `db_bazar_joyeria_el_roble` ;

-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_user` (
  `id` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `phone` INT NOT NULL,
  `address` VARCHAR(100) NULL,
  `rol` VARCHAR(50) NOT NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(100) NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_discount` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(100) NULL,
  `discount_percent` DECIMAL NOT NULL,
  `active` TINYINT NOT NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(100) NULL,
  `SKU` VARCHAR(50) NOT NULL,
  `category_id` INT NULL,
  `price` DECIMAL NOT NULL,
  `discount_id` INT NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_product_tb_category_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_tb_product_tb_discount1_idx` (`discount_id` ASC) VISIBLE,
  UNIQUE INDEX `SKU_UNIQUE` (`SKU` ASC) VISIBLE,
  CONSTRAINT `fk_tb_product_tb_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `db_bazar_joyeria_el_roble`.`tb_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_product_tb_discount1`
    FOREIGN KEY (`discount_id`)
    REFERENCES `db_bazar_joyeria_el_roble`.`tb_discount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_product_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_product_inventory` (
  `id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tb_product_inventory_tb_product1`
    FOREIGN KEY (`id`)
    REFERENCES `db_bazar_joyeria_el_roble`.`tb_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_order_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_order_details_tb_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_tb_order_details_tb_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `db_bazar_joyeria_el_roble`.`tb_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_bazar_joyeria_el_roble`.`tb_order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_bazar_joyeria_el_roble`.`tb_order_item` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `created_at` DATETIME NULL,
  `modified_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  INDEX `fk_tb_order_items_tb_order_details1_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_tb_order_items_tb_product1_idx` (`product_id` ASC) VISIBLE,
  PRIMARY KEY (`order_id`, `product_id`),
  CONSTRAINT `fk_tb_order_items_tb_order_details1`
    FOREIGN KEY (`order_id`)
    REFERENCES `db_bazar_joyeria_el_roble`.`tb_order_details` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_order_items_tb_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `db_bazar_joyeria_el_roble`.`tb_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
