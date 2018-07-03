/*
SQLyog Enterprise - MySQL GUI v8.14 
MySQL - 5.1.30-community : Database - nearby_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`nearby_db` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `nearby_db`;

/*Table structure for table `category_master` */

DROP TABLE IF EXISTS `category_master`;

CREATE TABLE `category_master` (
  `categoryId` int(11) NOT NULL AUTO_INCREMENT,
  `categoryType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `category_master` */

insert  into `category_master`(`categoryId`,`categoryType`) values (1,'Food'),(2,'Electronics'),(3,'Footwear'),(4,'Fashion'),(5,'Stationary '),(6,'Doctor');

/*Table structure for table `employee_registration_master` */

DROP TABLE IF EXISTS `employee_registration_master`;

CREATE TABLE `employee_registration_master` (
  `employeeId` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  `fatherName` varchar(50) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `mobileNumber` varchar(20) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `contactAddress` varchar(500) DEFAULT NULL,
  `permanentAddress` varchar(500) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `maritalStatus` varchar(20) DEFAULT NULL,
  `numberOfChild` int(5) DEFAULT NULL,
  `age` double DEFAULT NULL,
  `salaryExpectation` varchar(50) DEFAULT NULL,
  `jobNeeded` varchar(500) DEFAULT NULL,
  `educationDetails` varchar(500) DEFAULT NULL,
  `identityProof` varchar(100) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `updated_date` timestamp NULL DEFAULT NULL,
  `isDeleted` int(2) DEFAULT NULL,
  `isActive` int(2) DEFAULT NULL,
  PRIMARY KEY (`employeeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `employee_registration_master` */

insert  into `employee_registration_master`(`employeeId`,`firstName`,`lastName`,`fatherName`,`gender`,`mobileNumber`,`email`,`contactAddress`,`permanentAddress`,`dob`,`maritalStatus`,`numberOfChild`,`age`,`salaryExpectation`,`jobNeeded`,`educationDetails`,`identityProof`,`created_date`,`updated_date`,`isDeleted`,`isActive`) values (1,'Aman','choukse','Anil Choukse','male','9755552578','aman.choukse@gmail.com','78 Sanskrati Nagar ','78 Sanskrati Nagar ','2018-05-02','UnMarried',0,0,'30000.0','Java Developer','Graduation',NULL,'2018-05-19 15:37:15','2018-05-19 15:37:15',0,0),(2,'Navin','jain','Mahavir Jain','male','9713950147','jainnavin614@gmail.com','265 anoop nagar','265 anoop nagar','1990-08-06','Married',1,0,'30000.0','IT ','Graduation',NULL,'2018-05-19 17:48:57','2018-05-19 17:48:57',0,0);

/*Table structure for table `employer_registration_master` */

DROP TABLE IF EXISTS `employer_registration_master`;

CREATE TABLE `employer_registration_master` (
  `employerId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `mobileNumber` varchar(12) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `state` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `createdDate` timestamp NULL DEFAULT NULL,
  `isactive` int(2) DEFAULT NULL,
  `isdeleted` int(2) DEFAULT NULL,
  `updatedDate` timestamp NULL DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`employerId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `employer_registration_master` */

insert  into `employer_registration_master`(`employerId`,`name`,`mobileNumber`,`email`,`address`,`state`,`city`,`type`,`dob`,`createdDate`,`isactive`,`isdeleted`,`updatedDate`,`password`) values (1,'Aman ','9755552578','aman.choukse@gmail.com','78 Sanskrati Nagar ','MadhyaPradesh','Indore','Employer','1993-05-02','2018-05-18 15:30:41',0,0,'2018-05-18 15:30:41','123');

/*Table structure for table `job_category` */

DROP TABLE IF EXISTS `job_category`;

CREATE TABLE `job_category` (
  `jobCategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`jobCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `job_category` */

insert  into `job_category`(`jobCategoryId`,`job`) values (1,'House Hold Service');

/*Table structure for table `job_master` */

DROP TABLE IF EXISTS `job_master`;

CREATE TABLE `job_master` (
  `jobId` int(11) NOT NULL AUTO_INCREMENT,
  `employerId` int(11) DEFAULT NULL,
  `job_title` varchar(250) DEFAULT NULL,
  `age` varchar(200) DEFAULT NULL,
  `gender` varchar(11) DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `type` varchar(200) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) DEFAULT NULL,
  `isdeleted` int(2) DEFAULT NULL,
  `isActive` int(2) DEFAULT NULL,
  `jobDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`jobId`),
  KEY `FK_job_master` (`employerId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `job_master` */

insert  into `job_master`(`jobId`,`employerId`,`job_title`,`age`,`gender`,`salary`,`address`,`type`,`created_date`,`updated_date`,`created_by`,`isdeleted`,`isActive`,`jobDescription`) values (1,1,'Java Trainer','25-30','male',25000,'Indore','monthly','2018-05-18 15:32:44','2018-05-18 15:32:44',1,0,0,'I want a trainer who have depth knowledge of java ');

/*Table structure for table `job_subcategory` */

DROP TABLE IF EXISTS `job_subcategory`;

CREATE TABLE `job_subcategory` (
  `jobSubCategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `jobCategoryId` int(20) DEFAULT NULL,
  `subCategory` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`jobSubCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `job_subcategory` */

insert  into `job_subcategory`(`jobSubCategoryId`,`jobCategoryId`,`subCategory`) values (1,1,'Gardening'),(2,1,'Maid');

/*Table structure for table `registration_master` */

DROP TABLE IF EXISTS `registration_master`;

CREATE TABLE `registration_master` (
  `spId` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(30) DEFAULT NULL,
  `lastName` varchar(30) DEFAULT NULL,
  `mobileNumber` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `isdeleted` int(1) DEFAULT NULL,
  `isactive` int(1) DEFAULT NULL,
  `createdDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `subcategoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`spId`),
  KEY `FK_registration_master` (`subcategoryId`),
  CONSTRAINT `FK_registration_master` FOREIGN KEY (`serviceId`) REFERENCES `service_category` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `registration_master` */

insert  into `registration_master`(`spId`,`firstName`,`lastName`,`mobileNumber`,`email`,`address`,`isdeleted`,`isactive`,`createdDate`,`updatedDate`,`subcategoryId`) values (1,'Aman','Choukse','9755552578','aman.choukse@gmail.com','78 Sanskrati nagar',0,0,'2018-05-07 13:17:24','2018-05-07 13:17:24',3),(2,'Ashish','Birle','9826895389','birleashish@gmail.com','28 A krishi Vihar Tilak Nagar',0,0,'2018-05-07 13:17:53','2018-05-07 13:17:53',6),(3,'navin','jain','8814757845','amancdjsk@gmail.com','265 Anoop Nagar',0,0,'2018-05-07 13:18:21','2018-05-07 13:18:21',4),(4,'Mahesh','muramkar','1481515','aman.choukse@gmail.com','129 Pardeshipura ',0,0,'2018-05-07 13:23:58','2018-05-07 13:23:58',4),(5,'Dr Sangita ','Thankur','9713950148','drsangita@gmail.com','253 Anoop Nagar',0,0,'2018-05-07 18:36:47','2018-05-07 18:36:47',7),(6,'Dr rani','manchanda','8881234567','drrani@gmail.com','240 Anoop Nagar',0,0,'2018-05-07 18:38:17','2018-05-07 18:38:17',7),(7,'Dr.Pawan ','Thankur','66874512365','drpawan@gmail.com','150 Tilak nagar',0,0,'2018-05-07 18:53:34','2018-05-07 18:53:34',7);

/*Table structure for table `service_category` */

DROP TABLE IF EXISTS `service_category`;

CREATE TABLE `service_category` (
  `subcategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `categoryId` int(11) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subcategoryId`),
  KEY `FK_service_category` (`categoryId`),
  CONSTRAINT `FK_service_category` FOREIGN KEY (`categoryId`) REFERENCES `category_master` (`sno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `service_category` */

insert  into `service_category`(`subcategoryId`,`categoryId`,`service`,`type`) values (1,1,'vegetable','static'),(2,1,'vegetable','mobile'),(3,2,'Mobile Phones','static'),(4,3,'Bata','static'),(5,3,'Woodland','static'),(6,5,'Book Shop','static'),(7,6,'Dentist','static');

/*Table structure for table `sp_master` */

DROP TABLE IF EXISTS `sp_master`;

CREATE TABLE `sp_master` (
  `sno` int(6) NOT NULL AUTO_INCREMENT,
  `spId` int(6) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`sno`),
  KEY `FK_sp_master` (`spId`),
  CONSTRAINT `FK_sp_master` FOREIGN KEY (`userId`) REFERENCES `registration_master` (`sno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `sp_master` */

insert  into `sp_master`(`sno`,`spId`,`latitude`,`longitude`) values (1,1,22.7628003,75.8824259),(2,2,22.7156564,75.8966003),(3,3,22.7326607,75.8907418),(4,4,22.7453955,75.8717054),(5,5,22.7318948,75.890792),(6,6,22.7318948,75.890792),(7,7,22.714865,75.899353);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
