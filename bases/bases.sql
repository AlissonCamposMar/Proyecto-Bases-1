-- MySQL dump 10.13  Distrib 9.1.0, for Linux (x86_64)
--
-- Host: localhost    Database: BDFP
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
-- Table structure for table `Administrador`
--

DROP TABLE IF EXISTS `Administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Administrador` (
  `id_Administrador` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de administradores',
  `nombreAdministrador` varchar(11) NOT NULL COMMENT 'Nombre del administrador del sistema',
  `claveAdministrador` varchar(11) NOT NULL COMMENT 'Clave del administrador del sistema',
  PRIMARY KEY (`id_Administrador`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Administrador`
--

LOCK TABLES `Administrador` WRITE;
/*!40000 ALTER TABLE `Administrador` DISABLE KEYS */;
INSERT INTO `Administrador` VALUES (1,'bases1','bases1');
/*!40000 ALTER TABLE `Administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Alergia`
--

DROP TABLE IF EXISTS `Alergia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Alergia` (
  `id_Alergia` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la alergia',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre de la alergia',
  PRIMARY KEY (`id_Alergia`),
  UNIQUE KEY `Alergia_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alergia`
--

LOCK TABLES `Alergia` WRITE;
/*!40000 ALTER TABLE `Alergia` DISABLE KEYS */;
INSERT INTO `Alergia` VALUES (1,'Ninguna');
/*!40000 ALTER TABLE `Alergia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Calificacion`
--

DROP TABLE IF EXISTS `Calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Calificacion` (
  `id_Calificacion` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de calificaciones de cita',
  `calificacion` int NOT NULL COMMENT 'Grado de calificación de la cita',
  `descripcion` varchar(125) NOT NULL COMMENT 'Descripción adicional de la cita',
  `id_Cita` int NOT NULL COMMENT 'Relación con la tabla de cita',
  PRIMARY KEY (`id_Calificacion`),
  KEY `Calificacion_Cita_FK` (`id_Cita`),
  CONSTRAINT `Calificacion_Cita_FK` FOREIGN KEY (`id_Cita`) REFERENCES `Cita` (`id_Cita`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calificacion`
--

LOCK TABLES `Calificacion` WRITE;
/*!40000 ALTER TABLE `Calificacion` DISABLE KEYS */;
INSERT INTO `Calificacion` VALUES (1,5,'Excelente servicio, me atendieron demasiado bien... Recomendados!!!',1);
/*!40000 ALTER TABLE `Calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cargo`
--

DROP TABLE IF EXISTS `Cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cargo` (
  `id_Cargo` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del cargo',
  `nombre` varchar(50) NOT NULL COMMENT 'Nombre del cargo',
  PRIMARY KEY (`id_Cargo`),
  UNIQUE KEY `Cargo_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cargo`
--

LOCK TABLES `Cargo` WRITE;
/*!40000 ALTER TABLE `Cargo` DISABLE KEYS */;
INSERT INTO `Cargo` VALUES (4,'Cirujano Plástico'),(1,'Dermatólogo'),(2,'Esteticista'),(3,'Recepcionista');
/*!40000 ALTER TABLE `Cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cita`
--

DROP TABLE IF EXISTS `Cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cita` (
  `id_Cita` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la cita',
  `fecha` datetime NOT NULL COMMENT 'Fecha de la programación de la cita',
  `duracion` time NOT NULL COMMENT 'Duración de la cita',
  `id_Cliente` int NOT NULL COMMENT 'Relación con la tabla de clientes',
  `id_Empleado` int NOT NULL COMMENT 'Relación con la tabla empleados',
  `id_Servicio` int NOT NULL COMMENT 'Relación con la tabla de productos',
  PRIMARY KEY (`id_Cita`),
  KEY `Cita_Empleado_FK` (`id_Empleado`),
  KEY `Cita_Cliente_FK` (`id_Cliente`),
  KEY `Cita_Producto_FK` (`id_Servicio`),
  CONSTRAINT `Cita_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `Cliente` (`id_Cliente`),
  CONSTRAINT `Cita_Empleado_FK` FOREIGN KEY (`id_Empleado`) REFERENCES `Empleado` (`id_Empleado`),
  CONSTRAINT `Cita_Producto_FK` FOREIGN KEY (`id_Servicio`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cita`
--

LOCK TABLES `Cita` WRITE;
/*!40000 ALTER TABLE `Cita` DISABLE KEYS */;
INSERT INTO `Cita` VALUES (1,'2024-11-20 00:00:00','02:00:00',1,1,6);
/*!40000 ALTER TABLE `Cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cliente`
--

DROP TABLE IF EXISTS `Cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cliente` (
  `id_Cliente` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de clientes',
  `nombre01` varchar(50) NOT NULL COMMENT 'Primer nombre del cliente',
  `nombre02` varchar(50) DEFAULT NULL COMMENT 'Segundo nombre del cliente',
  `apellido01` varchar(50) NOT NULL COMMENT 'Primer apellido del cliente',
  `apellido2` varchar(50) DEFAULT NULL COMMENT 'Segundo apellido del cliente',
  `fecha_nacimiento` date NOT NULL COMMENT 'Fecha de nacimiento del cliente',
  `residencia` varchar(50) NOT NULL COMMENT 'Residencia del cliente',
  PRIMARY KEY (`id_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cliente`
--

LOCK TABLES `Cliente` WRITE;
/*!40000 ALTER TABLE `Cliente` DISABLE KEYS */;
INSERT INTO `Cliente` VALUES (1,'Alisson',NULL,'Campos',NULL,'2001-11-10','Calle 14 # 20-31'),(2,'Santiago',NULL,'Trujillo','Patiño','2003-01-29','Calle 9 # 20-27'),(3,'Esteban',NULL,'Idarraga',NULL,'1999-11-15','Calle 2 # 14-06');
/*!40000 ALTER TABLE `Cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClienteAlergia`
--

DROP TABLE IF EXISTS `ClienteAlergia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ClienteAlergia` (
  `id_ClienteAlergia` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la relación entre clientes y alergias',
  `id_Cliente` int NOT NULL COMMENT 'Relación con la tabla cliente',
  `id_Alergia` int NOT NULL COMMENT 'Relación con la tabla alergia',
  PRIMARY KEY (`id_ClienteAlergia`),
  UNIQUE KEY `ClienteAlergia_UNIQUE` (`id_Cliente`,`id_Alergia`),
  KEY `ClienteAlergia_Alergia_FK` (`id_Alergia`),
  CONSTRAINT `ClienteAlergia_Alergia_FK` FOREIGN KEY (`id_Alergia`) REFERENCES `Alergia` (`id_Alergia`),
  CONSTRAINT `ClienteAlergia_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `Cliente` (`id_Cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClienteAlergia`
--

LOCK TABLES `ClienteAlergia` WRITE;
/*!40000 ALTER TABLE `ClienteAlergia` DISABLE KEYS */;
INSERT INTO `ClienteAlergia` VALUES (1,1,1),(2,2,1),(3,3,1);
/*!40000 ALTER TABLE `ClienteAlergia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ClienteEnfermedad`
--

DROP TABLE IF EXISTS `ClienteEnfermedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ClienteEnfermedad` (
  `id_ClienteEnfermedad` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la relación entre clientes y enfermedades',
  `id_Cliente` int NOT NULL COMMENT 'Relación con la tabla cliente',
  `id_Enfermedad` int NOT NULL COMMENT 'Relación con la tabla enfermedad',
  PRIMARY KEY (`id_ClienteEnfermedad`),
  UNIQUE KEY `ClienteEnfermedad_UNIQUE` (`id_Cliente`,`id_Enfermedad`),
  KEY `ClienteEnfermedad_Enfermedad_FK` (`id_Enfermedad`),
  CONSTRAINT `ClienteEnfermedad_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `Cliente` (`id_Cliente`),
  CONSTRAINT `ClienteEnfermedad_Enfermedad_FK` FOREIGN KEY (`id_Enfermedad`) REFERENCES `Enfermedad` (`id_Enfermedad`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ClienteEnfermedad`
--

LOCK TABLES `ClienteEnfermedad` WRITE;
/*!40000 ALTER TABLE `ClienteEnfermedad` DISABLE KEYS */;
INSERT INTO `ClienteEnfermedad` VALUES (1,1,2),(2,2,1),(3,3,1);
/*!40000 ALTER TABLE `ClienteEnfermedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Empleado`
--

DROP TABLE IF EXISTS `Empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Empleado` (
  `id_Empleado` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los empleados',
  `identificacion` varchar(10) NOT NULL COMMENT 'Identificación del empleado',
  `nombre01` varchar(50) NOT NULL COMMENT 'Primer nombre del empleado',
  `nombre02` varchar(50) DEFAULT NULL COMMENT 'Segundo nombre del empleado',
  `apellido01` varchar(50) NOT NULL COMMENT 'Primer nombre del empleado',
  `apellido02` varchar(50) DEFAULT NULL COMMENT 'Segundo nombre del empleado',
  `salario` float NOT NULL COMMENT 'Salario del empleado',
  `correo_electronico` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico del empleado',
  `id_Cargo` int NOT NULL COMMENT 'Relación con la tabla de cargos',
  `residencia` varchar(50) NOT NULL COMMENT 'Residencia del empleado',
  PRIMARY KEY (`id_Empleado`),
  KEY `Empleado_Cargo_FK` (`id_Cargo`),
  CONSTRAINT `Empleado_Cargo_FK` FOREIGN KEY (`id_Cargo`) REFERENCES `Cargo` (`id_Cargo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Empleado`
--

LOCK TABLES `Empleado` WRITE;
/*!40000 ALTER TABLE `Empleado` DISABLE KEYS */;
INSERT INTO `Empleado` VALUES (1,'1008444442','Juan','José','Cardona','Cortes',12000000,'juanj@email.com',1,'Calle 5 Mz 3 # 02');
/*!40000 ALTER TABLE `Empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Enfermedad`
--

DROP TABLE IF EXISTS `Enfermedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Enfermedad` (
  `id_Enfermedad` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de enfermedades',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre de la enfermedad',
  PRIMARY KEY (`id_Enfermedad`),
  UNIQUE KEY `Enfermeda_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Enfermedad`
--

LOCK TABLES `Enfermedad` WRITE;
/*!40000 ALTER TABLE `Enfermedad` DISABLE KEYS */;
INSERT INTO `Enfermedad` VALUES (1,'Ninguna'),(2,'Tiroides');
/*!40000 ALTER TABLE `Enfermedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacturaCompra`
--

DROP TABLE IF EXISTS `FacturaCompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FacturaCompra` (
  `id_FacturaCompra` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la factura',
  `fecha_compra` datetime NOT NULL COMMENT 'Fecha de compra de la factura',
  `total` decimal(10,2) NOT NULL COMMENT 'Valor total de la factura de compra',
  `id_FacturaCompra_Estado` int NOT NULL COMMENT 'Relación con la tabla de estados de factura de compra',
  `id_Proveedor` int NOT NULL COMMENT 'Relación con la tabla proveedores',
  PRIMARY KEY (`id_FacturaCompra`),
  KEY `FacturaCompra_Proveedor_FK` (`id_Proveedor`),
  KEY `FacturaCompra_FacturaCompra_Estado_FK` (`id_FacturaCompra_Estado`),
  CONSTRAINT `FacturaCompra_FacturaCompra_Estado_FK` FOREIGN KEY (`id_FacturaCompra_Estado`) REFERENCES `FacturaCompra_Estado` (`id_FacturaCompra_Estado`),
  CONSTRAINT `FacturaCompra_Proveedor_FK` FOREIGN KEY (`id_Proveedor`) REFERENCES `Proveedor` (`id_Proveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacturaCompra`
--

LOCK TABLES `FacturaCompra` WRITE;
/*!40000 ALTER TABLE `FacturaCompra` DISABLE KEYS */;
INSERT INTO `FacturaCompra` VALUES (1,'2024-10-10 00:00:00',250000.00,1,1);
/*!40000 ALTER TABLE `FacturaCompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacturaCompra_Detalle`
--

DROP TABLE IF EXISTS `FacturaCompra_Detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FacturaCompra_Detalle` (
  `id_FacturaCompra_Detalle` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta',
  `id_FacturaCompra` int NOT NULL COMMENT 'Relación con la tabla factura de venta',
  `id_Producto` int NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int NOT NULL COMMENT 'Cantidad de productos',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio unitario del producto o servicio',
  `sub_total` decimal(10,2) NOT NULL COMMENT 'Precio total del detalle',
  PRIMARY KEY (`id_FacturaCompra_Detalle`),
  KEY `FacturaVenta_Detalle_FacturaVenta_FK` (`id_FacturaCompra`) USING BTREE,
  KEY `FacturaVenta_Detalle_Producto_FK` (`id_Producto`) USING BTREE,
  CONSTRAINT `FacturaCompra_Detalle_FacturaCompra_FK` FOREIGN KEY (`id_FacturaCompra`) REFERENCES `FacturaCompra` (`id_FacturaCompra`),
  CONSTRAINT `FacturaCompra_Detalle_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacturaCompra_Detalle`
--

LOCK TABLES `FacturaCompra_Detalle` WRITE;
/*!40000 ALTER TABLE `FacturaCompra_Detalle` DISABLE KEYS */;
INSERT INTO `FacturaCompra_Detalle` VALUES (1,1,1,10,15000.00,150000.00),(2,1,2,10,10000.00,100000.00);
/*!40000 ALTER TABLE `FacturaCompra_Detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacturaCompra_Estado`
--

DROP TABLE IF EXISTS `FacturaCompra_Estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FacturaCompra_Estado` (
  `id_FacturaCompra_Estado` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del estado factura de compra',
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Nombre del estado',
  PRIMARY KEY (`id_FacturaCompra_Estado`),
  UNIQUE KEY `FacturaVenta_Estado_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacturaCompra_Estado`
--

LOCK TABLES `FacturaCompra_Estado` WRITE;
/*!40000 ALTER TABLE `FacturaCompra_Estado` DISABLE KEYS */;
INSERT INTO `FacturaCompra_Estado` VALUES (1,'Paga'),(2,'Pendiente');
/*!40000 ALTER TABLE `FacturaCompra_Estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacturaVenta`
--

DROP TABLE IF EXISTS `FacturaVenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FacturaVenta` (
  `id_FacturaVenta` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la factura',
  `fecha_venta` datetime NOT NULL COMMENT 'Fecha de venta de la factura',
  `total` decimal(10,2) NOT NULL COMMENT 'Valor total de la factura de venta',
  `id_FacturaVenta_Estado` int NOT NULL COMMENT 'Relación con la tabla de estados de factura de venta',
  `id_Cliente` int NOT NULL COMMENT 'Relación con la tabla cliente',
  PRIMARY KEY (`id_FacturaVenta`),
  KEY `FacturaVenta_Cliente_FK` (`id_Cliente`),
  CONSTRAINT `FacturaVenta_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `Cliente` (`id_Cliente`),
  CONSTRAINT `FacturaVenta_FacturaVenta_Estado_FK` FOREIGN KEY (`id_FacturaVenta`) REFERENCES `FacturaVenta_Estado` (`id_FacturaVenta_Estado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacturaVenta`
--

LOCK TABLES `FacturaVenta` WRITE;
/*!40000 ALTER TABLE `FacturaVenta` DISABLE KEYS */;
INSERT INTO `FacturaVenta` VALUES (1,'2024-11-15 23:21:06',60000.00,1,1);
/*!40000 ALTER TABLE `FacturaVenta` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `BI_FacturaVenta` BEFORE INSERT ON `FacturaVenta` FOR EACH ROW BEGIN
	SET NEW.fecha_venta = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `FacturaVenta_Detalle`
--

DROP TABLE IF EXISTS `FacturaVenta_Detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FacturaVenta_Detalle` (
  `id_FacturaVenta_Detalle` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta',
  `id_FacturaVenta` int NOT NULL COMMENT 'Relación con la tabla factura de venta',
  `id_Producto` int NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int NOT NULL COMMENT 'Cantidad de productos',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio unitario del producto o servicio',
  `sub_total` decimal(10,2) NOT NULL COMMENT 'Precio total del detalle',
  PRIMARY KEY (`id_FacturaVenta_Detalle`),
  KEY `FacturaVenta_Detalle_FacturaVenta_FK` (`id_FacturaVenta`),
  KEY `FacturaVenta_Detalle_Producto_FK` (`id_Producto`),
  CONSTRAINT `FacturaVenta_Detalle_FacturaVenta_FK` FOREIGN KEY (`id_FacturaVenta`) REFERENCES `FacturaVenta` (`id_FacturaVenta`),
  CONSTRAINT `FacturaVenta_Detalle_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacturaVenta_Detalle`
--

LOCK TABLES `FacturaVenta_Detalle` WRITE;
/*!40000 ALTER TABLE `FacturaVenta_Detalle` DISABLE KEYS */;
INSERT INTO `FacturaVenta_Detalle` VALUES (1,1,6,1,60000.00,60000.00);
/*!40000 ALTER TABLE `FacturaVenta_Detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FacturaVenta_Estado`
--

DROP TABLE IF EXISTS `FacturaVenta_Estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FacturaVenta_Estado` (
  `id_FacturaVenta_Estado` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del estado factura de venta',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del estado',
  PRIMARY KEY (`id_FacturaVenta_Estado`),
  UNIQUE KEY `FacturaVenta_Estado_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FacturaVenta_Estado`
--

LOCK TABLES `FacturaVenta_Estado` WRITE;
/*!40000 ALTER TABLE `FacturaVenta_Estado` DISABLE KEYS */;
INSERT INTO `FacturaVenta_Estado` VALUES (1,'Paga'),(2,'Pendiente');
/*!40000 ALTER TABLE `FacturaVenta_Estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventario`
--

DROP TABLE IF EXISTS `Inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventario` (
  `id_Inventario` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del inventario de producto',
  `id_Producto` int NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int NOT NULL COMMENT 'Cantidad del produco',
  `fecha_movimiento` datetime NOT NULL COMMENT 'Fecha de realización del movimiento',
  `id_Movimiento` int NOT NULL COMMENT 'Relación con la tabla Movimiento',
  `id_FacturaCompra_Detalle` int NOT NULL COMMENT 'Relación con el detalle de la factura de compra',
  PRIMARY KEY (`id_Inventario`),
  KEY `Inventario_Producto_FK` (`id_Producto`),
  KEY `Inventario_Movimiento_FK` (`id_Movimiento`),
  KEY `Inventario_FacturaCompra_Detalle_FK` (`id_FacturaCompra_Detalle`),
  CONSTRAINT `Inventario_FacturaCompra_Detalle_FK` FOREIGN KEY (`id_FacturaCompra_Detalle`) REFERENCES `FacturaCompra_Detalle` (`id_FacturaCompra_Detalle`),
  CONSTRAINT `Inventario_Movimiento_FK` FOREIGN KEY (`id_Movimiento`) REFERENCES `Movimiento` (`id_Movimiento`),
  CONSTRAINT `Inventario_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `Producto` (`id_Producto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventario`
--

LOCK TABLES `Inventario` WRITE;
/*!40000 ALTER TABLE `Inventario` DISABLE KEYS */;
INSERT INTO `Inventario` VALUES (1,1,10,'2024-11-15 23:17:47',1,1),(2,2,10,'2024-11-15 23:17:47',1,2);
/*!40000 ALTER TABLE `Inventario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `BI_INVENTARIO` BEFORE INSERT ON `Inventario` FOR EACH ROW BEGIN
	SET NEW.fecha_movimiento = NOW(); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Movimiento`
--

DROP TABLE IF EXISTS `Movimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Movimiento` (
  `id_Movimiento` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los tipos de movimiento',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del movimiento',
  PRIMARY KEY (`id_Movimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Movimiento`
--

LOCK TABLES `Movimiento` WRITE;
/*!40000 ALTER TABLE `Movimiento` DISABLE KEYS */;
INSERT INTO `Movimiento` VALUES (1,'Entrada'),(2,'Salida');
/*!40000 ALTER TABLE `Movimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pago`
--

DROP TABLE IF EXISTS `Pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pago` (
  `id_Pago` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de pago',
  `monto` decimal(10,2) NOT NULL COMMENT 'Monto del pago realizado a la factura',
  `fecha` date NOT NULL COMMENT 'Fecha de pago de la factura',
  `id_FacturaVenta` int NOT NULL COMMENT 'Relación la tabla de factura de venta',
  `id_Cliente` int NOT NULL COMMENT 'Relación de la tabla de cliente',
  PRIMARY KEY (`id_Pago`),
  KEY `Pago_Cliente_FK` (`id_Cliente`),
  KEY `Pago_FacturaVenta_FK` (`id_FacturaVenta`),
  CONSTRAINT `Pago_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `Cliente` (`id_Cliente`),
  CONSTRAINT `Pago_FacturaVenta_FK` FOREIGN KEY (`id_FacturaVenta`) REFERENCES `FacturaVenta` (`id_FacturaVenta`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pago`
--

LOCK TABLES `Pago` WRITE;
/*!40000 ALTER TABLE `Pago` DISABLE KEYS */;
INSERT INTO `Pago` VALUES (1,60000.00,'2024-11-15',1,1);
/*!40000 ALTER TABLE `Pago` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `BI_Pago` BEFORE INSERT ON `Pago` FOR EACH ROW BEGIN 
	SET NEW.fecha = NOW();
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Producto`
--

DROP TABLE IF EXISTS `Producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Producto` (
  `id_Producto` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de producto',
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Descripción del producto',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio del producto',
  `nombre` varchar(50) NOT NULL COMMENT 'Nombre del producto o servicio',
  `id_Producto_Tipo` int NOT NULL COMMENT 'Relación con la tabla tipos de producto',
  PRIMARY KEY (`id_Producto`),
  KEY `Producto_Producto_Tipo_FK` (`id_Producto_Tipo`),
  CONSTRAINT `Producto_Producto_Tipo_FK` FOREIGN KEY (`id_Producto_Tipo`) REFERENCES `Producto_Tipo` (`id_Producto_Tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto`
--

LOCK TABLES `Producto` WRITE;
/*!40000 ALTER TABLE `Producto` DISABLE KEYS */;
INSERT INTO `Producto` VALUES (1,'Pond\'s Crema Facial C Original 95g',18507.00,'POND\'S 95g',1),(2,'Shampoo Amatic Con Keratina 400 mL',12000.00,'BERHLAN',1),(3,'Un masaje que ayuda a reducir el estrés y relajar los músculos.',20000.00,'Masaje Relajante',2),(4,'Limpieza profunda de la piel con productos especializados.',30000.00,'Tratamiento Facial',2),(5,'Eliminación permanente del vello mediante láser.',35000.00,'Depilación Láser',2),(6,'Cuidado estético de las uñas de manos y pies.',60000.00,'Manicura y Pedicura',2);
/*!40000 ALTER TABLE `Producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Producto_Tipo`
--

DROP TABLE IF EXISTS `Producto_Tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Producto_Tipo` (
  `id_Producto_Tipo` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los tipo de producto',
  `tipo` varchar(100) NOT NULL COMMENT 'Tipo de producto',
  PRIMARY KEY (`id_Producto_Tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto_Tipo`
--

LOCK TABLES `Producto_Tipo` WRITE;
/*!40000 ALTER TABLE `Producto_Tipo` DISABLE KEYS */;
INSERT INTO `Producto_Tipo` VALUES (1,'Producto'),(2,'Servicio');
/*!40000 ALTER TABLE `Producto_Tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Proveedor`
--

DROP TABLE IF EXISTS `Proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Proveedor` (
  `id_Proveedor` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de proveedor',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del proveedor',
  `identificacion` varchar(10) NOT NULL COMMENT 'Número de identificación del proveedor',
  PRIMARY KEY (`id_Proveedor`),
  UNIQUE KEY `Proveedor_UNIQUE` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proveedor`
--

LOCK TABLES `Proveedor` WRITE;
/*!40000 ALTER TABLE `Proveedor` DISABLE KEYS */;
INSERT INTO `Proveedor` VALUES (1,'Mercado Libre','900880401');
/*!40000 ALTER TABLE `Proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Telefono`
--

DROP TABLE IF EXISTS `Telefono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Telefono` (
  `id_Telefono` int NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la tabla telefonos',
  `numero` varchar(15) NOT NULL COMMENT 'Número telefonico de la persona',
  `id_Empleado` int DEFAULT NULL COMMENT 'Relación con la tabla empleado',
  `id_Cliente` int DEFAULT NULL COMMENT 'Relación con la tabla cliente',
  PRIMARY KEY (`id_Telefono`),
  KEY `Telefono_Empleado_FK` (`id_Empleado`),
  KEY `Telefono_Cliente_FK` (`id_Cliente`),
  CONSTRAINT `Telefono_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `Cliente` (`id_Cliente`),
  CONSTRAINT `Telefono_Empleado_FK` FOREIGN KEY (`id_Empleado`) REFERENCES `Empleado` (`id_Empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Telefono`
--

LOCK TABLES `Telefono` WRITE;
/*!40000 ALTER TABLE `Telefono` DISABLE KEYS */;
INSERT INTO `Telefono` VALUES (1,'3107228050',NULL,1);
/*!40000 ALTER TABLE `Telefono` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-16  0:05:53
