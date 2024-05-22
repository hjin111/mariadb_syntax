-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20200109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'홍길동','hello@naver.com',NULL,NULL,35,NULL,'user',NULL,NULL,0),
(5,'world','world@naver.com',NULL,NULL,30,NULL,'user',NULL,NULL,0),
(6,'홍길동','hello6@naver.com',NULL,NULL,15,NULL,'user',NULL,NULL,0),
(14,NULL,'hello14@naver.com',NULL,NULL,10,NULL,'user',NULL,'2024-05-17 12:22:56',0),
(20200101,NULL,'hello15@naver.com',NULL,NULL,40,NULL,'user',NULL,'2024-05-17 12:32:03',0),
(20200103,NULL,NULL,NULL,NULL,45,NULL,'user',NULL,'2024-05-20 12:25:43',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello','hello world',1,1000.000,NULL,'07fc1308-141f-11ef-95f5-105107d6c715'),
(4,'world','hello world world',1,2000.000,'2023-05-17 16:28:34','07fc183d-141f-11ef-95f5-105107d6c715'),
(5,'world','hello world world',5,3000.000,'2022-05-17 16:28:34','07fc18b9-141f-11ef-95f5-105107d6c715'),
(6,'world','hello world world',5,1000.000,NULL,'07fc1bbd-141f-11ef-95f5-105107d6c715'),
(7,'hello java',NULL,6,2000.000,'2021-05-17 16:28:34','07fc1c77-141f-11ef-95f5-105107d6c715'),
(8,'hello',NULL,NULL,3000.000,'1999-05-17 12:22:56','07fc1cf4-141f-11ef-95f5-105107d6c715'),
(9,'hello9',NULL,NULL,2000.000,'2024-05-17 12:33:43','07fc1d62-141f-11ef-95f5-105107d6c715'),
(10,'abc',NULL,NULL,2000.000,'2024-05-17 16:28:34','1360f1a0-141f-11ef-95f5-105107d6c715'),
(12,'hello world java',NULL,NULL,NULL,'2024-05-20 12:48:09','cb7ea03b-165b-11ef-95f5-105107d6c715');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:28:03
