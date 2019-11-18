-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbname
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbname
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbname` DEFAULT CHARACTER SET utf8 ;
USE `dbname` ;

-- -----------------------------------------------------
-- Table `dbname`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbname`.`category` (
  `id` INT NOT NULL,
  `a` VARCHAR(45) NOT NULL,
  `c` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbname`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbname`.`item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `a` VARCHAR(45) NOT NULL,
  `b` VARCHAR(45) NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `item_category_fk_idx` (`category_id` ASC),
  CONSTRAINT `item_category_fk`
    FOREIGN KEY (`category_id`)
    REFERENCES `dbname`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
