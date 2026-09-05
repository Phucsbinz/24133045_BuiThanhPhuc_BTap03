-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: servletjpa
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Current Database: `servletjpa`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `servletjpa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `servletjpa`;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `CategoryId` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Images` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Status` int DEFAULT NULL,
  PRIMARY KEY (`CategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Iphone','abc.jpg',1),(3,'Iphone 2820','iphone.jpg',1),(4,'Smartphone 9296','category.jpg',1),(5,'Smartphone 136','category.jpg',1),(6,'Smartphone 9095','category.jpg',1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ProductId` int NOT NULL AUTO_INCREMENT,
  `CreatedDate` date DEFAULT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Images` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `ProductName` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Quantity` int DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `CategoryId` int DEFAULT NULL,
  PRIMARY KEY (`ProductId`),
  KEY `FKqwnly7u89sf9w1x673ufy7lb9` (`CategoryId`),
  CONSTRAINT `FKqwnly7u89sf9w1x673ufy7lb9` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'2026-09-04','Sản phẩm cao cấp chip A18 Pro, thiết kế titan, camera 48MP.','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',34990000,'iPhone 16 Pro Max 9296',25,1,4),(2,'2026-09-04','Sản phẩm cao cấp chip A18 Pro, thiết kế titan, camera 48MP.','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',34990000,'iPhone 16 Pro Max 136',25,1,5),(3,'2026-09-04','Sản phẩm cao cấp chip A18 Pro, thiết kế titan, camera 48MP.','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',34990000,'iPhone 16 Pro Max 9095',25,1,6),(4,'2026-09-04','Thiết kế titan siêu nhẹ, chip Apple A17 Pro mạnh mẽ, camera tiềm vọng zoom quang học 5x.','https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=500',29990000,'iPhone 15 Pro Max 256GB Titan Tự Nhiên',15,1,1),(5,'2026-09-04','Khung viền titan, bút S-Pen tích hợp, màn hình 6.8 inch phẳng Dynamic AMOLED 2X, Galaxy AI.','https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=500',27990000,'Samsung Galaxy S24 Ultra 512GB AI',15,1,1),(6,'2026-09-04','Hiệu năng đỉnh cao với chip M3 Pro, màn hình Liquid Retina XDR 120Hz siêu sắc nét.','https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500',48500000,'MacBook Pro 14 M3 Pro 18GB 512GB',15,1,3),(7,'2026-09-04','Thiết kế tối giản tương lai, bàn di chuột tàng hình, màn hình OLED 3.5K cảm ứng tuyệt đẹp.','https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500',36900000,'Dell XPS 13 Plus 9320 Core i7',15,1,3),(8,'2026-09-04','Độ mỏng kỷ lục 5.3mm, chip Apple M4 thế hệ mới nhất, màn hình OLED 2 lớp Ultra Retina XDR.','https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500',26490000,'iPad Pro M4 11 inch 256GB Wi-Fi',15,1,3),(9,'2026-09-04','Vỏ titan chuẩn quân đội 49mm, định vị GPS tần số kép, pin lên tới 72 giờ ở chế độ tiết kiệm.','https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',19990000,'Apple Watch Ultra 2 Dây Alpine',15,1,4),(10,'2026-09-04','Chống ồn chủ động gấp 2 lần, âm thanh thích ứng thông minh, chuẩn sạc Type-C tiện lợi.','https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=500',5890000,'Tai nghe AirPods Pro 2 USB-C',15,1,4),(11,'2026-09-04','Bộ xử lý V1 và QN1, thời lượng pin 30 giờ, đệm tai da êm ái, công nghệ đàm thoại AI rõ nét.','https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',7990000,'Sony WH-1000XM5 Chống Ồn Cao Cấp',15,1,4),(12,'2026-09-04','Hệ thống 4 camera Leica đỉnh cao cảm biến 1 inch, chip Snapdragon 8 Gen 3, màn hình 2K AMOLED.','https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=500',24990000,'Xiaomi 14 Ultra 16GB 512GB',15,1,1),(13,'2026-09-04','Laptop gaming mỏng nhẹ cao cấp, màn hình ROG Nebula OLED 240Hz, âm thanh 6 loa vòm Dolby Atmos.','https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=500',52990000,'Asus ROG Zephyrus G16 RTX 4070',15,1,3),(14,'2026-09-04','Thiết kế Low-profile siêu mỏng, kết nối Bluetooth 5.1 và Type-C, switch Gateron mượt mà.','https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500',2290000,'Bàn phím cơ Keychron K3 Pro Wireless',15,1,4),(15,'2026-09-04','Cảm biến 8000 DPI lướt trên mặt kính, cuộn siêu tốc MagSpeed, click êm ái giảm 90% tiếng ồn.','https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500',2190000,'Chuột Logitech MX Master 3S',15,1,4);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `createddate` date DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `roleid` int DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otp_expiry` datetime(6) DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin.png','2026-09-04','admin@iotstar.vn','Quan tri vien Admin','$2a$12$Ok9rezkL1nb3A1LzX5Tl.eDWYPgX4Q5zEk7DhrCSB.EhvJX9ikgLm','0901234567',1,'admin',NULL,NULL,1),(2,'manager.png','2026-09-04','manager@iotstar.vn','Quan ly Manager','$2a$12$Ok9rezkL1nb3A1LzX5Tl.eDWYPgX4Q5zEk7DhrCSB.EhvJX9ikgLm','0908888888',2,'manager',NULL,NULL,1),(3,'avatar.png','2026-09-04','phuc@iotstar.vn','Bui Thanh Phuc','$2a$12$Ok9rezkL1nb3A1LzX5Tl.eDWYPgX4Q5zEk7DhrCSB.EhvJX9ikgLm','0908888999',1,'phuc',NULL,NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `VideoId` varchar(255) NOT NULL,
  `Active` int DEFAULT NULL,
  `Description` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Poster` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Title` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Views` int DEFAULT NULL,
  `CategoryId` int DEFAULT NULL,
  PRIMARY KEY (`VideoId`),
  KEY `FK7t06wiw587llhee3ychrp37kl` (`CategoryId`),
  CONSTRAINT `FK7t06wiw587llhee3ychrp37kl` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES ('v01',0,NULL,NULL,'test',0,1),('v136',0,NULL,NULL,'Video Review 136',0,5),('v2820',0,NULL,NULL,'Video Test 2820',0,3),('v9095',0,NULL,NULL,'Video Review 9095',0,6),('v9296',0,NULL,NULL,'Video Review 9296',0,4);
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-05 10:21:46
