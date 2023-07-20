CREATE DATABASE  IF NOT EXISTS `parking_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `parking_management`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: parking_management
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `emailId` varchar(30) NOT NULL UNIQUE,
  `phoneNo` varchar(20) NOT NULL UNIQUE,
  `address` varchar(150) NOT NULL,
  PRIMARY KEY (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Dhruv','Patel','dhruv0128@gmail.com','8579996699','7 Peninsula Place, Boston'),(9,'yug','rajani','yugrajani@gmail','6177364','yug'),(10,'Shubham','Mendapara','shubham@gmail.com','612362382','Longwood'),(11,'Test','Test','test@gmail.com','6176517442','99 Random Street'),(12,'Test','Test','test1@gmail.com','6176517441','42 Test Street'),(13,'Hey','There','hey@gmail.com','7839411551','731 There'),(14,'Tirtha','Patel','tirtha@gmail.com','8388959813','98 Longwood'),(15,'Deep','Prajapati','deep@gmail.com','9898987656','Longwood Ave'),(16,'Demo','Test','demo@gmail.com','1234567890','Demo St'),(17,'Yug','Rajani','yug@gmail.com','6176517443','42 Longwood Avenue');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_parkingspace_reservation`
--

DROP TABLE IF EXISTS `customer_parkingspace_reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_parkingspace_reservation` (
  `reservationId` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `spaceId` int DEFAULT NULL,
  KEY `reservationId` (`reservationId`),
  KEY `customerId` (`customerId`),
  KEY `spaceId` (`spaceId`),
  CONSTRAINT `customer_parkingspace_reservation_ibfk_1` FOREIGN KEY (`reservationId`) REFERENCES `reservation` (`reservationId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customer_parkingspace_reservation_ibfk_2` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customer_parkingspace_reservation_ibfk_3` FOREIGN KEY (`spaceId`) REFERENCES `parkingspace` (`spaceId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_parkingspace_reservation`
--

LOCK TABLES `customer_parkingspace_reservation` WRITE;
/*!40000 ALTER TABLE `customer_parkingspace_reservation` DISABLE KEYS */;
INSERT INTO `customer_parkingspace_reservation` VALUES (1,1,1);
/*!40000 ALTER TABLE `customer_parkingspace_reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fine`
--

DROP TABLE IF EXISTS `fine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fine` (
  `fineId` int NOT NULL AUTO_INCREMENT,
  `fineAmount` int NOT NULL,
  `fineReason` varchar(300) NOT NULL,
  `lotId` int NOT NULL,
  PRIMARY KEY (`fineId`),
  KEY `fine_lot_FK_idx` (`lotId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fine`
--

LOCK TABLES `fine` WRITE;
/*!40000 ALTER TABLE `fine` DISABLE KEYS */;
INSERT INTO `fine` VALUES (1,50,'Lost ticket',1);
/*!40000 ALTER TABLE `fine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkingevent`
--

DROP TABLE IF EXISTS `parkingevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkingevent` (
  `eventId` int NOT NULL AUTO_INCREMENT,
  `parkingEntryTime` datetime NOT NULL,
  `parkingExitTime` datetime DEFAULT NULL,
  PRIMARY KEY (`eventId`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkingevent`
--

LOCK TABLES `parkingevent` WRITE;
/*!40000 ALTER TABLE `parkingevent` DISABLE KEYS */;
INSERT INTO `parkingevent` VALUES (1,'2023-04-17 12:00:00','2023-04-18 19:28:18'),(2,'2023-04-17 08:00:00','2023-04-17 10:00:00'),(3,'2023-04-17 07:00:00','2023-04-17 09:00:00'),(4,'2023-04-17 08:00:00','2023-04-17 09:00:00'),(5,'2023-04-17 08:00:00','2023-04-17 12:00:00'),(6,'2023-04-18 08:00:00','2023-04-17 09:00:00'),(7,'2023-04-18 14:17:38','2023-04-19 08:48:35'),(8,'2023-04-18 14:17:44',NULL),(21,'2023-04-18 16:27:26',NULL),(31,'2023-04-18 17:34:19',NULL),(32,'2023-04-18 17:41:10',NULL),(33,'2023-04-18 17:41:18',NULL),(34,'2023-04-19 08:19:55',NULL),(35,'2023-04-19 08:23:19','2023-04-19 08:29:35'),(36,'2023-04-19 09:55:41',NULL),(37,'2023-04-19 09:58:54','2023-04-19 10:02:05'),(38,'2023-04-19 12:45:53','2023-04-19 12:46:51'),(39,'2023-04-19 13:22:55','2023-04-19 13:24:02'),(40,'2023-04-19 14:54:51',NULL),(41,'2023-04-20 16:15:17','2023-04-20 16:21:52');
/*!40000 ALTER TABLE `parkingevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkinglot`
--

DROP TABLE IF EXISTS `parkinglot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkinglot` (
  `lotId` int NOT NULL AUTO_INCREMENT,
  `priceId` int DEFAULT NULL,
  `fineId` int DEFAULT NULL,
  `lotName` varchar(50) NOT NULL,
  `lotAddress` varchar(200) NOT NULL,
  `lotCapacity` int NOT NULL,
  PRIMARY KEY (`lotId`),
  KEY `priceId` (`priceId`),
  KEY `fineId` (`fineId`),
  CONSTRAINT `parkinglot_ibfk_1` FOREIGN KEY (`priceId`) REFERENCES `pricing` (`priceId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parkinglot_ibfk_2` FOREIGN KEY (`fineId`) REFERENCES `fine` (`fineId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkinglot`
--

LOCK TABLES `parkinglot` WRITE;
/*!40000 ALTER TABLE `parkinglot` DISABLE KEYS */;
INSERT INTO `parkinglot` VALUES (1,3,1,'Lot A','9 Longwood Avenue',500);
/*!40000 ALTER TABLE `parkinglot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkingspace`
--

DROP TABLE IF EXISTS `parkingspace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkingspace` (
  `spaceId` int NOT NULL AUTO_INCREMENT,
  `lotId` int NOT NULL,
  `spaceLocation` varchar(30) NOT NULL,
  `spaceType` varchar(30) NOT NULL,
  `disabledAccessibilityStatus` tinyint(1) NOT NULL,
  `spaceReserved` tinyint(1) NOT NULL,
  `spaceAvailability` tinyint(1) NOT NULL,
  PRIMARY KEY (`spaceId`,`lotId`),
  KEY `lotId` (`lotId`),
  CONSTRAINT `parkingspace_ibfk_1` FOREIGN KEY (`lotId`) REFERENCES `parkinglot` (`lotId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkingspace`
--

LOCK TABLES `parkingspace` WRITE;
/*!40000 ALTER TABLE `parkingspace` DISABLE KEYS */;
INSERT INTO `parkingspace` VALUES (1,1,'A1','car',0,0,0),(2,1,'A2','car',0,0,0),(3,1,'A3','car',0,0,0),(4,1,'B2','car',0,0,0),(5,1,'C2','car',0,0,1),(6,1,'D1','car',0,0,1),(7,1,'D2','car',0,0,1),(8,1,'D3','car',0,0,1),(9,1,'D4','car',0,0,1);
/*!40000 ALTER TABLE `parkingspace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricing`
--

DROP TABLE IF EXISTS `pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pricing` (
  `priceId` int NOT NULL AUTO_INCREMENT,
  `durationType` varchar(20) NOT NULL,
  `pricePerUnit` int DEFAULT NULL,
  PRIMARY KEY (`priceId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricing`
--

LOCK TABLES `pricing` WRITE;
/*!40000 ALTER TABLE `pricing` DISABLE KEYS */;
INSERT INTO `pricing` VALUES (2,'daily',30),(3,'hourly',10);
/*!40000 ALTER TABLE `pricing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservationId` int NOT NULL AUTO_INCREMENT,
  `reservationFrom` datetime NOT NULL,
  `reservationTo` datetime NOT NULL,
  PRIMARY KEY (`reservationId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'2023-04-19 10:01:00','2023-04-19 11:01:00'),(2,'2023-04-18 10:01:00','2023-04-18 16:01:00'),(3,'2023-04-20 10:01:00','2023-04-20 20:01:00');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffId` int NOT NULL AUTO_INCREMENT,
  `lotId` int DEFAULT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `emailId` varchar(30) NOT NULL UNIQUE,
  `phoneNo` varchar(20) NOT NULL UNIQUE,
  `address` varchar(150) NOT NULL,
  PRIMARY KEY (`staffId`),
  KEY `lotId` (`lotId`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`lotId`) REFERENCES `parkinglot` (`lotId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,1,'Yug','Rajani','yug.rajani99@gmail.com','6176517445','4 Longwood Avenue, Boston');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transactionId` int NOT NULL AUTO_INCREMENT,
  `reservationId` int DEFAULT NULL,
  `eventId` int DEFAULT NULL,
  `amount` int NOT NULL,
  `paymentType` varchar(30) NOT NULL,
  `transactionTime` datetime NOT NULL,
  PRIMARY KEY (`transactionId`),
  KEY `reservationId` (`reservationId`),
  KEY `eventId` (`eventId`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`reservationId`) REFERENCES `reservation` (`reservationId`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`eventId`) REFERENCES `parkingevent` (`eventId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,1,20,'online','2023-04-17 14:05:00'),(2,NULL,1,20,'online','2023-04-10 14:05:00'),(3,NULL,1,320,'card','2023-04-18 19:28:18'),(4,NULL,35,10,'card','2023-04-19 08:24:59'),(5,NULL,35,10,'card','2023-04-19 08:27:31'),(6,NULL,35,10,'card','2023-04-19 08:29:35'),(7,NULL,7,190,'card','2023-04-19 08:48:35'),(8,NULL,37,10,'card','2023-04-19 10:02:05'),(9,NULL,38,10,'card','2023-04-19 12:46:51'),(10,NULL,39,10,'card','2023-04-19 13:24:02'),(11,NULL,41,10,'card','2023-04-20 16:21:52');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `vehicleNumberPlate` varchar(10) NOT NULL,
  `vehicleType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`vehicleNumberPlate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES ('MX112Z','car');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_parkingspace_parkingevent`
--

DROP TABLE IF EXISTS `vehicle_parkingspace_parkingevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_parkingspace_parkingevent` (
  `vehicleNumberPlate` varchar(10) DEFAULT NULL,
  `eventId` int DEFAULT NULL,
  `spaceId` int DEFAULT NULL,
  KEY `eventId` (`eventId`),
  KEY `spaceId` (`spaceId`),
  KEY `vehicleNumberPlate` (`vehicleNumberPlate`),
  CONSTRAINT `vehicle_parkingspace_parkingevent_ibfk_1` FOREIGN KEY (`eventId`) REFERENCES `parkingevent` (`eventId`),
  CONSTRAINT `vehicle_parkingspace_parkingevent_ibfk_2` FOREIGN KEY (`spaceId`) REFERENCES `parkingspace` (`spaceId`),
  CONSTRAINT `vehicle_parkingspace_parkingevent_ibfk_3` FOREIGN KEY (`vehicleNumberPlate`) REFERENCES `vehicle` (`vehicleNumberPlate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_parkingspace_parkingevent`
--

LOCK TABLES `vehicle_parkingspace_parkingevent` WRITE;
/*!40000 ALTER TABLE `vehicle_parkingspace_parkingevent` DISABLE KEYS */;
INSERT INTO `vehicle_parkingspace_parkingevent` VALUES ('MX112Z',1,1);
/*!40000 ALTER TABLE `vehicle_parkingspace_parkingevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'parking_management'
--

--
-- Dumping routines for database 'parking_management'
--
/*!50003 DROP FUNCTION IF EXISTS `bill_generation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `bill_generation`(parking_event_id INT) RETURNS json
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE parking_entry_time DATETIME;
  DECLARE duration_type VARCHAR(20);
  DECLARE price_per_unit INT;
  select parkingEntryTime INTO parking_entry_time from parkingevent where eventId = parking_event_id;
  UPDATE parkingEvent SET parkingExitTime = NOW() where eventId = parking_event_id;
  RETURN JSON_OBJECT(
  'parking_entry_time', parking_entry_time, 
  'parking_exit_time', NOW()
  );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_customer_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_customer_exists`(email_or_phone VARCHAR(100)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE count boolean;
  select count(*) INTO count from customer where phoneNo = email_or_phone or emailId = email_or_phone;
  IF count > 0 THEN
    RETURN 1;
  ELSE 
  RETURN 0;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `check_staff_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `check_staff_exists`(email_or_phone VARCHAR(100)) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE count boolean;
  select count(*) INTO count from staff where phoneNo = email_or_phone or emailId = email_or_phone;
  IF count > 0 THEN
    RETURN 1;
  ELSE 
  RETURN 0;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_all_parking_spaces` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_all_parking_spaces`(lot_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE count INT;
  select count(*) INTO count from parkingspace where lotId = 1;
  RETURN count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_available_parking_spaces` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_available_parking_spaces`(lot_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE count INT;
  select count(*) INTO count from parkingspace where lotId = lot_id and spaceAvailability = 1 and spaceReserved = 0;
  RETURN count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_fine_amount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_fine_amount`(lot_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE fine_amount INT;
  select fineAmount INTO fine_amount from fine where lotId = lot_id;
  RETURN fine_amount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_reservation_to_time` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_reservation_to_time`(reservation_id INT) RETURNS json
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE reservation_to DATETIME;
    DECLARE reservation_from DATETIME;
    DECLARE parking_event_id INT;
    SELECT reservationTo INTO reservation_to FROM reservation WHERE reservationId = reservation_id;
    SELECT reservationFrom INTO reservation_from FROM reservation WHERE reservationId = reservation_id;
    
    IF reservation_to IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservation does not exist';
    ELSEIF NOW() > reservation_from AND NOW() < reservation_to THEN
		INSERT INTO parkingevent (parkingEntryTime) VALUES (NOW());
        SELECT LAST_INSERT_ID() INTO parking_event_id;
        RETURN JSON_OBJECT(
        'reservation_to', reservation_to,
        'parking_event_id', parking_event_id
        );
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reservation invalid';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_transaction_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_transaction_summary`() RETURNS json
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE yesterday_total INT DEFAULT 0;
    DECLARE last_week_total INT DEFAULT 0;
    DECLARE last_month_total INT DEFAULT 0;

    SELECT SUM(amount) INTO yesterday_total FROM transaction 
    WHERE DATE(transactionTime) = DATE(NOW() - INTERVAL 1 DAY);

    SELECT SUM(amount) INTO last_week_total FROM transaction 
    WHERE DATE(transactionTime) BETWEEN (NOW() - INTERVAL 1 WEEK) AND NOW();

    SELECT SUM(amount) INTO last_month_total FROM transaction 
    WHERE DATE(transactionTime) BETWEEN (NOW() - INTERVAL 1 MONTH) AND NOW();

    RETURN JSON_OBJECT(
        'yesterday_total', yesterday_total,
        'last_week_total', last_week_total,
        'last_month_total', last_month_total
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_unreserved_parking_space` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_unreserved_parking_space`(lot_id INT, disability_status tinyint) RETURNS json
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE space_location varchar(30);
  DECLARE parking_event_id INT;
  DECLARE cur CURSOR FOR select spaceLocation FROM parkingspace where lotId = lot_id and spaceAvailability = 1 and spaceReserved = 0 and disabledAccessibilityStatus = disability_status LIMIT 1;
  DECLARE CONTINUE HANDLER FOR NOT FOUND
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No unreserved parking space found';
  IF NOT EXISTS(SELECT * FROM parkingLot WHERE lotId = lot_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lot id does not exist';
  END IF;
  OPEN cur;
  FETCH cur INTO space_location;
  CLOSE cur;
  INSERT INTO parkingevent (parkingEntryTime) VALUES (NOW());
  SELECT LAST_INSERT_ID() INTO parking_event_id;
  UPDATE parkingspace SET spaceAvailability = 0 WHERE spaceLocation = space_location and lotId = lot_id;
  RETURN JSON_OBJECT(
  'space_location', space_location, 
  'parking_event_id', parking_event_id
  );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_parking_lot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_parking_lot`(IN lot_id INT)
BEGIN
    IF NOT EXISTS(SELECT * FROM parkinglot WHERE lotId = lot_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'parking lot id does not exist';
    END IF;
    DELETE from parkingLot where lotId = lot_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_parking_space` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_parking_space`(IN lot_id INT, IN space_id INT)
BEGIN
	DELETE from parkingspace where spaceId=space_id and lotId=lot_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_customer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_customer`(
    IN first_name VARCHAR(50),
    IN last_name VARCHAR(50),
    IN email_id VARCHAR(30),
    IN phone_no VARCHAR(20),
    IN cust_add VARCHAR(150)
)
BEGIN
    INSERT INTO customer(firstName,lastName,emailId,phoneNo,address) 
    VALUES (first_name,last_name,email_id,phone_no,cust_add);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_Customer_ParkingSpace_Reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_Customer_ParkingSpace_Reservation`(
    IN reservation_id INT,
    IN customer_id INT,
    IN space_id INT
)
BEGIN
	IF NOT EXISTS(SELECT * FROM reservation WHERE reservationId = reservation_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'reservation id does not exist';
    END IF;
    IF NOT EXISTS(SELECT * FROM customer WHERE customerId = customer_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'customer id does not exist';
    END IF;
    IF NOT EXISTS(SELECT * FROM parkingspace WHERE spaceId = space_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'space id does not exist';
    END IF;
    INSERT INTO customer_parkingspace_reservation(reservationId,customerId ,spaceId) 
    VALUES (reservation_id,customer_id,space_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_fine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_fine`(
    IN fine_amount INT,
    IN fine_reason VARCHAR(300)
)
BEGIN
    INSERT INTO fine(fineAmount, fineReason) 
    VALUES (fine_amount, fine_reason);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_lot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_lot`(
    IN lot_name VARCHAR(50),
    IN lot_address VARCHAR(200),
    IN lot_capacity INT
)
BEGIN
    INSERT INTO parkingLot(priceId,fineId,lotName,lotAddress,lotCapacity) 
    VALUES (3,1,lot_name,lot_address,lot_capacity);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_parking_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_parking_event`(
    IN parking_entry_time DATETIME,
    IN parking_exit_time DATETIME
)
BEGIN
    INSERT INTO parkingevent(parkingEntryTime,parkingExitTime) 
    VALUES (parking_entry_time,parking_exit_time);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_parking_space` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_parking_space`(
    IN lot_id INT,
    IN space_location VARCHAR(30),
    IN space_type VARCHAR(30),
    IN disabled_accessibility_status boolean
)
BEGIN
IF NOT EXISTS(SELECT * FROM parkingLot WHERE lotId = lot_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lot id does not exist';
    END IF;
    INSERT INTO parkingspace(lotId,spaceLocation,spaceType,disabledAccessibilityStatus,spaceReserved,spaceAvailability) 
    VALUES (lot_id,space_location,space_type,disabled_accessibility_status,0,1);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_pricing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pricing`(
    IN duration_type VARCHAR(20),
    IN price_per_unit INT
)
BEGIN
    INSERT INTO pricing(durationType, pricePerUnit) 
    VALUES (duration_type, price_per_unit);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_reservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_reservation`(
    IN reservation_from DATETIME,
    IN reservation_to DATETIME
)
BEGIN
    INSERT INTO reservation(reservationFrom,reservationTo) 
    VALUES (reservation_from,reservation_to);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_staff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_staff`(
    IN lot_id INT,
    IN first_name VARCHAR(50),
    IN last_name VARCHAR(50),
    IN email_id VARCHAR(30),
    IN phone_no VARCHAR(20),
    IN staff_add VARCHAR(150)
)
BEGIN
IF NOT EXISTS(SELECT * FROM parkingLot WHERE lotId = lot_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Lot id does not exist';
    END IF;
    INSERT INTO staff(lotId,firstName,lastName,emailId,phoneNo,address) 
    VALUES (lot_id,first_name,last_name,email_id,phone_no,staff_add);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_transaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_transaction`(
    IN event_id INT,
    IN tran_amount INT,
    IN payment_type VARCHAR(30)
)
BEGIN
IF NOT EXISTS(SELECT * FROM parkingevent WHERE eventId = event_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'event id does not exist';
    END IF;
    INSERT INTO transaction(eventId,amount,paymentType,transactionTime) 
    VALUES (event_id,tran_amount,payment_type,NOW());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_vehicle` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_vehicle`(
    IN vehicle_number_plate VARCHAR(10),
    IN vehicle_type VARCHAR(50)
)
BEGIN
    INSERT INTO vehicle(vehicleNumberPlate,vehicleType) 
    VALUES (vehicle_number_plate,vehicle_type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_vehicle_parkingspace_parkingevent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_vehicle_parkingspace_parkingevent`(
    IN vehicle_number_plate VARCHAR(10),
    IN event_id INT,
    IN space_id INT
)
BEGIN
	IF NOT EXISTS(SELECT * FROM vehicle WHERE vehicleNumberPlate = vehicle_number_plate)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'vehicle does not exist';
    END IF;
    IF NOT EXISTS(SELECT * FROM parkingevent WHERE eventId = event_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'event does not exist';
    END IF;
    IF NOT EXISTS(SELECT * FROM parkingspace WHERE spaceId = space_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'space id does not exist';
    END IF;
    INSERT INTO vehicle_parkingspace_parkingevent(vehicleNumberPlate,eventId ,spaceId) 
    VALUES (vehicle_number_plate,event_id,space_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_parking_lot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_parking_lot`(
IN lot_id INT,
lot_name VARCHAR(50),
lot_address VARCHAR(200),
lot_capacity INT
)
BEGIN
	DECLARE price_id INT;
    DECLARE fine_id INT;
	IF NOT EXISTS(SELECT * FROM parkinglot WHERE lotId = lot_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'parking lot id does not exist';
    END IF;
    
    SELECT priceId, fineId INTO price_id, fine_id from parkinglot where lotId = lot_id;
    
	UPDATE parkinglot SET
    priceId = IF(priceId is not null, priceId, price_id),
    fineId = IF(fineId is not null, fineId, fine_id),
    lotName = COALESCE(lot_name, parkinglot.lotName),
    lotAddress = COALESCE(lot_address, parkinglot.lotAddress),
    lotCapacity = COALESCE(lot_capacity, parkinglot.lotCapacity)
    where lotId = lot_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_parking_space` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_parking_space`(
IN lot_id INT,
IN space_id INT,
space_location VARCHAR(50),
space_type VARCHAR(200),
disability_status TINYINT,
space_reserved TINYINT,
space_availability TINYINT
)
BEGIN
	DECLARE price_id INT;
    DECLARE fine_id INT;
	IF NOT EXISTS(SELECT * FROM parkinglot WHERE lotId = lot_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'parking lot id does not exist';
    END IF;
    IF NOT EXISTS(SELECT * FROM parkingspace WHERE spaceId = space_id)
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'parking space id does not exist';
    END IF;
    
    
	UPDATE parkingspace SET
    spaceId = IF(spaceId is not null, spaceId, space_id),
    lotId = IF(lotId is not null, lotId, lot_id),
    spaceLocation = COALESCE(space_location, parkingspace.spaceLocation),
    spaceType = COALESCE(space_type, parkingspace.spaceType),
    disabledAccessibilityStatus = COALESCE(disability_status, parkingspace.disabledAccessibilityStatus),
    spaceReserved = COALESCE(space_reserved, parkingspace.spaceReserved),
    spaceAvailability = COALESCE(space_availability, parkingspace.spaceAvailability)
    where lotId = lot_id and spaceId = space_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-20 20:55:17
