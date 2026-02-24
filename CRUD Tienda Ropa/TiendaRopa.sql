-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: tienda_ropa
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `actualizacion`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actualizacion` (
  `id_actualizacion` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `precio_anterior` decimal(10,2) NOT NULL,
  `precio_nuevo` decimal(10,2) NOT NULL,
  `id_prenda` int NOT NULL,
  `id_empleado` int NOT NULL,
  PRIMARY KEY (`id_actualizacion`),
  KEY `fk_act_prenda` (`id_prenda`),
  KEY `fk_act_emp` (`id_empleado`),
  CONSTRAINT `fk_act_emp` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `fk_act_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actualizacion`
--

LOCK TABLES `actualizacion` WRITE;
/*!40000 ALTER TABLE `actualizacion` DISABLE KEYS */;
INSERT INTO `actualizacion` VALUES (1,'2026-02-07 20:24:25',420.00,450.00,1,1),(2,'2026-02-07 20:24:25',600.00,650.50,2,4),(3,'2026-02-07 20:24:25',1100.00,1200.00,3,1),(4,'2026-02-07 20:24:25',320.00,350.00,4,4),(5,'2026-02-07 20:24:25',380.00,400.00,5,1),(6,'2026-02-18 21:55:06',1200.00,1350.00,3,1);
/*!40000 ALTER TABLE `actualizacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Caballero','Ropa formal, casual y de etiqueta para hombres'),(2,'Dama','Vestidos, blusas y tendencias de temporada para mujeres'),(3,'Infantil','Prendas cómodas y duraderas para niños de 2 a 12 años'),(4,'Deportiva','Ropa técnica de alto rendimiento'),(5,'Accesorios','Complementos como cinturones, bufandas y joyería básica');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color` (
  `id_color` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id_color`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
INSERT INTO `color` VALUES (1,'Negro Nocturno'),(2,'Blanco Pureza'),(3,'Azul Marino'),(4,'Rojo Pasión'),(5,'Gris Oxford');
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `puesto` varchar(20) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  CONSTRAINT `empleado_chk_1` CHECK ((`puesto` in (_utf8mb4'empleado',_utf8mb4'gerente')))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES (1,'Karina Sánchez','gerente'),(2,'Miguel Esparza','empleado'),(3,'Kennia De luna','gerente'),(4,'Mariana Juárez','gerente'),(5,'Guadalupe Hernández','empleado');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimiento_stock`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimiento_stock` (
  `id_movimiento` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `tipo_movimiento` varchar(10) NOT NULL,
  `cantidad` int NOT NULL,
  `id_prenda` int NOT NULL,
  `id_empleado` int NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  KEY `fk_mov_prenda` (`id_prenda`),
  KEY `fk_mov_emp` (`id_empleado`),
  KEY `idx_movimiento_fecha` (`fecha`),
  CONSTRAINT `fk_mov_emp` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `fk_mov_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`),
  CONSTRAINT `movimiento_stock_chk_1` CHECK ((`tipo_movimiento` in (_utf8mb4'entrada',_utf8mb4'salida',_utf8mb4'ajuste')))
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimiento_stock`
--

LOCK TABLES `movimiento_stock` WRITE;
/*!40000 ALTER TABLE `movimiento_stock` DISABLE KEYS */;
INSERT INTO `movimiento_stock` VALUES (1,'2026-02-07 20:24:25','entrada',10,1,2),(2,'2026-02-07 20:24:25','salida',5,2,3),(3,'2026-02-07 20:24:25','ajuste',-2,3,1),(4,'2026-02-07 20:24:25','entrada',20,4,5),(5,'2026-02-07 20:24:25','salida',1,5,2),(66,'2025-10-20 09:00:00','entrada',10,21,2),(67,'2025-10-20 14:30:00','salida',2,22,3),(68,'2025-10-21 08:15:00','entrada',50,23,1),(70,'2025-10-21 16:45:00','ajuste',-1,25,4),(71,'2025-10-22 10:20:00','entrada',20,26,1),(72,'2026-01-22 13:10:00','salida',3,27,5),(73,'2026-01-23 09:45:00','entrada',15,28,2),(74,'2026-01-23 18:20:00','salida',1,29,3),(75,'2026-01-24 07:30:00','entrada',30,30,4),(76,'2026-01-24 15:00:00','salida',10,31,2),(77,'2026-01-25 11:15:00','entrada',5,32,1),(78,'2026-01-25 12:00:00','salida',2,33,5),(79,'2026-01-26 10:00:00','entrada',12,34,2),(80,'2026-01-26 16:30:00','salida',4,35,3),(81,'2026-02-18 22:11:01','ajuste',5,34,1);
/*!40000 ALTER TABLE `movimiento_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prenda`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prenda` (
  `id_prenda` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock_actual` int DEFAULT '0',
  `id_categoria` int NOT NULL,
  `id_talla` int NOT NULL,
  `id_color` int NOT NULL,
  PRIMARY KEY (`id_prenda`),
  KEY `fk_prenda_talla` (`id_talla`),
  KEY `fk_prenda_color` (`id_color`),
  KEY `idx_prenda_nombre` (`nombre`),
  KEY `idx_prenda_cat_talla` (`id_categoria`,`id_talla`),
  CONSTRAINT `fk_prenda_cat` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  CONSTRAINT `fk_prenda_color` FOREIGN KEY (`id_color`) REFERENCES `color` (`id_color`),
  CONSTRAINT `fk_prenda_talla` FOREIGN KEY (`id_talla`) REFERENCES `talla` (`id_talla`),
  CONSTRAINT `prenda_chk_1` CHECK ((`precio` > 0)),
  CONSTRAINT `prenda_chk_2` CHECK ((`stock_actual` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prenda`
--

LOCK TABLES `prenda` WRITE;
/*!40000 ALTER TABLE `prenda` DISABLE KEYS */;
INSERT INTO `prenda` VALUES (1,'Camisa Oxford Slim',450.00,25,1,2,3),(2,'Pantalón Jean Clásico',650.50,40,1,3,1),(3,'Vestido de Gala Rojo',1350.00,10,2,2,4),(4,'Playera Deportiva Pro',350.00,50,4,1,2),(5,'Sudadera Infantil Hoodie',400.00,15,3,2,5),(21,'Blusa Seda Elegante',550.00,15,2,1,2),(22,'Chaqueta Cuero Sintético',1200.00,8,1,3,1),(23,'Short Deportivo Runner',280.00,45,4,2,3),(25,'Jeans Skinny Fit Dama',750.00,22,2,2,3),(26,'Playera Básica Cuello V',190.00,60,1,2,2),(27,'Vestido Midi Estampado',890.00,12,2,3,4),(28,'Sudadera con Capucha Gris',500.00,18,1,3,5),(29,'Pijama Térmica Infantil',350.00,30,3,2,3),(30,'Gorra Deportiva Ajustable',250.00,25,5,3,1),(31,'Suéter Lana Merino',950.00,10,1,3,5),(32,'Falda Plisada Coreana',480.00,20,2,1,4),(33,'Conjunto Deportivo Yoga',720.00,15,4,2,1),(34,'Camiseta Manga Larga',320.00,45,3,3,2),(35,'Cinturón Cuero Café',300.00,25,5,3,5);
/*!40000 ALTER TABLE `prenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` char(10) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE KEY `telefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'Casimires y Trajes Lucerna','4499156551','Calle Francisco I. Madero 102 A, Aguascalientes'),(2,'Uniformes América','4494357284','Av. Convención 1914 Ote. 105-A, Aguascalientes'),(3,'La Charrita de Aguascalientes','4493110929','Calle Del Carmen 313, Aguascalientes'),(4,'Maquilas Textiles Arenas','4492994799','Paseo de la Explanada 145, Aguascalientes'),(5,'Fábrica de Tejido de Punto y Confecciones Ofelia S.A. de C.V.','4499730249','Av. Francisco I. Madero 810, Aguascalientes');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro` (
  `id_registro` int NOT NULL AUTO_INCREMENT,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_prenda` int NOT NULL,
  `id_empleado` int NOT NULL,
  `id_proveedor` int NOT NULL,
  PRIMARY KEY (`id_registro`),
  KEY `fk_reg_prenda` (`id_prenda`),
  KEY `fk_reg_emp` (`id_empleado`),
  KEY `fk_reg_prov` (`id_proveedor`),
  CONSTRAINT `fk_reg_emp` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  CONSTRAINT `fk_reg_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`),
  CONSTRAINT `fk_reg_prov` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro`
--

LOCK TABLES `registro` WRITE;
/*!40000 ALTER TABLE `registro` DISABLE KEYS */;
INSERT INTO `registro` VALUES (1,'2026-02-07 20:24:25',1,1,1),(2,'2026-02-07 20:24:25',2,4,2),(3,'2026-02-07 20:24:25',3,1,3),(4,'2026-02-07 20:24:25',4,4,4),(5,'2026-02-07 20:24:25',5,1,5);
/*!40000 ALTER TABLE `registro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talla`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `talla` (
  `id_talla` int NOT NULL AUTO_INCREMENT,
  `talla` varchar(10) NOT NULL,
  PRIMARY KEY (`id_talla`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talla`
--

LOCK TABLES `talla` WRITE;
/*!40000 ALTER TABLE `talla` DISABLE KEYS */;
INSERT INTO `talla` VALUES (1,'ch'),(2,'m'),(3,'g');
/*!40000 ALTER TABLE `talla` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-23 22:41:09
