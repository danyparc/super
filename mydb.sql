-- MySQL dump 10.13  Distrib 5.5.49, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.49-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Depto`
--

DROP TABLE IF EXISTS `Depto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Depto` (
  `idDepto` char(2) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `sucursal_idSucursal` int(3) NOT NULL,
  PRIMARY KEY (`idDepto`),
  KEY `fk_Depto_sucursal1_idx` (`sucursal_idSucursal`),
  CONSTRAINT `fk_Depto_sucursal1` FOREIGN KEY (`sucursal_idSucursal`) REFERENCES `sucursal` (`idSucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Depto`
--

LOCK TABLES `Depto` WRITE;
/*!40000 ALTER TABLE `Depto` DISABLE KEYS */;
INSERT INTO `Depto` VALUES ('AB','ABARROTES',1);
/*!40000 ALTER TABLE `Depto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo` (
  `idArticulo` int(11) NOT NULL,
  `nombre` varchar(70) NOT NULL,
  `precioUnitario` double NOT NULL,
  `Depto_idDepto` char(2) NOT NULL,
  PRIMARY KEY (`idArticulo`),
  KEY `fk_articulo_Depto1_idx` (`Depto_idDepto`),
  CONSTRAINT `fk_articulo_Depto1` FOREIGN KEY (`Depto_idDepto`) REFERENCES `Depto` (`idDepto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (1,'Leche',15.5,'AB');
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulo_has_ticket`
--

DROP TABLE IF EXISTS `articulo_has_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo_has_ticket` (
  `articulo_idArticulo` int(11) NOT NULL,
  `ticket_idTicket` int(11) NOT NULL,
  `cantidad_art` int(11) NOT NULL,
  `subtotal` double NOT NULL,
  PRIMARY KEY (`articulo_idArticulo`,`ticket_idTicket`),
  KEY `fk_articulo_has_ticket_ticket1_idx` (`ticket_idTicket`),
  KEY `fk_articulo_has_ticket_articulo1_idx` (`articulo_idArticulo`),
  CONSTRAINT `fk_articulo_has_ticket_articulo1` FOREIGN KEY (`articulo_idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_has_ticket_ticket1` FOREIGN KEY (`ticket_idTicket`) REFERENCES `ticket` (`idTicket`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo_has_ticket`
--

LOCK TABLES `articulo_has_ticket` WRITE;
/*!40000 ALTER TABLE `articulo_has_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `articulo_has_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cajero`
--

DROP TABLE IF EXISTS `cajero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajero` (
  `rfc` char(13) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `num_caja` int(2) NOT NULL,
  `sucursal_idSucursal` int(3) NOT NULL,
  PRIMARY KEY (`rfc`),
  KEY `fk_cajero_sucursal1_idx` (`sucursal_idSucursal`),
  CONSTRAINT `fk_cajero_sucursal1` FOREIGN KEY (`sucursal_idSucursal`) REFERENCES `sucursal` (`idSucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajero`
--

LOCK TABLES `cajero` WRITE;
/*!40000 ALTER TABLE `cajero` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compania`
--

DROP TABLE IF EXISTS `compania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compania` (
  `rfc` char(12) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `logo` varchar(150) NOT NULL,
  `slogan` varchar(100) NOT NULL,
  `domicilio_fis` varchar(200) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `www` varchar(100) NOT NULL,
  PRIMARY KEY (`rfc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compania`
--

LOCK TABLES `compania` WRITE;
/*!40000 ALTER TABLE `compania` DISABLE KEYS */;
INSERT INTO `compania` VALUES ('CRNLMRT2319X','CARNAL MART','/static/img/cmart.jpeg','Precios bajos carnal!','Jardines de Morelos calle venus #33, Ecatepec de Morelos, Edo. Mex.','5554498963','aiuda@carnalmart.com','www.carnalmart.com');
/*!40000 ALTER TABLE `compania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descuento`
--

DROP TABLE IF EXISTS `descuento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `descuento` (
  `idDescuento` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `porcentaje` double NOT NULL,
  PRIMARY KEY (`idDescuento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descuento`
--

LOCK TABLES `descuento` WRITE;
/*!40000 ALTER TABLE `descuento` DISABLE KEYS */;
/*!40000 ALTER TABLE `descuento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `descuento_has_articulo`
--

DROP TABLE IF EXISTS `descuento_has_articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `descuento_has_articulo` (
  `descuento_idDescuento` int(11) NOT NULL,
  `articulo_idArticulo` int(11) NOT NULL,
  `porcentaje` double NOT NULL,
  PRIMARY KEY (`descuento_idDescuento`,`articulo_idArticulo`),
  KEY `fk_descuento_has_articulo_articulo1_idx` (`articulo_idArticulo`),
  KEY `fk_descuento_has_articulo_descuento1_idx` (`descuento_idDescuento`),
  CONSTRAINT `fk_descuento_has_articulo_articulo1` FOREIGN KEY (`articulo_idArticulo`) REFERENCES `articulo` (`idArticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_descuento_has_articulo_descuento1` FOREIGN KEY (`descuento_idDescuento`) REFERENCES `descuento` (`idDescuento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `descuento_has_articulo`
--

LOCK TABLES `descuento_has_articulo` WRITE;
/*!40000 ALTER TABLE `descuento_has_articulo` DISABLE KEYS */;
/*!40000 ALTER TABLE `descuento_has_articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `idEstado` int(4) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'CDMX');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodoPago`
--

DROP TABLE IF EXISTS `metodoPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metodoPago` (
  `idmetodoPago` int(11) NOT NULL,
  `banco` varchar(45) DEFAULT NULL,
  `num_tarjeta` varchar(16) DEFAULT NULL,
  `cvv` int(3) DEFAULT NULL,
  PRIMARY KEY (`idmetodoPago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodoPago`
--

LOCK TABLES `metodoPago` WRITE;
/*!40000 ALTER TABLE `metodoPago` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodoPago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursal`
--

DROP TABLE IF EXISTS `sucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sucursal` (
  `idSucursal` int(3) NOT NULL,
  `rfc` varchar(12) NOT NULL,
  `domicilio_fis` varchar(200) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `compania_rfc` char(12) NOT NULL,
  `estado_idEstado` int(4) NOT NULL,
  PRIMARY KEY (`idSucursal`),
  KEY `fk_sucursal_compania_idx` (`compania_rfc`),
  KEY `fk_sucursal_estado1_idx` (`estado_idEstado`),
  CONSTRAINT `fk_sucursal_compania` FOREIGN KEY (`compania_rfc`) REFERENCES `compania` (`rfc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_estado1` FOREIGN KEY (`estado_idEstado`) REFERENCES `estado` (`idEstado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursal`
--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */;
INSERT INTO `sucursal` VALUES (1,'CRNL85699812','COL. LINDAVISTA  #23 DEL. GUSTAVO A. MADERO','5526777381','CRNLMRT2319X',1);
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `idTicket` int(11) NOT NULL,
  `fecha` varchar(10) NOT NULL,
  `hora` varchar(5) NOT NULL,
  `impuesto` double NOT NULL,
  `montototal` double NOT NULL,
  `cambio` double NOT NULL,
  `sucursal_idSucursal` int(3) NOT NULL,
  PRIMARY KEY (`idTicket`),
  KEY `fk_ticket_sucursal1_idx` (`sucursal_idSucursal`),
  CONSTRAINT `fk_ticket_sucursal1` FOREIGN KEY (`sucursal_idSucursal`) REFERENCES `sucursal` (`idSucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_has_metodoPago`
--

DROP TABLE IF EXISTS `ticket_has_metodoPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_has_metodoPago` (
  `ticket_idTicket` int(11) NOT NULL,
  `metodoPago_idmetodoPago` int(11) NOT NULL,
  PRIMARY KEY (`ticket_idTicket`,`metodoPago_idmetodoPago`),
  KEY `fk_ticket_has_metodoPago_metodoPago1_idx` (`metodoPago_idmetodoPago`),
  KEY `fk_ticket_has_metodoPago_ticket1_idx` (`ticket_idTicket`),
  CONSTRAINT `fk_ticket_has_metodoPago_metodoPago1` FOREIGN KEY (`metodoPago_idmetodoPago`) REFERENCES `metodoPago` (`idmetodoPago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_has_metodoPago_ticket1` FOREIGN KEY (`ticket_idTicket`) REFERENCES `ticket` (`idTicket`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_has_metodoPago`
--

LOCK TABLES `ticket_has_metodoPago` WRITE;
/*!40000 ALTER TABLE `ticket_has_metodoPago` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_has_metodoPago` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-30 21:03:43
