-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: onion_sense_db
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `box_sensor_readings`
--

DROP TABLE IF EXISTS `box_sensor_readings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `box_sensor_readings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `box_id` int NOT NULL,
  `city_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `sensor1` float NOT NULL,
  `sensor2` float NOT NULL,
  `sensor3` float NOT NULL,
  `sensor4` float NOT NULL,
  `sensor5` float NOT NULL,
  `sensor6` float NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  KEY `user_id` (`user_id`),
  KEY `idx_box_city_timestamp` (`box_id`,`city_id`,`timestamp`),
  CONSTRAINT `box_sensor_readings_ibfk_1` FOREIGN KEY (`box_id`) REFERENCES `boxes` (`id`),
  CONSTRAINT `box_sensor_readings_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `box_sensor_readings_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box_sensor_readings`
--

LOCK TABLES `box_sensor_readings` WRITE;
/*!40000 ALTER TABLE `box_sensor_readings` DISABLE KEYS */;
INSERT INTO `box_sensor_readings` VALUES (1,1,1,8,25.4,78.2,12.3,0.5,45.2,67.8,'2025-08-18 09:12:00'),(2,3,2,8,30.1,82.5,15.4,0.7,48.1,70,'2025-08-19 11:25:00'),(3,2,1,8,28,79.9,13.6,0.6,46,68.5,'2025-08-20 14:10:00'),(4,7,3,8,32.5,85.1,16.2,0.9,50.2,72.3,'2025-08-21 16:45:00'),(5,5,4,8,29.2,80,14,0.8,47.5,69,'2025-08-22 10:30:00'),(6,8,2,8,31,83.4,15.8,1,49.1,71.5,'2025-08-23 09:50:00'),(7,4,1,8,27.5,78.8,13,0.6,45.7,67.2,'2025-08-24 12:15:00'),(8,6,3,8,33.2,86,16.5,1.1,51,73,'2025-08-25 15:40:00'),(9,10,4,8,30.5,81.2,14.8,0.9,48.7,70.5,'2025-08-26 08:20:00'),(10,9,1,8,28.8,79.5,13.9,0.7,46.5,68.8,'2025-08-27 13:35:00'),(11,1,2,8,31.5,84,15.9,1,49.5,72,'2025-08-28 11:50:00'),(12,2,3,8,29,80.8,14.2,0.8,47.8,69.8,'2025-08-29 10:10:00'),(13,3,4,8,32,85.5,16,1,50.5,72.5,'2025-08-30 14:20:00'),(14,4,1,8,28.5,79,13.5,0.6,46.2,68,'2025-08-31 16:05:00'),(15,5,2,8,30.8,82.7,15,0.9,48.9,71,'2025-09-01 09:45:00'),(16,6,3,8,33,86.2,16.6,1.1,51.2,73.2,'2025-09-02 13:15:00'),(17,7,4,8,29.5,81,14.5,0.8,48,70,'2025-09-03 12:40:00'),(18,8,1,8,31.2,83.5,15.7,1,49.7,72,'2025-09-04 10:30:00'),(19,9,2,8,28.9,79.8,13.8,0.7,46.8,68.5,'2025-09-05 15:25:00'),(20,10,3,8,32.5,85.8,16.3,1,50.8,73,'2025-09-06 14:10:00'),(21,1,4,8,29.8,81.5,14.7,0.9,48.5,70.2,'2025-09-07 11:00:00'),(22,2,1,8,27.9,78.5,13.2,0.6,45.8,67.5,'2025-09-08 09:20:00'),(23,3,2,8,30.2,82,15.2,0.9,48,70.5,'2025-09-09 13:50:00'),(24,4,3,8,33.5,86.5,16.7,1.1,51.5,73.5,'2025-09-10 16:30:00'),(25,5,4,8,29.2,80.5,14,0.8,47.2,69,'2025-09-11 08:40:00'),(26,6,1,8,31,83,15.5,1,49,72,'2025-09-12 12:15:00'),(27,7,2,8,28.5,79.2,13.6,0.7,46.5,68.5,'2025-09-13 09:50:00'),(28,8,3,8,32,85,16.2,1,50,72.5,'2025-09-14 14:05:00'),(29,9,4,8,29.5,81.2,14.5,0.8,48.5,70.5,'2025-09-15 11:30:00'),(30,10,1,8,30.8,82.8,15.3,0.9,49,71.2,'2025-09-16 13:45:00'),(31,1,2,8,31.5,83.5,15.8,1,49.5,72,'2025-09-16 16:00:00'),(32,2,3,8,28.2,79.5,13.5,0.7,46.5,68.2,'2025-09-16 09:15:00'),(33,3,4,8,32.2,85.5,16,1,50.5,73,'2025-09-16 12:40:00'),(34,4,1,8,29,80,14,0.8,48,70,'2025-09-16 15:20:00'),(35,5,2,8,30.5,82.5,15.2,0.9,48.5,71,'2025-09-16 10:50:00'),(36,6,3,8,33,86,16.5,1.1,51,73,'2025-09-16 14:30:00'),(37,7,4,8,29.8,81,14.5,0.8,48.8,70.5,'2025-09-16 09:35:00'),(38,8,1,8,31.2,83.5,15.7,1,49.7,72,'2025-09-16 13:10:00'),(39,9,2,8,28.9,79.8,13.8,0.7,46.8,68.5,'2025-09-16 11:25:00'),(40,10,3,8,32.5,85.8,16.3,1,50.8,73,'2025-09-16 16:45:00');
/*!40000 ALTER TABLE `box_sensor_readings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boxes`
--

DROP TABLE IF EXISTS `boxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boxes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `cold_storage_id` int DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cold_storage_id` (`cold_storage_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `boxes_ibfk_1` FOREIGN KEY (`cold_storage_id`) REFERENCES `cold_storages` (`id`),
  CONSTRAINT `boxes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boxes`
--

LOCK TABLES `boxes` WRITE;
/*!40000 ALTER TABLE `boxes` DISABLE KEYS */;
INSERT INTO `boxes` VALUES (1,'Box A',1,100,'2025-09-11 12:40:28',8),(2,'Box B',2,120,'2025-09-11 12:40:28',8),(3,'Box C',3,80,'2025-09-11 12:40:28',8),(4,'Box D',4,150,'2025-09-11 12:40:28',8),(5,'Box E',5,90,'2025-09-11 12:40:28',8),(6,'Box AA',1,100,'2025-09-11 12:41:30',8),(7,'Box BB',2,120,'2025-09-11 12:41:30',8),(8,'Box CC',3,80,'2025-09-11 12:41:30',8),(9,'Box DD',4,150,'2025-09-11 12:41:30',8),(10,'Box EE',5,90,'2025-09-11 12:41:30',8);
/*!40000 ALTER TABLE `boxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Default City','India',NULL),(2,'Mumbai','India','Asia/Kolkata'),(3,'Bangalore','India','Asia/Kolkata'),(4,'Hyderabad','India','Asia/Kolkata');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cold_storages`
--

DROP TABLE IF EXISTS `cold_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cold_storages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `city_id` int DEFAULT NULL,
  `address` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cold_storages_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `cold_storages_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cold_storages`
--

LOCK TABLES `cold_storages` WRITE;
/*!40000 ALTER TABLE `cold_storages` DISABLE KEYS */;
INSERT INTO `cold_storages` VALUES (1,'North Delhi Cold Storage',1,'123 Industrial Area, Delhi','2025-09-10 17:34:09',8),(2,'Cold Storage A',1,'123 Street, City1','2025-09-11 12:34:18',8),(3,'Cold Storage B',2,'456 Avenue, City2','2025-09-11 12:34:18',8),(4,'Cold Storage C',3,'789 Boulevard, City3','2025-09-11 12:34:18',8),(5,'Cold Storage D',4,'101 Road, City4','2025-09-11 12:34:18',8);
/*!40000 ALTER TABLE `cold_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `permissions` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin','{\"edit_user\": true, \"create_user\": true, \"delete_user\": true, \"view_reports\": true, \"access_admin_panel\": true}'),(2,'Manager','{\"edit_user\": true, \"create_user\": true, \"delete_user\": false, \"view_reports\": true, \"access_admin_panel\": false}'),(3,'User','{\"edit_user\": false, \"create_user\": false, \"delete_user\": false, \"view_reports\": true, \"access_admin_panel\": false}');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensor_disconnect_logs`
--

DROP TABLE IF EXISTS `sensor_disconnect_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensor_disconnect_logs` (
  `sensor_id` int NOT NULL,
  `sensor_name` varchar(255) NOT NULL,
  `city_id` int NOT NULL,
  `cold_storage_id` int NOT NULL,
  `box_id` int NOT NULL,
  `user_id` int NOT NULL,
  `disconnected_at` datetime NOT NULL,
  PRIMARY KEY (`sensor_id`,`disconnected_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensor_disconnect_logs`
--

LOCK TABLES `sensor_disconnect_logs` WRITE;
/*!40000 ALTER TABLE `sensor_disconnect_logs` DISABLE KEYS */;
INSERT INTO `sensor_disconnect_logs` VALUES (1,'CO2 Sensor',1,1,1,8,'2025-09-12 08:15:00'),(1,'CO2 Sensor',1,1,2,8,'2025-09-12 09:15:00'),(1,'CO2 Sensor',2,2,3,8,'2025-09-12 10:15:00'),(1,'CO2 Sensor',3,3,4,8,'2025-09-12 11:15:00'),(1,'CO2 Sensor',4,4,5,8,'2025-09-12 12:15:00'),(2,'NH3 Sensor',1,1,1,8,'2025-09-12 08:16:00'),(2,'NH3 Sensor',1,1,2,8,'2025-09-12 09:16:00'),(2,'NH3 Sensor',2,2,3,8,'2025-09-12 10:16:00'),(2,'NH3 Sensor',3,3,4,8,'2025-09-12 11:16:00'),(2,'NH3 Sensor',4,4,5,8,'2025-09-12 12:16:00'),(3,'SO2 Sensor',1,1,1,8,'2025-09-12 08:17:00'),(3,'SO2 Sensor',1,1,2,8,'2025-09-12 09:17:00'),(3,'SO2 Sensor',2,2,3,8,'2025-09-12 10:17:00'),(3,'SO2 Sensor',3,3,4,8,'2025-09-12 11:17:00'),(3,'SO2 Sensor',4,4,5,8,'2025-09-12 12:17:00'),(4,'H2S Sensor',1,1,1,8,'2025-09-12 08:18:00'),(4,'H2S Sensor',1,1,2,8,'2025-09-12 09:18:00'),(4,'H2S Sensor',2,2,3,8,'2025-09-12 10:18:00'),(4,'H2S Sensor',3,3,4,8,'2025-09-12 11:18:00'),(4,'H2S Sensor',4,4,5,8,'2025-09-12 12:18:00'),(5,'Temperature Sensor',1,1,1,8,'2025-09-12 08:19:00'),(5,'Temperature Sensor',1,1,2,8,'2025-09-12 09:19:00'),(5,'Temperature Sensor',2,2,3,8,'2025-09-12 10:19:00'),(5,'Temperature Sensor',3,3,4,8,'2025-09-12 11:19:00'),(5,'Temperature Sensor',4,4,5,8,'2025-09-12 12:19:00'),(6,'Humidity Sensor',1,1,1,8,'2025-09-12 08:20:00'),(6,'Humidity Sensor',1,1,2,8,'2025-09-12 09:20:00'),(6,'Humidity Sensor',2,2,3,8,'2025-09-12 10:20:00'),(6,'Humidity Sensor',3,3,4,8,'2025-09-12 11:20:00'),(6,'Humidity Sensor',4,4,5,8,'2025-09-12 12:20:00');
/*!40000 ALTER TABLE `sensor_disconnect_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensors`
--

DROP TABLE IF EXISTS `sensors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `box_id` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `sensor_type` varchar(50) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `box_id` (`box_id`),
  CONSTRAINT `sensors_ibfk_1` FOREIGN KEY (`box_id`) REFERENCES `boxes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensors`
--

LOCK TABLES `sensors` WRITE;
/*!40000 ALTER TABLE `sensors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threshold_breaches`
--

DROP TABLE IF EXISTS `threshold_breaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `threshold_breaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `city_id` int NOT NULL,
  `sensor_name` varchar(50) NOT NULL,
  `timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `cold_storage_id` int NOT NULL,
  `threshold_value` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `city_id` (`city_id`),
  KEY `cold_storage_id` (`cold_storage_id`),
  CONSTRAINT `threshold_breaches_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `threshold_breaches_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`),
  CONSTRAINT `threshold_breaches_ibfk_3` FOREIGN KEY (`cold_storage_id`) REFERENCES `cold_storages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threshold_breaches`
--

LOCK TABLES `threshold_breaches` WRITE;
/*!40000 ALTER TABLE `threshold_breaches` DISABLE KEYS */;
INSERT INTO `threshold_breaches` VALUES (1,8,1,'CO2','2025-09-17 13:44:24',1,75.5),(2,8,1,'H2S','2025-09-17 13:44:24',2,20),(3,8,1,'NH3','2025-09-17 13:44:24',3,50.2),(4,8,1,'SO2','2025-09-17 13:44:24',4,30.1),(5,8,1,'Humidity','2025-09-17 13:44:24',5,60),(6,8,1,'Temperature','2025-09-17 13:44:24',1,28.5),(7,8,2,'CO2','2025-09-17 13:44:24',1,70),(8,8,2,'H2S','2025-09-17 13:44:24',2,25.5),(9,8,2,'NH3','2025-09-17 13:44:24',3,55.3),(10,8,2,'SO2','2025-09-17 13:44:24',4,35.2),(11,8,2,'Humidity','2025-09-17 13:44:24',5,65),(12,8,2,'Temperature','2025-09-17 13:44:24',1,27),(13,8,3,'CO2','2025-09-17 13:44:24',1,80.2),(14,8,3,'H2S','2025-09-17 13:44:24',2,22.5),(15,8,3,'NH3','2025-09-17 13:44:24',3,45.1),(16,8,3,'SO2','2025-09-17 13:44:24',4,33),(17,8,3,'Humidity','2025-09-17 13:44:24',5,70),(18,8,3,'Temperature','2025-09-17 13:44:24',1,26.5),(19,8,4,'CO2','2025-09-17 13:44:24',1,77),(20,8,4,'H2S','2025-09-17 13:44:24',2,21.5),(21,8,4,'NH3','2025-09-17 13:44:24',3,48.7),(22,8,4,'SO2','2025-09-17 13:44:24',4,31.5),(23,8,4,'Humidity','2025-09-17 13:44:24',5,68),(24,8,4,'Temperature','2025-09-17 13:44:24',1,29);
/*!40000 ALTER TABLE `threshold_breaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thresholds`
--

DROP TABLE IF EXISTS `thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thresholds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `cold_storage_id` int NOT NULL,
  `box_id` int NOT NULL,
  `sensor1_threshold` float DEFAULT NULL,
  `sensor2_threshold` float DEFAULT NULL,
  `sensor3_threshold` float DEFAULT NULL,
  `sensor4_threshold` float DEFAULT NULL,
  `sensor5_threshold` float DEFAULT NULL,
  `sensor6_threshold` float DEFAULT NULL,
  `sensor7_threshold` float DEFAULT NULL,
  `sensor8_threshold` float DEFAULT NULL,
  `sensor9_threshold` float DEFAULT NULL,
  `sensor10_threshold` float DEFAULT NULL,
  `sensor11_threshold` float DEFAULT NULL,
  `sensor12_threshold` float DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `cold_storage_id` (`cold_storage_id`),
  KEY `box_id` (`box_id`),
  CONSTRAINT `thresholds_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `thresholds_ibfk_2` FOREIGN KEY (`cold_storage_id`) REFERENCES `cold_storages` (`id`),
  CONSTRAINT `thresholds_ibfk_3` FOREIGN KEY (`box_id`) REFERENCES `boxes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thresholds`
--

LOCK TABLES `thresholds` WRITE;
/*!40000 ALTER TABLE `thresholds` DISABLE KEYS */;
INSERT INTO `thresholds` VALUES (1,8,1,1,50,45,60,55,70,65,40,42,38,60,52,48,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(2,8,1,2,51,46,61,56,71,66,41,43,39,61,53,49,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(3,8,2,3,55,50,65,60,75,70,45,47,43,65,57,53,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(4,8,2,4,56,51,66,61,76,71,46,48,44,66,58,54,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(5,8,3,5,60,55,70,65,80,75,50,52,48,70,62,58,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(6,8,3,6,61,56,71,66,81,76,51,53,49,71,63,59,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(7,8,4,7,65,60,75,70,85,80,55,57,53,75,67,63,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(8,8,4,8,66,61,76,71,86,81,56,58,54,76,68,64,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(9,8,5,9,70,65,80,75,90,85,60,62,58,80,72,68,'2025-09-11 17:33:02','2025-09-11 17:33:02'),(10,8,5,10,71,66,81,76,91,86,61,63,59,81,73,69,'2025-09-11 17:33:02','2025-09-11 17:33:02');
/*!40000 ALTER TABLE `thresholds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int NOT NULL DEFAULT '3',
  `city_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `mobile_no` varchar(15) DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_role` (`role_id`),
  KEY `fk_city` (`city_id`),
  KEY `fk_users_parent` (`parent_id`),
  CONSTRAINT `fk_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `fk_users_parent` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (8,'anurag666','anurag@example.com','scrypt:32768:8:1$zwnE7QX18ChbMQJj$d6ff6ecd0f0f6e9b933507f712ac6b05f66d6c7bea3df680ed13b19000044cd005cb5590a4c785b2ed28eae3880628209a8cc9faa6cafbf51b5881dc0ad0f46c',3,1,'2025-09-10 15:55:51','9988776677',8),(9,'John Doe','john.doe@example.com','scrypt:32768:8:1$zwnE7QX18ChbMQJj$d6ff6ecd0f0f6e9b933507f712ac6b05f66d6c7bea3df680ed13b19000044cd005cb5590a4c785b2ed28eae3880628209a8cc9faa6cafbf51b5881dc0ad0f46c',1,1,'2025-09-18 19:57:57','9876543210',8),(12,'anurag','anurag123@example.com','scrypt:32768:8:1$euCXpgnyxeOqxfwE$ce0ee894080d7ff1a7cc2de37c3e6f0b829f6b0e58fb6a7424dda405cdd3bb1badffa8527badd0efef4e526232e6a83bc6354e8e52ae9baa0047548b68e8f9aa',2,1,'2025-09-19 11:56:20',NULL,NULL),(13,'anurag','anurag1234@example.com','scrypt:32768:8:1$yvWIAp78jB0gA6yN$fc69515b513d303ec97414ea4b52d9bac3c9a5419d5fc00b9edf95fe9b14b3b7c997ea260386c1e62d1bb9e48f80325d1ee9c67c20e4d369a72570578620753e',2,1,'2025-09-19 11:57:39',NULL,NULL),(14,'Anurag','anurag555@example.com','scrypt:32768:8:1$gkFlG3fsiE4lQzcJ$65a1871c0331b7ae2f2944552ab691c8efc2ff6aae94a516f28babcfeb9a1b60f61106515e96acaa369f192552482c3692dcfbfb6692bceb89cca1dbef57f950',3,2,'2025-09-19 12:21:44','',NULL),(15,'Anurag','anurag666@example.com','scrypt:32768:8:1$Z6SdtY40tnlPYa5W$a67d65b1ba57b6b0b4b8c87d34591026395547317c91b09707247cb5e8262796c4a2cab2815fdf6fa24f29e2e2f5fde0252f8e4fabbda6ee55c0514e5f2d25e1',3,1,'2025-09-19 12:25:52','8899877876',8),(16,'Anurag','anurag66@example.com','scrypt:32768:8:1$DAuRBuh95JcNgHcu$cd9c48a6704b38acdc10107b07fdbadf3b3f41fc2f2e92f9cd4458c252d023849d37a7e0eae1a96e33fbca557707b4497bc7dcad25920ea79312252a343e5fad',3,3,'2025-09-19 12:26:31','',8),(17,'Anurag','anurag77@example.com','scrypt:32768:8:1$XXe8qfxvBWZLclm1$1dec6a2fb1ac648065f6281d357698ae55fd907428980561c77eaa305f696fe908f656052fc64d411390138fd378843f702fe5a2a757d23a8353b250dff54e56',3,2,'2025-09-19 12:28:22','',8),(18,'Anurag','anurag345@example.com','scrypt:32768:8:1$KKlGyVfkplNfM7NO$ce09148c1ad52c15288040a456a0a7cc0133370e873d2b36f78e18c23f3abad50a3dc4f766079fb44fd920fd10c71df21d14f072731b6e90e353fef7a4edce20',3,2,'2025-09-19 12:30:20','8899776767',8);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-28 21:06:19
