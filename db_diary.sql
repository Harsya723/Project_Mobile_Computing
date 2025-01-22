-- MySQL dump 10.13  Distrib 9.1.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: db_diary
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Test Users','adam','adam@mail.com',NULL,'$2y$10$qlhdBS2jiekOFDJgkhuwKOWZFkMFTOvixYlQLr.VdjUQMBD6mEbca',NULL,'2025-01-07 09:52:04','2025-01-07 16:30:47'),(2,'Ludfi Rahman','rahman','rahman@mail.com',NULL,'$2y$10$VhCAAgi07nBzy0SSHEN4z.Bc/bZgdIFjJr9aZEWaFKNF2KvuJxkni',NULL,'2025-01-07 16:32:02','2025-01-07 16:32:02'),(3,'Dio Vanny','dio','dio@mail.com',NULL,'$2y$10$Ikjqhno1VH6Vr2KotsLAV.3sdugPbtGRaxZ/1H3HNNk1VpDZpIJzC',NULL,'2025-01-07 16:34:17','2025-01-07 16:34:17'),(4,'Angger Dwi','angger','angger@mail.com',NULL,'$2y$10$MOoV1UVRhuCsF1RgJaIsgew9dTVXMqPfFfCr5oZ11CYaZVq98fxJm',NULL,'2025-01-07 16:35:21','2025-01-07 16:35:21'),(5,'Elvira Sania','sania','sania@mail.com',NULL,'$2y$10$zmmYp7dg589.yBfqK08fUe0HVtxhN/UeOBuIggdDSVc69eYzX1NM.',NULL,'2025-01-07 16:36:47','2025-01-07 16:36:47'),(6,'TETSING','testingsz','alfi@mail.com',NULL,'$2y$10$P9ByIyogGLHXT.k3cZO7HemOpX3Ob78ODpMkc.J2Jd6Egt2ysfb9y',NULL,'2025-01-07 16:41:38','2025-01-07 16:44:07'),(7,'Rentenirs','rentenir','rentenir@mail.com',NULL,'$2y$10$ERFI0rAEBjwPKBDI.3wFDeYrHW4DH8dPi16YbkEnCym5zmKsTTsCi',NULL,'2025-01-14 13:06:32','2025-01-14 13:06:32');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_user_id_foreign` (`user_id`),
  CONSTRAINT `categories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,'Work','2025-01-07 09:52:04','2025-01-07 09:52:04'),(2,1,'Personal','2025-01-07 09:52:04','2025-01-07 09:52:04'),(3,1,'Family','2025-01-07 09:52:04','2025-01-07 09:52:04'),(4,1,'Testing','2025-01-07 13:29:21','2025-01-07 13:34:05'),(7,1,'Testingssss','2025-01-14 10:11:16','2025-01-14 10:15:49'),(9,7,'Rentenir','2025-01-14 13:43:17','2025-01-14 13:43:17');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diaries`
--

DROP TABLE IF EXISTS `diaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `diaries_user_id_foreign` (`user_id`),
  KEY `diaries_category_id_foreign` (`category_id`),
  CONSTRAINT `diaries_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `diaries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diaries`
--

LOCK TABLES `diaries` WRITE;
/*!40000 ALTER TABLE `diaries` DISABLE KEYS */;
INSERT INTO `diaries` VALUES (1,1,2,'Work Diary','Work Diary','This is a work diary.','2025-01-07','','2025-01-07 09:52:04','2025-01-07 09:52:04'),(2,1,2,'Personal Diary','Personal Diary','This is a personal diary.','2025-01-07','uploads/diaries/1736261069.jpg','2025-01-07 09:52:04','2025-01-07 09:52:04'),(3,1,3,'Family Diary','Family Diary','This is a family diary.','2025-01-07','uploads/diaries/1736261069.jpg','2025-01-07 09:52:04','2025-01-07 09:52:04'),(4,1,4,'azsdas','dasdas','asdasdas','2025-01-06','uploads/diaries/1736261069.jpg','2025-01-07 14:44:29','2025-01-07 15:24:54'),(5,6,1,'Working Test','Working Testx','Testing x testingx','2025-01-08','uploads/diaries/1736268155.jpg','2025-01-07 16:42:35','2025-01-07 16:42:35'),(6,1,1,'Testing Angger','Testing Anggers','Testing Lorem lorem','2024-01-07',NULL,'2025-01-14 10:39:41','2025-01-14 10:39:41'),(7,7,4,'Working Test','Working Testx','Testing x testingxs','2025-01-13','./../uploads/diaries/1736865550.jpg','2025-01-14 14:09:43','2025-01-14 14:39:10');
/*!40000 ALTER TABLE `diaries` ENABLE KEYS */;
UNLOCK TABLES;
