SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

grant all privileges on gevent.* to gevent@localhost identified by 'atamishi';


CREATE SCHEMA IF NOT EXISTS `gevent`;
USE `gevent` ;

-- -----------------------------------------------------
-- Table `mydb`.`Tweet`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gevent`.`Markers` (
  `Id` INT NOT NULL ,
  `Name` TEXT NOT NULL ,
  `Address` TEXT NULL ,
  `Detail` TEXT NULL ,
  lat FLOAT NOT NULL,
  lng FLOAT NOT NULL,
  type INT NOT NULL,
  `create_at` DATETIME NOT NULL ,
  INDEX `Index1` (`Id` ASC) ,
  INDEX `Index2` (`type` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
PARTITION BY RANGE( TO_DAYS(create_at) ) (
    PARTITION p201212 VALUES LESS THAN ( TO_DAYS('2012-12-01') ),
    PARTITION p201303 VALUES LESS THAN ( TO_DAYS('2013-03-01') ),
    PARTITION p201306 VALUES LESS THAN ( TO_DAYS('2013-06-01') ),
    PARTITION p201309 VALUES LESS THAN ( TO_DAYS('2013-09-01') ),
    PARTITION p201312 VALUES LESS THAN ( TO_DAYS('2013-12-01') ),
    PARTITION p201403 VALUES LESS THAN ( TO_DAYS('2014-03-01') ),
    PARTITION p201406 VALUES LESS THAN ( TO_DAYS('2014-06-01') ),
    PARTITION p201409 VALUES LESS THAN ( TO_DAYS('2014-09-01') ),
    PARTITION p201412 VALUES LESS THAN ( TO_DAYS('2014-12-01') ),
    PARTITION p201503 VALUES LESS THAN ( TO_DAYS('2015-03-01') ),
    PARTITION p201506 VALUES LESS THAN ( TO_DAYS('2015-06-01') ),
    PARTITION p201509 VALUES LESS THAN ( TO_DAYS('2015-09-01') ),
    PARTITION p201512 VALUES LESS THAN ( TO_DAYS('2015-12-01') ),
    PARTITION p201603 VALUES LESS THAN ( TO_DAYS('2016-03-01') ),
    PARTITION p201606 VALUES LESS THAN ( TO_DAYS('2016-06-01') ),
    PARTITION p201609 VALUES LESS THAN ( TO_DAYS('2016-09-01') ),
    PARTITION p201612 VALUES LESS THAN ( TO_DAYS('2016-12-01') ),
    PARTITION p201703 VALUES LESS THAN ( TO_DAYS('2017-03-01') ),
    PARTITION p201706 VALUES LESS THAN ( TO_DAYS('2017-06-01') ),
    PARTITION p201709 VALUES LESS THAN ( TO_DAYS('2017-09-01') ),
    PARTITION p201712 VALUES LESS THAN ( TO_DAYS('2017-12-01') ),
    PARTITION p201803 VALUES LESS THAN ( TO_DAYS('2018-03-01') ),
    PARTITION p201806 VALUES LESS THAN ( TO_DAYS('2018-06-01') ),
    PARTITION p201809 VALUES LESS THAN ( TO_DAYS('2018-09-01') ),
    PARTITION p201812 VALUES LESS THAN ( TO_DAYS('2018-12-01') ),
    PARTITION pmax VALUES LESS THAN MAXVALUE
)
;

----追加するときは・・・
ALTER TABLE logs REORGANIZE PARTITION pmax INTO (
    PARTITION p201903 VALUES LESS THAN ( TO_DAYS('2019-03-01') ),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);


INSERT INTO `gevent`.`markers` (`Address`, `create_at`, `Detail`, `Id`, `lat`, `lng`, `Name`, `type`) VALUES ( '熱海市', current_timestamp, 'パン', 1, 11, 22,'布袋や', 1);
INSERT INTO `gevent`.`markers` (`Address`, `create_at`, `Detail`, `Id`, `lat`, `lng`, `Name` , `type`) VALUES ( '熱海市', current_timestamp, 'その他', 2, 11.5, 22.11,'ヤオハン',1);
INSERT INTO `gevent`.`markers` (`Address`, `create_at`, `Detail`, `Id`, `lat`, `lng`, `Name` , `type`) VALUES ( 'test', current_timestamp, 'その他', 3, 47.6145, -122.3418,'yaohan',1);
INSERT INTO `gevent`.`markers` (`Address`, `create_at`, `Detail`, `Id`, `lat`, `lng`, `Name` , `type`) VALUES ( 'test', current_timestamp, 'その他', 4, 40, -00,'yaohan',1);
INSERT INTO `gevent`.`markers` (`Address`, `create_at`, `Detail`, `Id`, `lat`, `lng`, `Name`, `type`) VALUES ( '熱海市', current_timestamp, 'パン', 5, 35, 139,'布袋や', 1);
INSERT INTO `gevent`.`markers` (`Address`, `create_at`, `Detail`, `Id`, `lat`, `lng`, `Name`, `type`) VALUES ( 'test', current_timestamp, 'パン', 6, 35.2, 139.5,'test', 1);
