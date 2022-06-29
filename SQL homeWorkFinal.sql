-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema realestate
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema realestate
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `realestate` DEFAULT CHARACTER SET utf8mb4 ;
USE `realestate` ;

-- -----------------------------------------------------
-- Table `realestate`.`realtors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `realestate`.`realtors` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `realtor_name` VARCHAR(30) NULL DEFAULT NULL,
  `seniority` INT(11) NULL DEFAULT NULL,
  `phone_number` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `realestate`.`houses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `realestate`.`houses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `rooms` INT(11) NULL DEFAULT NULL,
  `balconies` INT(11) NULL DEFAULT NULL,
  `age` INT(11) NULL DEFAULT NULL,
  `price` INT(11) NULL DEFAULT NULL,
  `realtor_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `realtor_id` (`realtor_id` ASC) VISIBLE,
  CONSTRAINT `realtor_id`
    FOREIGN KEY (`realtor_id`)
    REFERENCES `realestate`.`realtors` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4;

USE `realestate` ;

-- -----------------------------------------------------
-- procedure expensive
-- -----------------------------------------------------

DELIMITER $$
USE `realestate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `expensive`(p1 INT,realtor_id int)
BEGIN
DECLARE price1,price2,price3 int default 0;
set price1 = 100;
set price2 = 200;
set price3 = 300;
select  * from houses;
  label1: LOOP
    SET p1 = p1 + 1;
    set realtor_id = realtor_id + 1;
    IF p1 <= 3 and realtor_id <= 3 THEN
    select distinct realtor_id,price from houses where realtor_id and price = greatest(price1,price2,price3);
    set price1 = price1 + 300;
    set price2 = price2 + 300;
    set price3 = price3 + 300;
      ITERATE label1;
    END IF;
    SELECT realtors.id,price FROM realtors INNER JOIN houses ON realtors.id = houses.realtor_id;
    LEAVE label1;
  END LOOP label1;
  SET @x = p1;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
