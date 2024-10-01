-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: haibazoshop
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `cart_details`
--

DROP TABLE IF EXISTS `cart_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cart_id` int NOT NULL,
  `product_variant_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cart_id` (`cart_id`),
  KEY `product_variant_id` (`product_variant_id`),
  CONSTRAINT `cart_details_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_details_ibfk_2` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_details`
--

LOCK TABLES `cart_details` WRITE;
/*!40000 ALTER TABLE `cart_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên danh mục, vd: dồ dùng điện',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Home & Decor'),(2,'Clothing'),(3,'Accessories'),(4,'OutDoor'),(5,'OutDoor2');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colors`
--

DROP TABLE IF EXISTS `colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `hex_code` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colors`
--

LOCK TABLES `colors` WRITE;
/*!40000 ALTER TABLE `colors` DISABLE KEYS */;
INSERT INTO `colors` VALUES (1,'Red','#FF0000'),(2,'Green','#00FF00'),(3,'Blue','#0000FF'),(4,'Yellow','#FFFF00'),(5,'Black','#000000'),(6,'White','#FFFFFF');
/*!40000 ALTER TABLE `colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_variant_id` int DEFAULT NULL,
  `quantity` int NOT NULL COMMENT 'Số lượng sản phẩm được đặt',
  `price` decimal(10,2) NOT NULL COMMENT 'Giá của sản phẩm tại thời điểm đặt hàng',
  `discount` int NOT NULL DEFAULT '0' COMMENT 'Phần trăm giảm giá tại thời điểm đặt hàng',
  `total` decimal(10,2) GENERATED ALWAYS AS (((`quantity` * `price`) * (1 - (`discount` / 100)))) STORED COMMENT 'Tổng tiền cho sản phẩm này',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_variant_id` (`product_variant_id`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE SET NULL,
  CONSTRAINT `order_details_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` (`id`, `order_id`, `product_variant_id`, `quantity`, `price`, `discount`, `created_at`, `updated_at`) VALUES (1,1,1,2,75000.00,10,'2024-10-01 17:18:28','2024-10-01 17:18:28');
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address` varchar(255) NOT NULL COMMENT 'Địa chỉ giao hàng',
  `phone` varchar(15) NOT NULL COMMENT 'Số điện thoại liên hệ',
  `amount` decimal(10,2) NOT NULL COMMENT 'Tổng số tiền của đơn hàng',
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Ngày đặt hàng',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Trạng thái đơn hàng (0: Chờ xử lý, 1: Đang giao, 2: Hoàn thành, 3: Hủy)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'123 Nguyen Trai, Hue','0123456789',150000.00,'2024-10-02 00:10:30',1,'2024-10-01 17:10:30','2024-10-01 17:10:30'),(2,2,'456 Le Loi, Hue','0987654321',250000.00,'2024-10-02 00:10:30',2,'2024-10-01 17:10:30','2024-10-01 17:10:30'),(3,1,'789 Hai Ba Trung, Hue','0234567890',300000.00,'2024-10-02 00:10:30',1,'2024-10-01 17:10:30','2024-10-01 17:10:30'),(4,3,'321 Bui Thi Xuan, Hue','0345678901',450000.00,'2024-10-02 00:10:30',3,'2024-10-01 17:10:30','2024-10-01 17:10:30'),(5,2,'654 Tran Hung Dao, Hue','0456789012',500000.00,'2024-10-02 00:10:30',2,'2024-10-01 17:10:30','2024-10-01 17:10:30');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (1,2,'a1cca810-0462-4a5e-b9d9-52fe45b18658_download (1).jpeg'),(2,2,'d928a8d1-3a30-4424-b5f3-7a8fdf55f608_download (1).jpeg'),(3,2,'40ab243d-ea34-41d5-ae54-facba3fe00a6_images (3).jpeg'),(4,2,'90f459df-20a2-4821-af58-4831d11f1502_f6f4eba605f0e3264eecf0226ae6eaef.jpg'),(5,2,'e5cbfc3f-08fa-48b9-9e99-359d7f5bd1db_download (1).jpeg');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL COMMENT 'Khóa ngoại tham chiếu đến bảng sản phẩm',
  `style_id` int DEFAULT NULL COMMENT 'Kiểu dáng',
  `color_id` int DEFAULT NULL COMMENT 'Màu sắc',
  `size_id` int DEFAULT NULL COMMENT 'Kích thước',
  `quantity` int NOT NULL COMMENT 'Số lượng của biến thể',
  `status` tinyint(1) DEFAULT '1' COMMENT 'Trạng thái biến thể (1: Còn hàng, 0: Hết hàng)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `style_id` (`style_id`),
  KEY `color_id` (`color_id`),
  KEY `size_id` (`size_id`),
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_variants_ibfk_2` FOREIGN KEY (`style_id`) REFERENCES `styles` (`id`),
  CONSTRAINT `product_variants_ibfk_3` FOREIGN KEY (`color_id`) REFERENCES `colors` (`id`),
  CONSTRAINT `product_variants_ibfk_4` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (1,1,1,1,1,10,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(2,1,2,2,2,15,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(3,1,3,3,3,20,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(4,2,4,2,1,12,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(5,2,5,4,2,18,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(6,2,6,5,3,22,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(7,3,3,1,2,17,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(8,3,2,3,3,20,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(9,3,1,4,4,25,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(10,4,6,6,1,30,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(11,4,5,1,2,10,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(12,5,4,2,3,15,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(13,6,3,3,4,18,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(14,7,2,4,1,22,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(15,8,1,5,2,17,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(16,9,4,6,3,20,1,'2024-09-30 18:31:04','2024-09-30 18:31:04'),(17,10,5,1,4,30,1,'2024-09-30 18:31:04','2024-09-30 18:31:04');
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(350) NOT NULL COMMENT 'Tên sản phẩm',
  `price` float NOT NULL COMMENT 'Giá chung cho tất cả các biến thể',
  `thumbnail` varchar(300) DEFAULT '' COMMENT 'Hình đại diện',
  `discount` int NOT NULL DEFAULT '0' COMMENT 'Phần trăm giảm giá',
  `description` varchar(1000) DEFAULT NULL COMMENT 'Mô tả sản phẩm',
  `quantity` int NOT NULL COMMENT 'Tổng số lượng sản phẩm (tính theo tất cả biến thể)',
  `sold` int NOT NULL DEFAULT '0' COMMENT 'Số lượng sản phẩm đã bán',
  `status` tinyint(1) DEFAULT '1' COMMENT 'Trạng thái sản phẩm (1: Đang bán, 0: Ngừng bán)',
  `category_id` int DEFAULT NULL COMMENT 'Khóa ngoại tham chiếu đến danh mục',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `products_chk_1` CHECK ((`price` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Product 1',100,'thumbnail1.jpg',10,'Description of product 1',50,5,1,1,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(2,'Product 2',150,'thumbnail2.jpg',15,'Description of product 2',40,8,1,2,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(3,'Product 3',200,'thumbnail3.jpg',20,'Description of product 3',30,10,1,3,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(4,'Product 4',250,'thumbnail4.jpg',25,'Description of product 4',60,12,1,4,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(5,'Product 5',120,'thumbnail5.jpg',12,'Description of product 5',45,6,1,1,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(6,'Product 6',130,'thumbnail6.jpg',14,'Description of product 6',35,4,1,2,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(7,'Product 7',140,'thumbnail7.jpg',16,'Description of product 7',25,3,1,3,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(8,'Product 8',160,'thumbnail8.jpg',18,'Description of product 8',70,15,1,4,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(9,'Product 9',170,'thumbnail9.jpg',17,'Description of product 9',55,9,1,1,'2024-09-30 18:30:42','2024-09-30 18:30:42'),(10,'Product 10',180,'thumbnail10.jpg',19,'Description of product 10',65,7,1,2,'2024-09-30 18:30:42','2024-09-30 18:30:42');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_detail_id` int NOT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_detail_id` (`order_detail_id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `rates_ibfk_1` FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rates_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rates_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rates_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES (1,1,1,1,5,'Great product, exceeded my expectations!','2024-10-01 18:02:39','2024-10-01 18:02:39'),(2,1,2,1,4,'Very good product, but a bit expensive.','2024-10-01 18:02:39','2024-10-01 18:02:39'),(3,1,1,2,3,'Average quality, not bad but not great.','2024-10-01 18:02:39','2024-10-01 18:02:39'),(4,1,3,3,2,'Did not meet my expectations at all.','2024-10-01 18:02:39','2024-10-01 18:02:39'),(5,1,2,3,5,'Love it! Will definitely buy again.','2024-10-01 18:02:39','2024-10-01 18:02:39');
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (1,'S'),(2,'M'),(3,'L'),(4,'XL');
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `styles`
--

DROP TABLE IF EXISTS `styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `styles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `styles`
--

LOCK TABLES `styles` WRITE;
/*!40000 ALTER TABLE `styles` DISABLE KEYS */;
INSERT INTO `styles` VALUES (1,'Modern'),(2,'Streetwear'),(3,'Colorful'),(4,'Vintage'),(5,'Bohemian'),(6,'Chic');
/*!40000 ALTER TABLE `styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) DEFAULT '',
  `phone_number` varchar(10) NOT NULL,
  `address` varchar(200) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Nguyen Van A','0123456789','123 Nguyen Trai, Hue','2024-10-02 00:08:45','2024-10-02 00:08:45',1,'1990-01-01'),(2,'Tran Thi B','0987654321','456 Le Loi, Hue','2024-10-02 00:08:45','2024-10-02 00:08:45',1,'1995-02-15'),(3,'Le Van C','0234567890','789 Hai Ba Trung, Hue','2024-10-02 00:08:45','2024-10-02 00:08:45',0,'1988-03-30'),(4,'Pham Thi D','0345678901','321 Bui Thi Xuan, Hue','2024-10-02 00:08:45','2024-10-02 00:08:45',1,'1992-04-25'),(5,'Hoang Van E','0456789012','654 Tran Hung Dao, Hue','2024-10-02 00:08:45','2024-10-02 00:08:45',1,'1985-05-10');
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

-- Dump completed on 2024-10-02  1:39:50
