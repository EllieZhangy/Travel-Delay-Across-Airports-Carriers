-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`carrier_group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrier_group` (
  `code` ENUM('0', '1', '2', '3', '7') NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carrier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrier` (
  `carrier_id` SMALLINT(6) NOT NULL,
  `carrier_code` VARCHAR(6) NULL,
  `carrier_name` LONGTEXT NOT NULL,
  `carrier_group_code` ENUM('0', '1', '2', '3', '7') NOT NULL,
  INDEX `fk_carrier_carrier_group1_idx` (`carrier_group_code` ASC) VISIBLE,
  PRIMARY KEY (`carrier_id`),
  CONSTRAINT `fk_carrier_carrier_group1`
    FOREIGN KEY (`carrier_group_code`)
    REFERENCES `mydb`.`carrier_group` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airport_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airport_type` (
  `code` ENUM('D', 'I') NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`airport` (
  `airport_id` SMALLINT(6) NOT NULL,
  `airport_code` VARCHAR(6) NULL,
  `airport_name` LONGTEXT NOT NULL,
  `airport_type_code` ENUM('D', 'I') NOT NULL,
  `city_name` VARCHAR(45) NULL,
  `dep_performed` INT NULL,
  `freight` FLOAT NULL,
  `mail` FLOAT NULL,
  INDEX `fk_airport_airport_type1_idx` (`airport_type_code` ASC) VISIBLE,
  PRIMARY KEY (`airport_id`),
  CONSTRAINT `fk_airport_airport_type1`
    FOREIGN KEY (`airport_type_code`)
    REFERENCES `mydb`.`airport_type` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`delay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`delay` (
  `id` SMALLINT(6) NOT NULL,
  `year` VARCHAR(45) NULL,
  `month` VARCHAR(45) NULL,
  `carrier_id` SMALLINT(6) NOT NULL,
  `airport_id` SMALLINT(6) NOT NULL,
  `arr_flight` INT NULL,
  `carrier_ct` INT NULL,
  `weather_ct` INT NULL,
  `nas_ct` INT NULL,
  `arr_delay` FLOAT NULL,
  `arr_del15` FLOAT NULL,
  `carrier_delay` FLOAT NULL,
  `weather_delay` FLOAT NULL,
  `nas_delay` FLOAT NULL,
  `security_delay` FLOAT NULL,
  `lateaircraftdelay` FLOAT NULL,
  `security_ct` INT NULL,
  `lateaircraftct` INT NULL,
  `arr_cancelled` INT NULL,
  `arr_diverted` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_delay_carrier_idx` (`carrier_id` ASC) VISIBLE,
  INDEX `fk_delay_airport1_idx` (`airport_id` ASC) VISIBLE,
  CONSTRAINT `fk_delay_carrier`
    FOREIGN KEY (`carrier_id`)
    REFERENCES `mydb`.`carrier` (`carrier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delay_airport1`
    FOREIGN KEY (`airport_id`)
    REFERENCES `mydb`.`airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carrier_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrier_region` (
  `code` ENUM('A', 'D', 'I', 'L', 'P', 'S') NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`service_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`service_class` (
  `code` ENUM('A', 'C', 'E', 'F', 'G', 'H', 'K', 'L', 'N', 'P', 'Q', 'R', 'V', 'Z') NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carrier_financial_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrier_financial_report` (
  `financial_report_id` SMALLINT(6) NOT NULL,
  `carrier_id` SMALLINT(6) NOT NULL,
  `quarter` SMALLINT(6) NULL,
  `year` FLOAT NULL,
  `cash` FLOAT NULL,
  `accept_pay_other` FLOAT NULL,
  `liab_air_traffic` FLOAT NULL,
  `liab_sh_hld_equity` FLOAT NULL,
  PRIMARY KEY (`financial_report_id`),
  INDEX `fk_carrier_financial_report_carrier1_idx` (`carrier_id` ASC) VISIBLE,
  CONSTRAINT `fk_carrier_financial_report_carrier1`
    FOREIGN KEY (`carrier_id`)
    REFERENCES `mydb`.`carrier` (`carrier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carrier_has_service_class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrier_has_service_class` (
  `carrier_id` SMALLINT(6) NOT NULL,
  `service_code` ENUM('A', 'C', 'E', 'F', 'G', 'H', 'K', 'L', 'N', 'P', 'Q', 'R', 'V', 'Z') NOT NULL,
  PRIMARY KEY (`carrier_id`, `service_code`),
  INDEX `fk_carrier_has_service_class_service_class1_idx` (`service_code` ASC) VISIBLE,
  INDEX `fk_carrier_has_service_class_carrier1_idx` (`carrier_id` ASC) VISIBLE,
  CONSTRAINT `fk_carrier_has_service_class_carrier1`
    FOREIGN KEY (`carrier_id`)
    REFERENCES `mydb`.`carrier` (`carrier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrier_has_service_class_service_class1`
    FOREIGN KEY (`service_code`)
    REFERENCES `mydb`.`service_class` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carrier_has_region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrier_has_region` (
  `carrier_id` SMALLINT(6) NOT NULL,
  `carrier_region_code` ENUM('A', 'D', 'I', 'L', 'P', 'S') NOT NULL,
  PRIMARY KEY (`carrier_id`, `carrier_region_code`),
  INDEX `fk_carrier_has_carrier_region_carrier_region1_idx` (`carrier_region_code` ASC) VISIBLE,
  INDEX `fk_carrier_has_carrier_region_carrier1_idx` (`carrier_id` ASC) VISIBLE,
  CONSTRAINT `fk_carrier_has_carrier_region_carrier1`
    FOREIGN KEY (`carrier_id`)
    REFERENCES `mydb`.`carrier` (`carrier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrier_has_carrier_region_carrier_region1`
    FOREIGN KEY (`carrier_region_code`)
    REFERENCES `mydb`.`carrier_region` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
