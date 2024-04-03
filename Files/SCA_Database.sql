CREATE DATABASE  IF NOT EXISTS `sca_database` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sca_database`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sca_database
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `credits`
--

DROP TABLE IF EXISTS `credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credits` (
  `idCredito` int NOT NULL AUTO_INCREMENT,
  `idUser` varchar(255) DEFAULT NULL,
  `semestre` int DEFAULT NULL,
  `creditosAcademicos` int DEFAULT '0',
  `creditosExtraescolares` int DEFAULT '0',
  PRIMARY KEY (`idCredito`),
  KEY `idUser` (`idUser`),
  KEY `fk_semestre_credito` (`semestre`),
  CONSTRAINT `credits_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`),
  CONSTRAINT `fk_semestre_credito` FOREIGN KEY (`semestre`) REFERENCES `semester` (`idSemestre`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credits`
--

LOCK TABLES `credits` WRITE;
/*!40000 ALTER TABLE `credits` DISABLE KEYS */;
INSERT INTO `credits` VALUES (1,'anatorres',5,24,10),(2,'Block',6,28,8),(3,'carlasmith',5,25,6),(4,'carlosramirez',7,30,12),(5,'danielruiz',5,23,5),(6,'eduardogarcia',4,20,10),(7,'javiermartinez',7,28,9),(8,'juanperez',6,26,7),(9,'juliamartinez',7,29,8),(10,'lauragonzalez',4,22,6),(11,'admin',1,7,6),(12,'ajohnson',4,5,2),(13,'amiller',3,7,8),(14,'anatorres',5,3,1),(15,'asanchez',2,14,9),(16,'awhite',2,5,0),(17,'Block',6,19,1),(18,'carlasmith',5,22,3),(19,'carlosramirez',7,6,2),(20,'charris',4,15,8),(21,'danielruiz',5,12,6),(22,'dmartinez',3,30,0),(23,'ebrown',1,7,1),(24,'eduardogarcia',4,21,3),(25,'ejones',4,13,2),(26,'existinguser',4,17,4),(27,'imoore',2,3,4),(28,'javiermartinez',7,22,5),(29,'jjackson',4,6,5),(30,'jlee',4,0,5),(31,'jlloyd',1,16,2),(32,'jmartinez',2,7,6),(33,'jsmith',2,12,1),(34,'juanperez',6,10,4),(35,'juliamartinez',7,25,1),(36,'klloyd',3,3,1),(37,'lauragonzalez',4,3,2),(38,'lrodriguez',1,25,6),(39,'luciamartinez',7,10,9),(40,'luisfernandez',4,12,4),(41,'manderson',4,22,5),(42,'mariagomez',5,7,7),(43,'McBlockier',6,24,9),(44,'mhall',3,2,6),(45,'mjackson',3,0,2),(46,'mjohnson',3,23,3),(47,'monicagonzalez',6,7,3),(48,'mwilliams',3,17,1),(49,'nataliacastro',6,20,1),(50,'newuser',6,10,5),(51,'oscarrodriguez',5,13,6),(52,'owilson',3,28,8),(53,'patriciadiaz',6,1,8),(54,'pedrolopez',6,30,5),(55,'raullopez',4,20,7),(56,'rjohnson',1,14,2),(57,'rjones',4,25,4),(58,'rsmith',4,16,5),(59,'sergiohernandez',4,30,4),(60,'srodriguez',1,30,8),(61,'staylor',2,26,10),(62,'tlee',2,11,9),(63,'tthomas',2,12,3),(64,'valerialopez',6,5,0),(65,'wthompson',1,18,9);
/*!40000 ALTER TABLE `credits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `estudiantesporsemestre`
--

DROP TABLE IF EXISTS `estudiantesporsemestre`;
/*!50001 DROP VIEW IF EXISTS `estudiantesporsemestre`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `estudiantesporsemestre` AS SELECT 
 1 AS `semester`,
 1 AS `cantidad_estudiantes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `estudiantesregulares`
--

DROP TABLE IF EXISTS `estudiantesregulares`;
/*!50001 DROP VIEW IF EXISTS `estudiantesregulares`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `estudiantesregulares` AS SELECT 
 1 AS `idUser`,
 1 AS `password`,
 1 AS `name`,
 1 AS `lastName`,
 1 AS `nControl`,
 1 AS `rankId`,
 1 AS `semester`,
 1 AS `regular`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `grade_report`
--

DROP TABLE IF EXISTS `grade_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade_report` (
  `idBoleta` int NOT NULL AUTO_INCREMENT,
  `idUser` varchar(255) DEFAULT NULL,
  `idAsignatura` int DEFAULT NULL,
  `semestre` int DEFAULT NULL,
  `calificacion` decimal(5,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idBoleta`),
  KEY `idUser` (`idUser`),
  KEY `idAsignatura` (`idAsignatura`),
  CONSTRAINT `grade_report_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`),
  CONSTRAINT `grade_report_ibfk_2` FOREIGN KEY (`idAsignatura`) REFERENCES `subjects` (`idAsignatura`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade_report`
--

LOCK TABLES `grade_report` WRITE;
/*!40000 ALTER TABLE `grade_report` DISABLE KEYS */;
INSERT INTO `grade_report` VALUES (1,'anatorres',1,1,1.57,'2023-12-31'),(2,'Block',1,1,47.10,'2023-12-31'),(3,'carlasmith',1,1,30.75,'2023-12-31'),(4,'carlosramirez',1,1,12.48,'2023-12-31'),(5,'danielruiz',1,1,70.13,'2023-12-31'),(6,'eduardogarcia',1,1,13.20,'2023-12-31'),(7,'existinguser',1,1,55.61,'2023-12-31'),(8,'javiermartinez',1,1,38.45,'2023-12-31'),(9,'juanperez',1,1,25.45,'2023-12-31'),(10,'juliamartinez',1,1,11.87,'2023-12-31');
/*!40000 ALTER TABLE `grade_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graduation`
--

DROP TABLE IF EXISTS `graduation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `graduation` (
  `idTitulacion` int NOT NULL AUTO_INCREMENT,
  `idUser` varchar(255) DEFAULT NULL,
  `tipoTitulacion` varchar(255) DEFAULT NULL,
  `fechaInicio` date DEFAULT NULL,
  `fechaFinalizacion` date DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idTitulacion`),
  KEY `idUser` (`idUser`),
  CONSTRAINT `graduation_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graduation`
--

LOCK TABLES `graduation` WRITE;
/*!40000 ALTER TABLE `graduation` DISABLE KEYS */;
INSERT INTO `graduation` VALUES (1,'anatorres','Tesis','2024-01-01','2024-12-31','En proceso'),(2,'Block','Tesis','2024-01-01','2024-12-31','En proceso'),(3,'carlasmith','Tesis','2024-01-01','2024-12-31','En proceso'),(4,'carlosramirez','Tesis','2024-01-01','2024-12-31','En proceso'),(5,'danielruiz','Tesis','2024-01-01','2024-12-31','En proceso'),(6,'eduardogarcia','Tesis','2024-01-01','2024-12-31','En proceso'),(7,'existinguser','Tesis','2024-01-01','2024-12-31','En proceso'),(8,'javiermartinez','Tesis','2024-01-01','2024-12-31','En proceso'),(9,'juanperez','Tesis','2024-01-01','2024-12-31','En proceso'),(10,'juliamartinez','Tesis','2024-01-01','2024-12-31','En proceso');
/*!40000 ALTER TABLE `graduation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `idPago` int NOT NULL AUTO_INCREMENT,
  `idUser` varchar(255) DEFAULT NULL,
  `tipoPago` varchar(255) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fechaPago` date DEFAULT NULL,
  PRIMARY KEY (`idPago`),
  KEY `idUser` (`idUser`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'anatorres','Inscripción',1660.21,'2024-01-01'),(2,'Block','Inscripción',1588.85,'2024-01-01'),(3,'carlasmith','Inscripción',963.59,'2024-01-01'),(4,'carlosramirez','Inscripción',51.43,'2024-01-01'),(5,'danielruiz','Inscripción',1366.35,'2024-01-01'),(6,'eduardogarcia','Inscripción',677.49,'2024-01-01'),(7,'existinguser','Inscripción',1288.39,'2024-01-01'),(8,'javiermartinez','Inscripción',409.50,'2024-01-01'),(9,'juanperez','Inscripción',182.30,'2024-01-01'),(10,'juliamartinez','Inscripción',1683.02,'2024-01-01'),(11,'admin','Cuota mensual',831.58,'2024-03-16'),(12,'ajohnson','Cuota mensual',611.88,'2023-06-15'),(13,'jjackson','Matrícula',497.53,'2023-04-25'),(14,'jlee','Matrícula',282.04,'2023-07-07'),(15,'jmartinez','Cuota mensual',129.48,'2024-03-23'),(16,'jsmith','Cuota mensual',743.43,'2023-11-04'),(17,'mjackson','Cuota mensual',978.80,'2023-11-24'),(18,'owilson','Cuota mensual',231.09,'2023-09-08'),(19,'rjohnson','Matrícula',60.02,'2023-06-02'),(20,'rjones','Matrícula',561.76,'2023-06-30'),(21,'srodriguez','Matrícula',320.18,'2024-01-07'),(22,'staylor','Matrícula',447.05,'2023-09-20'),(23,'tlee','Matrícula',119.48,'2023-09-12'),(24,'tthomas','Matrícula',487.56,'2024-02-12'),(25,'amiller','Matrícula',779.36,'2024-01-30'),(26,'anatorres','Cuota mensual',184.60,'2023-12-17'),(27,'awhite','Cuota mensual',725.25,'2023-05-25'),(28,'Block','Matrícula',35.91,'2023-06-12'),(29,'carlasmith','Cuota mensual',291.13,'2023-08-20'),(30,'carlosramirez','Matrícula',320.80,'2023-05-14'),(31,'charris','Matrícula',803.25,'2023-09-23'),(32,'danielruiz','Matrícula',598.35,'2023-12-23'),(33,'dmartinez','Cuota mensual',180.60,'2024-03-01'),(34,'ebrown','Cuota mensual',292.40,'2023-07-14'),(35,'eduardogarcia','Cuota mensual',515.63,'2023-11-21'),(36,'existinguser','Matrícula',355.56,'2023-05-10'),(37,'javiermartinez','Matrícula',522.58,'2023-12-25'),(38,'juanperez','Cuota mensual',206.26,'2023-08-23'),(39,'juliamartinez','Matrícula',391.50,'2023-08-21'),(40,'lauragonzalez','Cuota mensual',751.10,'2023-04-08'),(41,'lrodriguez','Cuota mensual',517.33,'2023-10-06'),(42,'luciamartinez','Cuota mensual',106.84,'2023-06-23'),(43,'luisfernandez','Cuota mensual',579.32,'2024-02-11'),(44,'mariagomez','Cuota mensual',461.16,'2023-11-19'),(45,'McBlockier','Matrícula',251.38,'2023-06-02'),(46,'mhall','Matrícula',659.13,'2023-04-07'),(47,'monicagonzalez','Cuota mensual',942.79,'2023-06-30'),(48,'nataliacastro','Cuota mensual',626.86,'2024-01-26'),(49,'newuser','Matrícula',693.53,'2023-12-10'),(50,'oscarrodriguez','Cuota mensual',557.40,'2023-12-22'),(51,'patriciadiaz','Cuota mensual',866.69,'2024-02-25'),(52,'pedrolopez','Cuota mensual',285.71,'2023-08-02'),(53,'raullopez','Matrícula',456.21,'2023-06-16'),(54,'rsmith','Cuota mensual',782.27,'2023-04-04'),(55,'sergiohernandez','Cuota mensual',264.08,'2023-11-23'),(56,'valerialopez','Matrícula',5.41,'2023-04-14'),(57,'wthompson','Cuota mensual',302.51,'2023-04-11'),(58,'asanchez','Cuota mensual',55.01,'2023-12-24'),(59,'ejones','Matrícula',232.72,'2023-09-23'),(60,'imoore','Cuota mensual',132.52,'2023-06-04'),(61,'jlloyd','Cuota mensual',317.95,'2023-12-15'),(62,'klloyd','Cuota mensual',858.30,'2023-08-15'),(63,'manderson','Cuota mensual',79.53,'2023-08-25'),(64,'mjohnson','Cuota mensual',188.38,'2023-09-21'),(65,'mwilliams','Matrícula',923.35,'2023-12-15');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professional_license`
--

DROP TABLE IF EXISTS `professional_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professional_license` (
  `idCedula` int NOT NULL AUTO_INCREMENT,
  `idUser` varchar(255) DEFAULT NULL,
  `numeroCedula` varchar(255) DEFAULT NULL,
  `fechaExpedicion` date DEFAULT NULL,
  `autoridad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idCedula`),
  KEY `idUser` (`idUser`),
  CONSTRAINT `professional_license_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professional_license`
--

LOCK TABLES `professional_license` WRITE;
/*!40000 ALTER TABLE `professional_license` DISABLE KEYS */;
INSERT INTO `professional_license` VALUES (1,'anatorres','CEDanatorres','2025-01-01','SEP'),(2,'Block','CEDBlock','2025-01-01','SEP'),(3,'carlasmith','CEDcarlasmith','2025-01-01','SEP'),(4,'carlosramirez','CEDcarlosramirez','2025-01-01','SEP'),(5,'danielruiz','CEDdanielruiz','2025-01-01','SEP'),(6,'eduardogarcia','CEDeduardogarcia','2025-01-01','SEP'),(7,'existinguser','CEDexistinguser','2025-01-01','SEP'),(8,'javiermartinez','CEDjaviermartinez','2025-01-01','SEP'),(9,'juanperez','CEDjuanperez','2025-01-01','SEP'),(10,'juliamartinez','CEDjuliamartinez','2025-01-01','SEP'),(11,'admin','C73723','2000-10-25','Colegio Profesional'),(12,'ajohnson','C14076','2005-11-26','Colegio Profesional'),(13,'jjackson','C35594','1998-05-06','Ministerio de Educación'),(14,'jlee','C67504','2005-10-31','Ministerio de Educación'),(15,'jmartinez','C39323','1999-07-20','Colegio Profesional'),(16,'jsmith','C23239','2014-02-02','Colegio Profesional'),(17,'mjackson','C97465','1997-12-06','Ministerio de Educación'),(18,'owilson','C69736','2021-08-14','Ministerio de Educación'),(19,'rjohnson','C47353','2014-07-03','Ministerio de Educación'),(20,'rjones','C05391','2004-09-19','Ministerio de Educación'),(21,'srodriguez','C52782','2013-10-12','Ministerio de Educación'),(22,'staylor','C77017','2013-06-20','Ministerio de Educación'),(23,'tlee','C36287','2013-10-16','Colegio Profesional'),(24,'tthomas','C23509','2018-01-27','Ministerio de Educación'),(25,'amiller','C01026','2022-01-14','Ministerio de Educación'),(26,'anatorres','C47365','2013-09-26','Ministerio de Educación'),(27,'awhite','C61506','2022-01-07','Colegio Profesional'),(28,'Block','C41634','2009-05-04','Ministerio de Educación'),(29,'carlasmith','C70076','2000-08-21','Colegio Profesional'),(30,'carlosramirez','C81964','2006-08-12','Ministerio de Educación'),(31,'charris','C65115','2000-02-04','Ministerio de Educación'),(32,'danielruiz','C96222','2006-10-09','Ministerio de Educación'),(33,'dmartinez','C39641','1997-06-09','Ministerio de Educación'),(34,'ebrown','C73290','1999-10-31','Colegio Profesional'),(35,'eduardogarcia','C92906','2023-08-12','Ministerio de Educación'),(36,'existinguser','C53670','2002-08-02','Ministerio de Educación'),(37,'javiermartinez','C85174','2016-11-11','Colegio Profesional'),(38,'juanperez','C64865','2017-12-14','Ministerio de Educación'),(39,'juliamartinez','C89527','2019-06-08','Ministerio de Educación'),(40,'lauragonzalez','C10842','2018-08-19','Colegio Profesional'),(41,'lrodriguez','C50133','2004-03-23','Colegio Profesional'),(42,'luciamartinez','C17962','2012-08-19','Ministerio de Educación'),(43,'luisfernandez','C83383','1995-02-21','Ministerio de Educación'),(44,'mariagomez','C85679','2017-08-08','Colegio Profesional'),(45,'McBlockier','C02987','2008-04-21','Colegio Profesional'),(46,'mhall','C25636','2007-02-27','Ministerio de Educación'),(47,'monicagonzalez','C70248','2016-05-01','Ministerio de Educación'),(48,'nataliacastro','C27707','2001-12-20','Colegio Profesional'),(49,'newuser','C19866','2014-03-08','Ministerio de Educación'),(50,'oscarrodriguez','C41235','1999-12-27','Colegio Profesional'),(51,'patriciadiaz','C62423','2003-08-02','Colegio Profesional'),(52,'pedrolopez','C80496','2015-03-28','Ministerio de Educación'),(53,'raullopez','C54315','2010-10-24','Colegio Profesional'),(54,'rsmith','C71817','2001-09-08','Colegio Profesional'),(55,'sergiohernandez','C78865','2020-10-21','Ministerio de Educación'),(56,'valerialopez','C70142','1997-11-24','Ministerio de Educación'),(57,'wthompson','C82071','2017-05-27','Colegio Profesional'),(58,'asanchez','C71836','2007-10-15','Colegio Profesional'),(59,'ejones','C30984','2001-01-13','Colegio Profesional'),(60,'imoore','C39211','2020-04-28','Ministerio de Educación'),(61,'jlloyd','C00365','2006-11-13','Colegio Profesional'),(62,'klloyd','C70498','1998-07-14','Ministerio de Educación'),(63,'manderson','C30036','1994-12-16','Colegio Profesional'),(64,'mjohnson','C99426','2023-10-14','Ministerio de Educación'),(65,'mwilliams','C43120','1998-03-15','Ministerio de Educación'),(74,'admin','C65103','2021-04-01','Colegio Profesional'),(75,'ajohnson','C44068','2007-07-06','Ministerio de Educación'),(76,'jjackson','C67693','1995-01-29','Colegio Profesional'),(77,'jlee','C25633','2000-12-27','Ministerio de Educación'),(78,'jmartinez','C22928','1999-12-01','Ministerio de Educación'),(79,'jsmith','C42179','1994-06-10','Colegio Profesional'),(80,'mjackson','C55295','2004-12-25','Colegio Profesional'),(81,'owilson','C84773','2007-01-29','Ministerio de Educación'),(82,'rjohnson','C88933','2009-10-24','Colegio Profesional'),(83,'rjones','C25751','2022-04-11','Colegio Profesional'),(84,'srodriguez','C58966','2015-12-28','Colegio Profesional'),(85,'staylor','C21982','2016-02-17','Colegio Profesional'),(86,'tlee','C66493','2017-02-14','Ministerio de Educación'),(87,'tthomas','C25951','2002-11-10','Colegio Profesional'),(88,'amiller','C80836','2004-02-08','Colegio Profesional'),(89,'anatorres','C66203','2009-03-04','Colegio Profesional'),(90,'awhite','C13692','2021-05-07','Ministerio de Educación'),(91,'Block','C07901','2019-01-24','Colegio Profesional'),(92,'carlasmith','C62395','2017-04-01','Ministerio de Educación'),(93,'carlosramirez','C78279','2023-07-20','Colegio Profesional'),(94,'charris','C77696','2006-12-25','Colegio Profesional'),(95,'danielruiz','C02151','2010-07-16','Ministerio de Educación'),(96,'dmartinez','C74296','2022-11-22','Colegio Profesional'),(97,'ebrown','C85641','2015-09-03','Colegio Profesional'),(98,'eduardogarcia','C45330','2003-11-24','Ministerio de Educación'),(99,'existinguser','C14126','2006-04-18','Colegio Profesional'),(100,'javiermartinez','C06173','2006-06-21','Colegio Profesional'),(101,'juanperez','C12463','2015-11-04','Ministerio de Educación'),(102,'juliamartinez','C30429','2011-04-02','Ministerio de Educación'),(103,'lauragonzalez','C97838','2020-07-14','Colegio Profesional'),(104,'lrodriguez','C05450','2017-10-07','Colegio Profesional'),(105,'luciamartinez','C94378','1995-05-20','Colegio Profesional'),(106,'luisfernandez','C03114','2018-02-26','Colegio Profesional'),(107,'mariagomez','C00946','2016-01-01','Ministerio de Educación'),(108,'McBlockier','C91639','2008-03-04','Colegio Profesional'),(109,'mhall','C05569','2009-11-18','Ministerio de Educación'),(110,'monicagonzalez','C71321','1998-01-08','Ministerio de Educación'),(111,'nataliacastro','C55361','2022-06-08','Colegio Profesional'),(112,'newuser','C03234','2017-04-09','Ministerio de Educación'),(113,'oscarrodriguez','C64023','1994-05-07','Ministerio de Educación'),(114,'patriciadiaz','C34516','2008-07-30','Colegio Profesional'),(115,'pedrolopez','C32723','1997-04-26','Colegio Profesional'),(116,'raullopez','C85963','2001-04-27','Ministerio de Educación'),(117,'rsmith','C93550','1996-02-06','Colegio Profesional'),(118,'sergiohernandez','C63006','2009-10-24','Colegio Profesional'),(119,'valerialopez','C14699','2018-11-14','Ministerio de Educación'),(120,'wthompson','C74788','2013-03-30','Colegio Profesional'),(121,'asanchez','C86206','2008-04-22','Ministerio de Educación'),(122,'ejones','C77251','2005-01-08','Colegio Profesional'),(123,'imoore','C52571','1995-07-10','Ministerio de Educación'),(124,'jlloyd','C19949','2013-09-07','Ministerio de Educación'),(125,'klloyd','C76482','2014-05-07','Ministerio de Educación'),(126,'manderson','C79949','1996-08-03','Ministerio de Educación'),(127,'mjohnson','C30943','1997-04-05','Colegio Profesional'),(128,'mwilliams','C16833','2020-08-29','Ministerio de Educación');
/*!40000 ALTER TABLE `professional_license` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rankuser`
--

DROP TABLE IF EXISTS `rankuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rankuser` (
  `type` varchar(255) NOT NULL,
  `id` int DEFAULT NULL,
  PRIMARY KEY (`type`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rankuser`
--

LOCK TABLES `rankuser` WRITE;
/*!40000 ALTER TABLE `rankuser` DISABLE KEYS */;
INSERT INTO `rankuser` VALUES ('Administrador',1),('Alumno',2),('Docente',3),('Jefe de carrera',4);
/*!40000 ALTER TABLE `rankuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reinscripcion`
--

DROP TABLE IF EXISTS `reinscripcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reinscripcion` (
  `idReinscripcion` int NOT NULL AUTO_INCREMENT,
  `idUser` varchar(255) DEFAULT NULL,
  `semestre` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idReinscripcion`),
  KEY `idUser` (`idUser`),
  CONSTRAINT `reinscripcion_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reinscripcion`
--

LOCK TABLES `reinscripcion` WRITE;
/*!40000 ALTER TABLE `reinscripcion` DISABLE KEYS */;
INSERT INTO `reinscripcion` VALUES (1,'anatorres',2,'2024-06-01','Aprobada'),(2,'Block',2,'2024-06-01','Aprobada'),(3,'carlasmith',2,'2024-06-01','Aprobada'),(4,'carlosramirez',2,'2024-06-01','Aprobada'),(5,'danielruiz',2,'2024-06-01','Aprobada'),(6,'eduardogarcia',2,'2024-06-01','Aprobada'),(7,'existinguser',2,'2024-06-01','Aprobada'),(8,'javiermartinez',2,'2024-06-01','Aprobada'),(9,'juanperez',2,'2024-06-01','Aprobada'),(10,'juliamartinez',2,'2024-06-01','Aprobada'),(16,'anatorres',2,'2024-06-01','Aprobada'),(17,'Block',2,'2024-06-01','Aprobada'),(18,'carlasmith',2,'2024-06-01','Aprobada'),(19,'carlosramirez',2,'2024-06-01','Aprobada'),(20,'danielruiz',2,'2024-06-01','Aprobada'),(21,'eduardogarcia',2,'2024-06-01','Aprobada'),(22,'existinguser',2,'2024-06-01','Aprobada'),(23,'javiermartinez',2,'2024-06-01','Aprobada'),(24,'juanperez',2,'2024-06-01','Aprobada'),(25,'juliamartinez',2,'2024-06-01','Aprobada');
/*!40000 ALTER TABLE `reinscripcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semester` (
  `idSemestre` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  PRIMARY KEY (`idSemestre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (1,'Primer semestre'),(2,'Segundo semestre'),(3,'Tercer semestre'),(4,'Cuarto semestre'),(5,'Quinto semestre'),(6,'Sexto semestre'),(7,'Séptimo semestre'),(8,'Octavo semestre'),(9,'Noveno semestre');
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_icons`
--

DROP TABLE IF EXISTS `subject_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_icons` (
  `idAsignatura` int NOT NULL,
  `icon_name` varchar(255) DEFAULT NULL,
  `icon_data` longblob,
  PRIMARY KEY (`idAsignatura`),
  CONSTRAINT `subject_icons_ibfk_1` FOREIGN KEY (`idAsignatura`) REFERENCES `subjects` (`idAsignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_icons`
--

LOCK TABLES `subject_icons` WRITE;
/*!40000 ALTER TABLE `subject_icons` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_icons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `idAsignatura` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `semestre` int NOT NULL,
  `icon_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idAsignatura`),
  KEY `semestre` (`semestre`),
  CONSTRAINT `subjects_ibfk_1` FOREIGN KEY (`semestre`) REFERENCES `semester` (`idSemestre`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'Matemáticas I',1,NULL),(2,'Física I',1,NULL),(3,'Introducción a la Programación',1,NULL),(4,'Álgebra Lineal',1,NULL),(5,'Cálculo I',1,NULL),(6,'Programación Orientada a Objetos',2,NULL),(7,'Estructuras de Datos',2,NULL),(8,'Cálculo II',2,NULL),(9,'Bases de Datos',2,NULL),(10,'Análisis y Diseño de Algoritmos',2,NULL),(11,'Redes de Computadoras',3,NULL),(12,'Sistemas Operativos',3,NULL),(13,'Diseño de Interfaces de Usuario',3,NULL),(14,'Programación Web',3,NULL),(15,'Lenguajes de Programación',3,NULL),(16,'Inteligencia Artificial',4,NULL),(17,'Ingeniería de Software',4,NULL),(18,'Gestión de Proyectos de Software',4,NULL),(19,'Desarrollo Ágil',4,NULL),(20,'Seguridad Informática',4,NULL),(21,'Bases de Datos Avanzadas',5,NULL),(22,'Computación en la Nube',5,NULL),(23,'Big Data',5,NULL),(24,'Análisis Predictivo',5,NULL),(25,'Machine Learning',5,NULL),(26,'Desarrollo de Aplicaciones Móviles',6,NULL),(27,'Realidad Virtual y Aumentada',6,NULL),(28,'Blockchain',6,NULL),(29,'IoT y Sistemas Embebidos',6,NULL),(30,'Robótica',6,NULL),(31,'E-commerce y Marketing Digital',7,NULL),(32,'Business Intelligence',7,NULL),(33,'Gestión de la Cadena de Suministro',7,NULL),(34,'Customer Relationship Management',7,NULL),(35,'Gestión de la Calidad Total',7,NULL),(36,'Innovación y Emprendimiento',8,NULL),(37,'Ética y Responsabilidad Social',8,NULL),(38,'Liderazgo y Trabajo en Equipo',8,NULL),(39,'Comunicación Efectiva',8,NULL),(40,'Negociación y Resolución de Conflictos',8,NULL),(41,'Gestión Estratégica',9,NULL),(42,'Planificación Financiera',9,NULL),(43,'Gestión del Cambio Organizacional',9,NULL),(44,'Dirección de Proyectos',9,NULL),(45,'Marketing Estratégico',9,NULL);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects_taught_by_teacher`
--

DROP TABLE IF EXISTS `subjects_taught_by_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects_taught_by_teacher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int DEFAULT NULL,
  `subject_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_id` (`teacher_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `subjects_taught_by_teacher_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`teacher_id`),
  CONSTRAINT `subjects_taught_by_teacher_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`idAsignatura`)
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects_taught_by_teacher`
--

LOCK TABLES `subjects_taught_by_teacher` WRITE;
/*!40000 ALTER TABLE `subjects_taught_by_teacher` DISABLE KEYS */;
INSERT INTO `subjects_taught_by_teacher` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,1,41),(42,1,42),(43,1,43),(44,1,44),(45,1,45),(46,2,1),(47,2,2),(48,2,3),(49,2,4),(50,2,5),(51,2,6),(52,2,7),(53,2,8),(54,2,9),(55,2,10),(56,2,11),(57,2,12),(58,2,13),(59,2,14),(60,2,15),(61,2,16),(62,2,17),(63,2,18),(64,2,19),(65,2,20),(66,2,21),(67,2,22),(68,2,23),(69,2,24),(70,2,25),(71,2,26),(72,2,27),(73,2,28),(74,2,29),(75,2,30),(76,2,31),(77,2,32),(78,2,33),(79,2,34),(80,2,35),(81,2,36),(82,2,37),(83,2,38),(84,2,39),(85,2,40),(86,2,41),(87,2,42),(88,2,43),(89,2,44),(90,2,45),(91,3,1),(92,3,2),(93,3,3),(94,3,4),(95,3,5),(96,3,6),(97,3,7),(98,3,8),(99,3,9),(100,3,10),(101,3,11),(102,3,12),(103,3,13),(104,3,14),(105,3,15),(106,3,16),(107,3,17),(108,3,18),(109,3,19),(110,3,20),(111,3,21),(112,3,22),(113,3,23),(114,3,24),(115,3,25),(116,3,26),(117,3,27),(118,3,28),(119,3,29),(120,3,30),(121,3,31),(122,3,32),(123,3,33),(124,3,34),(125,3,35),(126,3,36),(127,3,37),(128,3,38),(129,3,39),(130,3,40),(131,3,41),(132,3,42),(133,3,43),(134,3,44),(135,3,45),(136,4,1),(137,4,2),(138,4,3),(139,4,4),(140,4,5),(141,4,6),(142,4,7),(143,4,8),(144,4,9),(145,4,10),(146,4,11),(147,4,12),(148,4,13),(149,4,14),(150,4,15),(151,4,16),(152,4,17),(153,4,18),(154,4,19),(155,4,20),(156,4,21),(157,4,22),(158,4,23),(159,4,24),(160,4,25),(161,4,26),(162,4,27),(163,4,28),(164,4,29),(165,4,30),(166,4,31),(167,4,32),(168,4,33),(169,4,34),(170,4,35),(171,4,36),(172,4,37),(173,4,38),(174,4,39),(175,4,40),(176,4,41),(177,4,42),(178,4,43),(179,4,44),(180,4,45),(181,5,1),(182,5,2),(183,5,3),(184,5,4),(185,5,5),(186,5,6),(187,5,7),(188,5,8),(189,5,9),(190,5,10),(191,5,11),(192,5,12),(193,5,13),(194,5,14),(195,5,15),(196,5,16),(197,5,17),(198,5,18),(199,5,19),(200,5,20),(201,5,21),(202,5,22),(203,5,23),(204,5,24),(205,5,25),(206,5,26),(207,5,27),(208,5,28),(209,5,29),(210,5,30),(211,5,31),(212,5,32),(213,5,33),(214,5,34),(215,5,35),(216,5,36),(217,5,37),(218,5,38),(219,5,39),(220,5,40),(221,5,41),(222,5,42),(223,5,43),(224,5,44),(225,5,45),(226,6,1),(227,6,2),(228,6,3),(229,6,4),(230,6,5),(231,6,6),(232,6,7),(233,6,8),(234,6,9),(235,6,10),(236,6,11),(237,6,12),(238,6,13),(239,6,14),(240,6,15),(241,6,16),(242,6,17),(243,6,18),(244,6,19),(245,6,20),(246,6,21),(247,6,22),(248,6,23),(249,6,24),(250,6,25),(251,6,26),(252,6,27),(253,6,28),(254,6,29),(255,6,30),(256,6,31),(257,6,32),(258,6,33),(259,6,34),(260,6,35),(261,6,36),(262,6,37),(263,6,38),(264,6,39),(265,6,40),(266,6,41),(267,6,42),(268,6,43),(269,6,44),(270,6,45),(271,7,1),(272,7,2),(273,7,3),(274,7,4),(275,7,5),(276,7,6),(277,7,7),(278,7,8),(279,7,9),(280,7,10),(281,7,11),(282,7,12),(283,7,13),(284,7,14),(285,7,15),(286,7,16),(287,7,17),(288,7,18),(289,7,19),(290,7,20),(291,7,21),(292,7,22),(293,7,23),(294,7,24),(295,7,25),(296,7,26),(297,7,27),(298,7,28),(299,7,29),(300,7,30),(301,7,31),(302,7,32),(303,7,33),(304,7,34),(305,7,35),(306,7,36),(307,7,37),(308,7,38),(309,7,39),(310,7,40),(311,7,41),(312,7,42),(313,7,43),(314,7,44),(315,7,45),(316,8,1),(317,8,2),(318,8,3),(319,8,4),(320,8,5),(321,8,6),(322,8,7),(323,8,8),(324,8,9),(325,8,10),(326,8,11),(327,8,12),(328,8,13),(329,8,14),(330,8,15),(331,8,16),(332,8,17),(333,8,18),(334,8,19),(335,8,20),(336,8,21),(337,8,22),(338,8,23),(339,8,24),(340,8,25),(341,8,26),(342,8,27),(343,8,28),(344,8,29),(345,8,30),(346,8,31),(347,8,32),(348,8,33),(349,8,34),(350,8,35),(351,8,36),(352,8,37),(353,8,38),(354,8,39),(355,8,40),(356,8,41),(357,8,42),(358,8,43),(359,8,44),(360,8,45),(361,9,1),(362,9,2),(363,9,3),(364,9,4),(365,9,5),(366,9,6),(367,9,7),(368,9,8),(369,9,9),(370,9,10),(371,9,11),(372,9,12),(373,9,13),(374,9,14),(375,9,15),(376,9,16),(377,9,17),(378,9,18),(379,9,19),(380,9,20),(381,9,21),(382,9,22),(383,9,23),(384,9,24),(385,9,25),(386,9,26),(387,9,27),(388,9,28),(389,9,29),(390,9,30),(391,9,31),(392,9,32),(393,9,33),(394,9,34),(395,9,35),(396,9,36),(397,9,37),(398,9,38),(399,9,39),(400,9,40),(401,9,41),(402,9,42),(403,9,43),(404,9,44),(405,9,45),(406,10,1),(407,10,2),(408,10,3),(409,10,4),(410,10,5),(411,10,6),(412,10,7),(413,10,8),(414,10,9),(415,10,10),(416,10,11),(417,10,12),(418,10,13),(419,10,14),(420,10,15),(421,10,16),(422,10,17),(423,10,18),(424,10,19),(425,10,20),(426,10,21),(427,10,22),(428,10,23),(429,10,24),(430,10,25),(431,10,26),(432,10,27),(433,10,28),(434,10,29),(435,10,30),(436,10,31),(437,10,32),(438,10,33),(439,10,34),(440,10,35),(441,10,36),(442,10,37),(443,10,38),(444,10,39),(445,10,40),(446,10,41),(447,10,42),(448,10,43),(449,10,44),(450,10,45),(451,11,1),(452,11,2),(453,11,3),(454,11,4),(455,11,5),(456,11,6),(457,11,7),(458,11,8),(459,11,9),(460,11,10),(461,11,11),(462,11,12),(463,11,13),(464,11,14),(465,11,15),(466,11,16),(467,11,17),(468,11,18),(469,11,19),(470,11,20),(471,11,21),(472,11,22),(473,11,23),(474,11,24),(475,11,25),(476,11,26),(477,11,27),(478,11,28),(479,11,29),(480,11,30),(481,11,31),(482,11,32),(483,11,33),(484,11,34),(485,11,35),(486,11,36),(487,11,37),(488,11,38),(489,11,39),(490,11,40),(491,11,41),(492,11,42),(493,11,43),(494,11,44),(495,11,45),(496,12,1),(497,12,2),(498,12,3),(499,12,4),(500,12,5),(501,12,6),(502,12,7),(503,12,8),(504,12,9),(505,12,10),(506,12,11),(507,12,12),(508,12,13),(509,12,14),(510,12,15),(511,12,16),(512,12,17),(513,12,18),(514,12,19),(515,12,20),(516,12,21),(517,12,22),(518,12,23),(519,12,24),(520,12,25),(521,12,26),(522,12,27),(523,12,28),(524,12,29),(525,12,30),(526,12,31),(527,12,32),(528,12,33),(529,12,34),(530,12,35),(531,12,36),(532,12,37),(533,12,38),(534,12,39),(535,12,40),(536,12,41),(537,12,42),(538,12,43),(539,12,44),(540,12,45),(541,13,1),(542,13,2),(543,13,3),(544,13,4),(545,13,5),(546,13,6),(547,13,7),(548,13,8),(549,13,9),(550,13,10),(551,13,11),(552,13,12),(553,13,13),(554,13,14),(555,13,15),(556,13,16),(557,13,17),(558,13,18),(559,13,19),(560,13,20),(561,13,21),(562,13,22),(563,13,23),(564,13,24),(565,13,25),(566,13,26),(567,13,27),(568,13,28),(569,13,29),(570,13,30),(571,13,31),(572,13,32),(573,13,33),(574,13,34),(575,13,35),(576,13,36),(577,13,37),(578,13,38),(579,13,39),(580,13,40),(581,13,41),(582,13,42),(583,13,43),(584,13,44),(585,13,45),(586,14,1),(587,14,2),(588,14,3),(589,14,4),(590,14,5),(591,14,6),(592,14,7),(593,14,8),(594,14,9),(595,14,10),(596,14,11),(597,14,12),(598,14,13),(599,14,14),(600,14,15),(601,14,16),(602,14,17),(603,14,18),(604,14,19),(605,14,20),(606,14,21),(607,14,22),(608,14,23),(609,14,24),(610,14,25),(611,14,26),(612,14,27),(613,14,28),(614,14,29),(615,14,30),(616,14,31),(617,14,32),(618,14,33),(619,14,34),(620,14,35),(621,14,36),(622,14,37),(623,14,38),(624,14,39),(625,14,40),(626,14,41),(627,14,42),(628,14,43),(629,14,44),(630,14,45),(631,15,1),(632,15,2),(633,15,3),(634,15,4),(635,15,5),(636,15,6),(637,15,7),(638,15,8),(639,15,9),(640,15,10),(641,15,11),(642,15,12),(643,15,13),(644,15,14),(645,15,15),(646,15,16),(647,15,17),(648,15,18),(649,15,19),(650,15,20),(651,15,21),(652,15,22),(653,15,23),(654,15,24),(655,15,25),(656,15,26),(657,15,27),(658,15,28),(659,15,29),(660,15,30),(661,15,31),(662,15,32),(663,15,33),(664,15,34),(665,15,35),(666,15,36),(667,15,37),(668,15,38),(669,15,39),(670,15,40),(671,15,41),(672,15,42),(673,15,43),(674,15,44),(675,15,45),(676,16,1),(677,16,2),(678,16,3),(679,16,4),(680,16,5),(681,16,6),(682,16,7),(683,16,8),(684,16,9),(685,16,10),(686,16,11),(687,16,12),(688,16,13),(689,16,14),(690,16,15),(691,16,16),(692,16,17),(693,16,18),(694,16,19),(695,16,20),(696,16,21),(697,16,22),(698,16,23),(699,16,24),(700,16,25),(701,16,26),(702,16,27),(703,16,28),(704,16,29),(705,16,30),(706,16,31),(707,16,32),(708,16,33),(709,16,34),(710,16,35),(711,16,36),(712,16,37),(713,16,38),(714,16,39),(715,16,40),(716,16,41),(717,16,42),(718,16,43),(719,16,44),(720,16,45),(721,17,1),(722,17,2),(723,17,3),(724,17,4),(725,17,5),(726,17,6),(727,17,7),(728,17,8),(729,17,9),(730,17,10),(731,17,11),(732,17,12),(733,17,13),(734,17,14),(735,17,15),(736,17,16),(737,17,17),(738,17,18),(739,17,19),(740,17,20),(741,17,21),(742,17,22),(743,17,23),(744,17,24),(745,17,25),(746,17,26),(747,17,27),(748,17,28),(749,17,29),(750,17,30),(751,17,31),(752,17,32),(753,17,33),(754,17,34),(755,17,35),(756,17,36),(757,17,37),(758,17,38),(759,17,39),(760,17,40),(761,17,41),(762,17,42),(763,17,43),(764,17,44),(765,17,45),(766,18,1),(767,18,2),(768,18,3),(769,18,4),(770,18,5),(771,18,6),(772,18,7),(773,18,8),(774,18,9),(775,18,10),(776,18,11),(777,18,12),(778,18,13),(779,18,14),(780,18,15),(781,18,16),(782,18,17),(783,18,18),(784,18,19),(785,18,20),(786,18,21),(787,18,22),(788,18,23),(789,18,24),(790,18,25),(791,18,26),(792,18,27),(793,18,28),(794,18,29),(795,18,30),(796,18,31),(797,18,32),(798,18,33),(799,18,34),(800,18,35),(801,18,36),(802,18,37),(803,18,38),(804,18,39),(805,18,40),(806,18,41),(807,18,42),(808,18,43),(809,18,44),(810,18,45),(811,19,1),(812,19,2),(813,19,3),(814,19,4),(815,19,5),(816,19,6),(817,19,7),(818,19,8),(819,19,9),(820,19,10),(821,19,11),(822,19,12),(823,19,13),(824,19,14),(825,19,15),(826,19,16),(827,19,17),(828,19,18),(829,19,19),(830,19,20),(831,19,21),(832,19,22),(833,19,23),(834,19,24),(835,19,25),(836,19,26),(837,19,27),(838,19,28),(839,19,29),(840,19,30),(841,19,31),(842,19,32),(843,19,33),(844,19,34),(845,19,35),(846,19,36),(847,19,37),(848,19,38),(849,19,39),(850,19,40),(851,19,41),(852,19,42),(853,19,43),(854,19,44),(855,19,45),(856,20,1),(857,20,2),(858,20,3),(859,20,4),(860,20,5),(861,20,6),(862,20,7),(863,20,8),(864,20,9),(865,20,10),(866,20,11),(867,20,12),(868,20,13),(869,20,14),(870,20,15),(871,20,16),(872,20,17),(873,20,18),(874,20,19),(875,20,20),(876,20,21),(877,20,22),(878,20,23),(879,20,24),(880,20,25),(881,20,26),(882,20,27),(883,20,28),(884,20,29),(885,20,30),(886,20,31),(887,20,32),(888,20,33),(889,20,34),(890,20,35),(891,20,36),(892,20,37),(893,20,38),(894,20,39),(895,20,40),(896,20,41),(897,20,42),(898,20,43),(899,20,44),(900,20,45),(901,21,1),(902,21,2),(903,21,3),(904,21,4),(905,21,5),(906,21,6),(907,21,7),(908,21,8),(909,21,9),(910,21,10),(911,21,11),(912,21,12),(913,21,13),(914,21,14),(915,21,15),(916,21,16),(917,21,17),(918,21,18),(919,21,19),(920,21,20),(921,21,21),(922,21,22),(923,21,23),(924,21,24),(925,21,25),(926,21,26),(927,21,27),(928,21,28),(929,21,29),(930,21,30),(931,21,31),(932,21,32),(933,21,33),(934,21,34),(935,21,35),(936,21,36),(937,21,37),(938,21,38),(939,21,39),(940,21,40),(941,21,41),(942,21,42),(943,21,43),(944,21,44),(945,21,45),(946,22,1),(947,22,2),(948,22,3),(949,22,4),(950,22,5),(951,22,6),(952,22,7),(953,22,8),(954,22,9),(955,22,10),(956,22,11),(957,22,12),(958,22,13),(959,22,14),(960,22,15),(961,22,16),(962,22,17),(963,22,18),(964,22,19),(965,22,20),(966,22,21),(967,22,22),(968,22,23),(969,22,24),(970,22,25),(971,22,26),(972,22,27),(973,22,28),(974,22,29),(975,22,30),(976,22,31),(977,22,32),(978,22,33),(979,22,34),(980,22,35),(981,22,36),(982,22,37),(983,22,38),(984,22,39),(985,22,40),(986,22,41),(987,22,42),(988,22,43),(989,22,44),(990,22,45),(991,23,1),(992,23,2),(993,23,3),(994,23,4),(995,23,5),(996,23,6),(997,23,7),(998,23,8),(999,23,9),(1000,23,10),(1001,23,11),(1002,23,12),(1003,23,13),(1004,23,14),(1005,23,15),(1006,23,16),(1007,23,17),(1008,23,18),(1009,23,19),(1010,23,20),(1011,23,21),(1012,23,22),(1013,23,23),(1014,23,24),(1015,23,25),(1016,23,26),(1017,23,27),(1018,23,28),(1019,23,29),(1020,23,30),(1021,23,31),(1022,23,32),(1023,23,33),(1024,23,34),(1025,23,35),(1026,23,36),(1027,23,37),(1028,23,38),(1029,23,39),(1030,23,40),(1031,23,41),(1032,23,42),(1033,23,43),(1034,23,44),(1035,23,45),(1036,24,1),(1037,24,2),(1038,24,3),(1039,24,4),(1040,24,5),(1041,24,6),(1042,24,7),(1043,24,8),(1044,24,9),(1045,24,10),(1046,24,11),(1047,24,12),(1048,24,13),(1049,24,14),(1050,24,15),(1051,24,16),(1052,24,17),(1053,24,18),(1054,24,19),(1055,24,20),(1056,24,21),(1057,24,22),(1058,24,23),(1059,24,24),(1060,24,25),(1061,24,26),(1062,24,27),(1063,24,28),(1064,24,29),(1065,24,30),(1066,24,31),(1067,24,32),(1068,24,33),(1069,24,34),(1070,24,35),(1071,24,36),(1072,24,37),(1073,24,38),(1074,24,39),(1075,24,40),(1076,24,41),(1077,24,42),(1078,24,43),(1079,24,44),(1080,24,45);
/*!40000 ALTER TABLE `subjects_taught_by_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `teacher_subject_view`
--

DROP TABLE IF EXISTS `teacher_subject_view`;
/*!50001 DROP VIEW IF EXISTS `teacher_subject_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `teacher_subject_view` AS SELECT 
 1 AS `teacher_name`,
 1 AS `enrollment`,
 1 AS `subject_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `teacher_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `enrollment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`teacher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'Esbeyde Mora','12345'),(2,'Jane Doe','54321'),(3,'Narciso Vera','98765'),(4,'Alice Johnson','11111'),(5,'Bob Smith','22222'),(6,'Carol Williams','33333'),(7,'David Jones','44444'),(8,'Emily Brown','55555'),(9,'Frank Davis','66666'),(10,'Gina Martinez','77777'),(11,'Henry Wilson','88888'),(12,'Isabel Taylor','99999'),(13,'Jack Anderson','101010'),(14,'Karen Garcia','202020'),(15,'Larry Miller','303030'),(16,'Megan Wilson','404040'),(17,'Nancy Lopez','505050'),(18,'Oliver Clark','606060'),(19,'Patricia Lee','707070'),(20,'Quentin Adams','808080'),(21,'Rachel Martinez','909090'),(22,'Samuel Brown','123456'),(23,'Tina Thompson','234567'),(24,'Victor White','345678');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `idUser` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `nControl` int NOT NULL,
  `rankId` int NOT NULL,
  `semester` int DEFAULT NULL,
  `regular` varchar(2) NOT NULL DEFAULT 'Si',
  `score` int DEFAULT '100',
  PRIMARY KEY (`idUser`),
  KEY `rank` (`rankId`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`rankId`) REFERENCES `rankuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','admin','Administrador','Administrador',312324324,1,1,'Si',100),('ajohnson','ajohnson123','Amelia','Johnson',123456789,1,4,'No',77),('amiller','millertime','Alice','Miller',987654321,2,3,'No',72),('anatorres','An@T0rr3s','Ana','Torres',21080345,2,5,'Si',64),('asanchez','sanchez456','Alexis','Sanchez',456789123,3,2,'Si',80),('awhite','whitepass','Ava','White',456789123,2,2,'Si',87),('Block','123','Alexis','Hurtado',21070012,2,6,'Si',72),('carlasmith','C@rl@Sm1th','Carla','Smith',21080890,2,5,'Si',71),('carlosramirez','C@rlosR@m1rez','Carlos','Ramirez',21090078,2,7,'Si',78),('charris','harris789','Charlotte','Harris',987654321,2,4,'No',71),('danielruiz','D@ni3lRu!z','Daniel','Ruiz',21080789,2,5,'No',77),('dmartinez','martinez123','Daniel','Martinez',135790246,2,3,'Si',78),('ebrown','brown123','Emma','Brown',135790246,2,1,'No',67),('eduardogarcia','3du@rd0G@rc1@','Eduardo','Garcia',21060901,2,4,'No',92),('ejones','ilovepizza','Emily','Jones',456789123,3,4,'No',68),('existinguser','password123','Jane','Smith',987654321,2,4,'Si',87),('imoore','moore123','Isabella','Moore',246801357,3,2,'Si',91),('javiermartinez','J@vierM@rt1nez','Javier','Martinez',21090456,2,7,'Si',60),('jjackson','jacksonpass','James','Jackson',357910246,1,4,'No',69),('jlee','leepass','Jack','Lee',246801357,1,4,'Si',92),('jlloyd','lloyd123','Julia','Lloyd',246801357,3,1,'Si',83),('jmartinez','martinez789','Justin','Martinez',357910246,1,2,'No',68),('jsmith','password123','John','Smith',123456789,1,2,'Si',85),('juanperez','juAnP@ssw0rd','Juan','Perez',21070012,2,6,'Si',100),('juliamartinez','Juli@M@rt1nez','Julia','Martinez',21090567,2,7,'Si',99),('klloyd','klloyd789','Kaylee','Lloyd',975310246,3,3,'No',75),('lauragonzalez','l@ur@G0nz','Laura','Gonzalez',21060123,2,4,'No',96),('lrodriguez','rodriguez456','Lucas','Rodriguez',987654321,2,1,'Si',85),('luciamartinez','luci@M@rt1nez','Lucia','Martinez',21090123,2,7,'No',79),('luisfernandez','lui$F3rn@nd3z','Luis','Fernandez',21060567,2,4,'No',88),('manderson','anderson789','Matthew','Anderson',975310246,3,4,'No',70),('mariagomez','m@ri@G0mez123','Maria','Gomez',21080045,2,5,'No',64),('McBlockier','1234','Alexis','Lopez',21070012,2,6,'Si',100),('mhall','hallpass','Mason','Hall',456789123,2,3,'Si',84),('mjackson','mjacksonpass','Michael','Jackson',543216789,1,3,'Si',86),('mjohnson','mjohnson123','Madison','Johnson',975310246,3,3,'No',73),('monicagonzalez','M0nic@G0nz@l3z','Monica','Gonzalez',21071012,2,6,'Si',76),('mwilliams','williamspass','Mia','Williams',789456123,3,3,'No',74),('nataliacastro','N@tali@c@str0','Natalia','Castro',21070678,2,6,'Si',90),('newuser','password123','John','Doe',123456789,2,6,'Si',78),('oscarrodriguez','0$carR0dr1gu3z','Oscar','Rodriguez',21080456,2,5,'No',60),('owilson','wilsonpass','Olivia','Wilson',543219875,1,3,'Si',88),('patriciadiaz','P@trici@d1@z','Patricia','Diaz',21070345,2,6,'Si',91),('pedrolopez','P3dr0L0pez!','Pedro','Lopez',21070234,2,6,'No',93),('raullopez','R@ulL0pez','Raul','Lopez',21060678,2,4,'No',92),('rjohnson','johnnyboy','Robert','Johnson',543216789,1,1,'Si',90),('rjones','rjones123','Ryan','Jones',543219875,1,4,'Si',88),('rsmith','rsmithpass','Ryan','Smith',987651234,2,4,'No',76),('sergiohernandez','S3rgioH3rn@ndez','Sergio','Hernandez',21060234,2,4,'Si',78),('srodriguez','rodriguez123','Samuel','Rodriguez',123456789,1,1,'Si',79),('staylor','taylor456','Sophia','Taylor',246801357,1,2,'Si',82),('tlee','leepass123','Tiffany','Lee',543216789,1,2,'Si',90),('tthomas','thomas456','Taylor','Thomas',543219875,1,2,'Si',89),('valerialopez','v@l3r1@l0pez','Valeria','Lopez',21070789,2,6,'No',95),('wthompson','thompson567','William','Thompson',987651234,2,1,'No',75);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_delete_user` BEFORE DELETE ON `user` FOR EACH ROW BEGIN
    DECLARE deleter_rankId INT;

    -- Obtener el rankId del usuario que está intentando realizar la eliminación
    SELECT rankId INTO deleter_rankId
    FROM user
    WHERE idUser = USER();  -- USER() devuelve el usuario que está realizando la acción

    -- Verificar si el rankId del usuario que está intentando eliminar es igual a 1
    IF deleter_rankId <> 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No tiene permiso para eliminar usuarios.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_subject`
--

DROP TABLE IF EXISTS `user_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_subject` (
  `idUser` varchar(255) NOT NULL,
  `idAsignatura` int NOT NULL,
  PRIMARY KEY (`idUser`,`idAsignatura`),
  KEY `idAsignatura` (`idAsignatura`),
  CONSTRAINT `user_subject_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`),
  CONSTRAINT `user_subject_ibfk_2` FOREIGN KEY (`idAsignatura`) REFERENCES `subjects` (`idAsignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_subject`
--

LOCK TABLES `user_subject` WRITE;
/*!40000 ALTER TABLE `user_subject` DISABLE KEYS */;
INSERT INTO `user_subject` VALUES ('eduardogarcia',16),('existinguser',16),('lauragonzalez',16),('luisfernandez',16),('raullopez',16),('sergiohernandez',16),('eduardogarcia',17),('existinguser',17),('lauragonzalez',17),('luisfernandez',17),('raullopez',17),('sergiohernandez',17),('eduardogarcia',18),('existinguser',18),('lauragonzalez',18),('luisfernandez',18),('raullopez',18),('sergiohernandez',18),('eduardogarcia',19),('existinguser',19),('lauragonzalez',19),('luisfernandez',19),('raullopez',19),('sergiohernandez',19),('eduardogarcia',20),('existinguser',20),('lauragonzalez',20),('luisfernandez',20),('raullopez',20),('sergiohernandez',20),('anatorres',21),('carlasmith',21),('danielruiz',21),('mariagomez',21),('oscarrodriguez',21),('anatorres',22),('carlasmith',22),('danielruiz',22),('mariagomez',22),('oscarrodriguez',22),('anatorres',23),('carlasmith',23),('danielruiz',23),('mariagomez',23),('oscarrodriguez',23),('anatorres',24),('carlasmith',24),('danielruiz',24),('mariagomez',24),('oscarrodriguez',24),('anatorres',25),('carlasmith',25),('danielruiz',25),('mariagomez',25),('oscarrodriguez',25),('Block',26),('juanperez',26),('McBlockier',26),('monicagonzalez',26),('nataliacastro',26),('newuser',26),('patriciadiaz',26),('pedrolopez',26),('valerialopez',26),('Block',27),('juanperez',27),('McBlockier',27),('monicagonzalez',27),('nataliacastro',27),('newuser',27),('patriciadiaz',27),('pedrolopez',27),('valerialopez',27),('Block',28),('juanperez',28),('McBlockier',28),('monicagonzalez',28),('nataliacastro',28),('newuser',28),('patriciadiaz',28),('pedrolopez',28),('valerialopez',28),('Block',29),('juanperez',29),('McBlockier',29),('monicagonzalez',29),('nataliacastro',29),('newuser',29),('patriciadiaz',29),('pedrolopez',29),('valerialopez',29),('Block',30),('juanperez',30),('McBlockier',30),('monicagonzalez',30),('nataliacastro',30),('newuser',30),('patriciadiaz',30),('pedrolopez',30),('valerialopez',30),('carlosramirez',31),('javiermartinez',31),('juliamartinez',31),('luciamartinez',31),('carlosramirez',32),('javiermartinez',32),('juliamartinez',32),('luciamartinez',32),('carlosramirez',33),('javiermartinez',33),('juliamartinez',33),('luciamartinez',33),('carlosramirez',34),('javiermartinez',34),('juliamartinez',34),('luciamartinez',34),('carlosramirez',35),('javiermartinez',35),('juliamartinez',35),('luciamartinez',35);
/*!40000 ALTER TABLE `user_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `usercredits`
--

DROP TABLE IF EXISTS `usercredits`;
/*!50001 DROP VIEW IF EXISTS `usercredits`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usercredits` AS SELECT 
 1 AS `idUser`,
 1 AS `semestre`,
 1 AS `creditosAcademicos`,
 1 AS `creditosExtraescolares`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `userdetails`
--

DROP TABLE IF EXISTS `userdetails`;
/*!50001 DROP VIEW IF EXISTS `userdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userdetails` AS SELECT 
 1 AS `idUser`,
 1 AS `name`,
 1 AS `lastName`,
 1 AS `nControl`,
 1 AS `semester`,
 1 AS `regular`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `usergradereport`
--

DROP TABLE IF EXISTS `usergradereport`;
/*!50001 DROP VIEW IF EXISTS `usergradereport`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usergradereport` AS SELECT 
 1 AS `idBoleta`,
 1 AS `idUser`,
 1 AS `idAsignatura`,
 1 AS `semestre`,
 1 AS `calificacion`,
 1 AS `fecha`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `usergraduations`
--

DROP TABLE IF EXISTS `usergraduations`;
/*!50001 DROP VIEW IF EXISTS `usergraduations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usergraduations` AS SELECT 
 1 AS `idTitulacion`,
 1 AS `idUser`,
 1 AS `tipoTitulacion`,
 1 AS `fechaInicio`,
 1 AS `fechaFinalizacion`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `userprofessionallicenses`
--

DROP TABLE IF EXISTS `userprofessionallicenses`;
/*!50001 DROP VIEW IF EXISTS `userprofessionallicenses`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userprofessionallicenses` AS SELECT 
 1 AS `idCedula`,
 1 AS `idUser`,
 1 AS `numeroCedula`,
 1 AS `fechaExpedicion`,
 1 AS `autoridad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `userreinscriptions`
--

DROP TABLE IF EXISTS `userreinscriptions`;
/*!50001 DROP VIEW IF EXISTS `userreinscriptions`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `userreinscriptions` AS SELECT 
 1 AS `idReinscripcion`,
 1 AS `idUser`,
 1 AS `semestre`,
 1 AS `fecha`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `usersubjects`
--

DROP TABLE IF EXISTS `usersubjects`;
/*!50001 DROP VIEW IF EXISTS `usersubjects`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usersubjects` AS SELECT 
 1 AS `idUser`,
 1 AS `name`,
 1 AS `lastName`,
 1 AS `asignatura`,
 1 AS `semestre`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_detailed_grade_report`
--

DROP TABLE IF EXISTS `view_detailed_grade_report`;
/*!50001 DROP VIEW IF EXISTS `view_detailed_grade_report`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_detailed_grade_report` AS SELECT 
 1 AS `idBoleta`,
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `idAsignatura`,
 1 AS `nombre_asignatura`,
 1 AS `semestre`,
 1 AS `calificacion`,
 1 AS `fecha`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_graduated_users`
--

DROP TABLE IF EXISTS `view_graduated_users`;
/*!50001 DROP VIEW IF EXISTS `view_graduated_users`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_graduated_users` AS SELECT 
 1 AS `idTitulacion`,
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `tipoTitulacion`,
 1 AS `fechaFinalizacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_professional_license`
--

DROP TABLE IF EXISTS `view_professional_license`;
/*!50001 DROP VIEW IF EXISTS `view_professional_license`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_professional_license` AS SELECT 
 1 AS `idCedula`,
 1 AS `idUser`,
 1 AS `name`,
 1 AS `lastName`,
 1 AS `numeroCedula`,
 1 AS `fechaExpedicion`,
 1 AS `autoridad`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_reinscripcion`
--

DROP TABLE IF EXISTS `view_reinscripcion`;
/*!50001 DROP VIEW IF EXISTS `view_reinscripcion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_reinscripcion` AS SELECT 
 1 AS `idReinscripcion`,
 1 AS `idUser`,
 1 AS `name`,
 1 AS `lastName`,
 1 AS `semestre`,
 1 AS `fecha`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_subjects_by_semester`
--

DROP TABLE IF EXISTS `view_subjects_by_semester`;
/*!50001 DROP VIEW IF EXISTS `view_subjects_by_semester`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_subjects_by_semester` AS SELECT 
 1 AS `semestre`,
 1 AS `asignaturas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_user_payments`
--

DROP TABLE IF EXISTS `view_user_payments`;
/*!50001 DROP VIEW IF EXISTS `view_user_payments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_user_payments` AS SELECT 
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `total_pagos`,
 1 AS `total_monto_pagado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_user_subject_info`
--

DROP TABLE IF EXISTS `view_user_subject_info`;
/*!50001 DROP VIEW IF EXISTS `view_user_subject_info`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_user_subject_info` AS SELECT 
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `semester`,
 1 AS `idAsignatura`,
 1 AS `nombre_asignatura`,
 1 AS `semestre_asignatura`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_users_with_completed_credits`
--

DROP TABLE IF EXISTS `view_users_with_completed_credits`;
/*!50001 DROP VIEW IF EXISTS `view_users_with_completed_credits`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_users_with_completed_credits` AS SELECT 
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `total_creditos_academicos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_users_with_passing_grades`
--

DROP TABLE IF EXISTS `view_users_with_passing_grades`;
/*!50001 DROP VIEW IF EXISTS `view_users_with_passing_grades`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_users_with_passing_grades` AS SELECT 
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `promedio_calificaciones`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_users_with_recent_payments`
--

DROP TABLE IF EXISTS `view_users_with_recent_payments`;
/*!50001 DROP VIEW IF EXISTS `view_users_with_recent_payments`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_users_with_recent_payments` AS SELECT 
 1 AS `idPago`,
 1 AS `idUser`,
 1 AS `student_name`,
 1 AS `tipoPago`,
 1 AS `monto`,
 1 AS `fechaPago`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_aprobados_reprobados`
--

DROP TABLE IF EXISTS `vista_aprobados_reprobados`;
/*!50001 DROP VIEW IF EXISTS `vista_aprobados_reprobados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_aprobados_reprobados` AS SELECT 
 1 AS `name`,
 1 AS `lastName`,
 1 AS `semester`,
 1 AS `Estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'sca_database'
--

--
-- Dumping routines for database 'sca_database'
--
/*!50003 DROP FUNCTION IF EXISTS `CreateGradeReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CreateGradeReport`(
    in_idUser VARCHAR(255),
    in_idAsignatura INT,
    in_semestre INT,
    in_calificacion DECIMAL(5,2),
    in_fecha DATE
) RETURNS int
    NO SQL
BEGIN
    DECLARE success INT;
    
    INSERT INTO grade_report (idUser, idAsignatura, semestre, calificacion, fecha)
    VALUES (in_idUser, in_idAsignatura, in_semestre, in_calificacion, in_fecha);
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CreateReinscription` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CreateReinscription`(
    in_idUser VARCHAR(255),
    in_semestre INT,
    in_fecha DATE,
    in_estado VARCHAR(255)
) RETURNS int
    NO SQL
BEGIN
    DECLARE success INT;

    INSERT INTO reinscripcion (idUser, semestre, fecha, estado)
    VALUES (in_idUser, in_semestre, in_fecha, in_estado);

    SET success = ROW_COUNT();

    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `CreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `CreateUser`(
    in_idUser VARCHAR(255),
    in_password VARCHAR(255),
    in_name VARCHAR(255),
    in_lastName VARCHAR(255),
    in_nControl INT,
    in_rankId INT,
    in_semester INT,
    in_regular VARCHAR(2),
    in_score INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE success INT;
    
    INSERT INTO user (idUser, password, name, lastName, nControl, rankId, semester, regular, score)
    VALUES (in_idUser, in_password, in_name, in_lastName, in_nControl, in_rankId, in_semester, in_regular, in_score);
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `create_credit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `create_credit`(
    p_idUser VARCHAR(255),
    p_semestre INT,
    p_creditosAcademicos INT,
    p_creditosExtraescolares INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE new_idCredito INT;

    INSERT INTO credits (idUser, semestre, creditosAcademicos, creditosExtraescolares)
    VALUES (p_idUser, p_semestre, p_creditosAcademicos, p_creditosExtraescolares);

    SET new_idCredito = LAST_INSERT_ID();

    RETURN new_idCredito;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `DeleteUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `DeleteUser`(in_idUser VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE success INT;
    
    DELETE FROM user WHERE idUser = in_idUser;
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `delete_credit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `delete_credit`(
    p_idCredito INT
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE rows_affected INT;

    DELETE FROM credits WHERE idCredito = p_idCredito;

    SET rows_affected = ROW_COUNT();

    RETURN rows_affected > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_teacher_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_teacher_name`(teacher_id INT) RETURNS varchar(255) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    DECLARE teacher_name VARCHAR(255);
    SELECT name INTO teacher_name FROM teachers WHERE teacher_id = teacher_id;
    RETURN teacher_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `InsertarAsignaturasPorSemestre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `InsertarAsignaturasPorSemestre`(in_idUser VARCHAR(255), in_semestre INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE success INT DEFAULT 0;
    
    -- Eliminar registros previos del usuario en la tabla de asignaturas
    DELETE FROM user_subject WHERE idUser = in_idUser;
    
    -- Insertar las asignaturas correspondientes al semestre del usuario
    INSERT INTO user_subject (idUser, idAsignatura)
    SELECT in_idUser, idAsignatura
    FROM subjects
    WHERE semestre = in_semestre;
    
    -- Obtener el número de asignaturas insertadas
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `IssueProfessionalLicense` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `IssueProfessionalLicense`(
    in_idUser VARCHAR(255),
    in_numeroCedula VARCHAR(255),
    in_fechaExpedicion DATE,
    in_autoridad VARCHAR(255)
) RETURNS int
    NO SQL
BEGIN
    DECLARE success INT;
    
    INSERT INTO professional_license (idUser, numeroCedula, fechaExpedicion, autoridad)
    VALUES (in_idUser, in_numeroCedula, in_fechaExpedicion, in_autoridad);
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RegisterPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RegisterPayment`(
    in_idUser VARCHAR(255),
    in_tipoPago VARCHAR(255),
    in_monto DECIMAL(10,2),
    in_fechaPago DATE
) RETURNS int
    NO SQL
BEGIN
    DECLARE success INT;

    INSERT INTO payments (idUser, tipoPago, monto, fechaPago)
    VALUES (in_idUser, in_tipoPago, in_monto, in_fechaPago);

    SET success = ROW_COUNT();

    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RegisterUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `RegisterUser`(
    in_idUser VARCHAR(255),
    in_password VARCHAR(255),
    in_name VARCHAR(255),
    in_lastName VARCHAR(255),
    in_nControl INT,
    in_rankId INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE success INT;

    INSERT INTO user (idUser, password, name, lastName, nControl, rankId)
    VALUES (in_idUser, in_password, in_name, in_lastName, in_nControl, in_rankId);

    SET success = ROW_COUNT();

    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `StartGraduation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `StartGraduation`(
    in_idUser VARCHAR(255),
    in_tipoTitulacion VARCHAR(255),
    in_fechaInicio DATE,
    in_fechaFinalizacion DATE,
    in_estado VARCHAR(255)
) RETURNS int
    NO SQL
BEGIN
    DECLARE success INT;
    
    INSERT INTO graduation (idUser, tipoTitulacion, fechaInicio, fechaFinalizacion, estado)
    VALUES (in_idUser, in_tipoTitulacion, in_fechaInicio, in_fechaFinalizacion, in_estado);
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `UpdateSubject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `UpdateSubject`(
    in_idAsignatura INT,
    in_nombre VARCHAR(255),
    in_semestre INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE success INT;
    
    UPDATE subjects
    SET nombre = in_nombre, semestre = in_semestre
    WHERE idAsignatura = in_idAsignatura;
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `UpdateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `UpdateUser`(
    in_idUser VARCHAR(255),
    in_password VARCHAR(255),
    in_name VARCHAR(255),
    in_lastName VARCHAR(255),
    in_nControl INT,
    in_rankId INT,
    in_semester INT,
    in_regular VARCHAR(2),
    in_score INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE success INT;
    
    UPDATE user
    SET password = in_password, name = in_name, lastName = in_lastName, nControl = in_nControl,
        rankId = in_rankId, semester = in_semester, regular = in_regular, score = in_score
    WHERE idUser = in_idUser;
    
    SET success = ROW_COUNT();
    
    RETURN success;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `update_credit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `update_credit`(
    p_idCredito INT,
    p_idUser VARCHAR(255),
    p_semestre INT,
    p_creditosAcademicos INT,
    p_creditosExtraescolares INT
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    DECLARE rows_affected INT;

    UPDATE credits
    SET idUser = p_idUser,
        semestre = p_semestre,
        creditosAcademicos = p_creditosAcademicos,
        creditosExtraescolares = p_creditosExtraescolares
    WHERE idCredito = p_idCredito;

    SET rows_affected = ROW_COUNT();

    RETURN rows_affected > 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ValidateLogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ValidateLogin`(in_idUser VARCHAR(255), in_password VARCHAR(255)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*) INTO user_exists
    FROM user
    WHERE idUser = in_idUser AND password = in_password;

    RETURN user_exists;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `backup_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `backup_table`(IN table_name VARCHAR(255))
BEGIN
    DECLARE backup_table_name VARCHAR(255);
    SET backup_table_name = CONCAT(table_name, '_backup');

    -- Crear una tabla de respaldo si aún no existe
    IF NOT EXISTS (SELECT * FROM information_schema.tables WHERE table_name = backup_table_name) THEN
        SET @create_backup_table_sql = CONCAT('CREATE TABLE ', backup_table_name, ' LIKE ', table_name);
        PREPARE create_backup_table_stmt FROM @create_backup_table_sql;
        EXECUTE create_backup_table_stmt;
        DEALLOCATE PREPARE create_backup_table_stmt;
    END IF;

    -- Insertar datos en la tabla de respaldo
    SET @backup_data_sql = CONCAT('INSERT INTO ', backup_table_name, ' SELECT * FROM ', table_name);
    PREPARE backup_data_stmt FROM @backup_data_sql;
    EXECUTE backup_data_stmt;
    DEALLOCATE PREPARE backup_data_stmt;

    SELECT CONCAT('La tabla ', table_name, ' se ha respaldado correctamente en ', backup_table_name) AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_grade_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_grade_report`(
    IN p_idUser VARCHAR(255),
    IN p_idAsignatura INT,
    IN p_semestre INT,
    IN p_calificacion DECIMAL(5,2),
    IN p_fecha DATE
)
BEGIN
    INSERT INTO grade_report (idUser, idAsignatura, semestre, calificacion, fecha)
    VALUES (p_idUser, p_idAsignatura, p_semestre, p_calificacion, p_fecha);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_graduation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_graduation`(
    IN p_idUser VARCHAR(255),
    IN p_tipoTitulacion VARCHAR(255),
    IN p_fechaInicio DATE,
    IN p_fechaFinalizacion DATE,
    IN p_estado VARCHAR(255)
)
BEGIN
    INSERT INTO graduation (idUser, tipoTitulacion, fechaInicio, fechaFinalizacion, estado)
    VALUES (p_idUser, p_tipoTitulacion, p_fechaInicio, p_fechaFinalizacion, p_estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_payment`(
    IN p_idUser VARCHAR(255),
    IN p_tipoPago VARCHAR(255),
    IN p_monto DECIMAL(10,2),
    IN p_fechaPago DATE
)
BEGIN
    INSERT INTO payments (idUser, tipoPago, monto, fechaPago)
    VALUES (p_idUser, p_tipoPago, p_monto, p_fechaPago);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_professional_license` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_professional_license`(
    IN p_idUser VARCHAR(255),
    IN p_numeroCedula VARCHAR(255),
    IN p_fechaExpedicion DATE,
    IN p_autoridad VARCHAR(255)
)
BEGIN
    INSERT INTO professional_license (idUser, numeroCedula, fechaExpedicion, autoridad)
    VALUES (p_idUser, p_numeroCedula, p_fechaExpedicion, p_autoridad);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_reinscripcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_reinscripcion`(
    IN p_idUser VARCHAR(255),
    IN p_semestre INT,
    IN p_fecha DATE,
    IN p_estado VARCHAR(255)
)
BEGIN
    INSERT INTO reinscripcion (idUser, semestre, fecha, estado)
    VALUES (p_idUser, p_semestre, p_fecha, p_estado);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_subject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_subject`(
    IN p_nombre VARCHAR(255),
    IN p_semestre INT,
    IN p_icon_name VARCHAR(255)
)
BEGIN
    INSERT INTO subjects (nombre, semestre, icon_name)
    VALUES (p_nombre, p_semestre, p_icon_name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_teacher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_teacher`(
    IN teacher_name VARCHAR(255),
    IN teacher_enrollment VARCHAR(50)
)
BEGIN
    INSERT INTO teachers (name, enrollment) VALUES (teacher_name, teacher_enrollment);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_user`(
    IN p_idUser VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_lastName VARCHAR(255),
    IN p_nControl INT,
    IN p_rankId INT,
    IN p_semester INT,
    IN p_regular VARCHAR(2),
    IN p_score INT
)
BEGIN
    INSERT INTO user (idUser, password, name, lastName, nControl, rankId, semester, regular, score)
    VALUES (p_idUser, p_password, p_name, p_lastName, p_nControl, p_rankId, p_semester, p_regular, p_score);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_grade_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_grade_report`(
    IN p_idBoleta INT
)
BEGIN
    DELETE FROM grade_report WHERE idBoleta = p_idBoleta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_graduation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_graduation`(
    IN p_idTitulacion INT
)
BEGIN
    DELETE FROM graduation WHERE idTitulacion = p_idTitulacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_payment`(
    IN p_idPago INT
)
BEGIN
    DELETE FROM payments WHERE idPago = p_idPago;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_professional_license` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_professional_license`(
    IN p_idCedula INT
)
BEGIN
    DELETE FROM professional_license WHERE idCedula = p_idCedula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_reinscripcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_reinscripcion`(
    IN p_idReinscripcion INT
)
BEGIN
    DELETE FROM reinscripcion WHERE idReinscripcion = p_idReinscripcion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_subject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_subject`(
    IN p_idAsignatura INT
)
BEGIN
    DELETE FROM subjects WHERE idAsignatura = p_idAsignatura;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_teacher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_teacher`(
    IN teacher_id_param INT
)
BEGIN
    DELETE FROM teachers WHERE teacher_id = teacher_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(
    IN p_idUser VARCHAR(255)
)
BEGIN
    DELETE FROM user WHERE idUser = p_idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUserDetailsById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserDetailsById`(IN in_idUser VARCHAR(255))
BEGIN
    SELECT rankId, name, lastName, nControl
    FROM user
    WHERE idUser = in_idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUsersWithAcademicCredits` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsersWithAcademicCredits`()
BEGIN
    SELECT u.idUser, u.name, u.lastName, c.creditosAcademicos
    FROM user u
    INNER JOIN credits c ON u.idUser = c.idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUsersWithRanks` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsersWithRanks`()
BEGIN
    SELECT u.idUser, u.name, u.lastName, r.type AS rankId
    FROM user u
    INNER JOIN rankuser r ON u.rankId = r.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetUsersWithSubjects` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUsersWithSubjects`()
BEGIN
    SELECT u.idUser, u.name, u.lastName, s.nombre AS subject
    FROM user u
    INNER JOIN user_subject us ON u.idUser = us.idUser
    INNER JOIN subjects s ON us.idAsignatura = s.idAsignatura;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_subjects_and_teachers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_subjects_and_teachers`(IN user_id VARCHAR(255))
BEGIN
    SELECT 
        subject_name,
        teacher_name
    FROM (
        SELECT 
            subjects.nombre AS subject_name,
            (SELECT teachers.name FROM subjects_taught_by_teacher stbt 
             JOIN teachers ON stbt.teacher_id = teachers.teacher_id
             WHERE stbt.subject_id = subjects.idAsignatura
             ORDER BY RAND() LIMIT 1) AS teacher_name
        FROM 
            user_subject
        INNER JOIN subjects ON user_subject.idAsignatura = subjects.idAsignatura
        WHERE 
            user_subject.idUser = user_id
    ) AS subjects_teachers;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_teacher_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_teacher_by_id`(
    IN teacher_id_param INT
)
BEGIN
    SELECT * FROM teachers WHERE teacher_id = teacher_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarAsignaturasParaTodosLosUsuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarAsignaturasParaTodosLosUsuarios`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE userId VARCHAR(255);
    DECLARE userSemester INT;
    DECLARE cur CURSOR FOR SELECT idUser, semester FROM user;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO userId, userSemester;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Eliminar registros previos del usuario en la tabla de asignaturas
        DELETE FROM user_subject WHERE idUser = userId;
        
        -- Insertar las asignaturas correspondientes al semestre del usuario
        INSERT INTO user_subject (idUser, idAsignatura)
        SELECT userId, idAsignatura
        FROM subjects
        WHERE semestre = userSemester;
        
    END LOOP;
    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerAsignaturasPorUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerAsignaturasPorUsuario`(IN in_idUser VARCHAR(255))
BEGIN
    SELECT 
        u.idUser,
        GROUP_CONCAT(s.nombre) as asignaturas
    FROM 
        user u
    JOIN 
        subjects s ON u.semester = s.semestre
    WHERE 
        u.idUser = in_idUser
    GROUP BY 
        u.idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerIconosPorUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerIconosPorUsuario`(IN in_idUser INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE idAsignatura INT;
    DECLARE icon_data LONGBLOB;
    DECLARE icon_name VARCHAR(255);
    
    -- Cursor para obtener las asignaturas del usuario
    DECLARE cur CURSOR FOR
        SELECT idAsignatura
        FROM user_subject
        WHERE idUser = in_idUser;
        
    -- Cursor para obtener los iconos de las asignaturas
    DECLARE cur_icons CURSOR FOR
        SELECT icon_data, icon_name
        FROM subject_icons
        WHERE idAsignatura = idAsignatura;
    
    -- Crear tabla temporal para almacenar los resultados
    CREATE TEMPORARY TABLE temp_iconos_por_usuario (
        idUser INT,
        icon_data LONGBLOB,
        icon_name VARCHAR(255)
    );
    
    -- Abrir el cursor de asignaturas del usuario
    OPEN cur;
    
    read_loop: LOOP
        -- Obtener la siguiente asignatura del cursor
        FETCH cur INTO idAsignatura;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Abrir el cursor de iconos para la asignatura actual
        OPEN cur_icons;
        fetch_loop: LOOP
            -- Obtener los iconos de la asignatura actual
            FETCH cur_icons INTO icon_data, icon_name;
            IF done THEN
                LEAVE fetch_loop;
            END IF;
            
            -- Insertar los iconos en la tabla temporal
            INSERT INTO temp_iconos_por_usuario (idUser, icon_data, icon_name)
            VALUES (in_idUser, icon_data, icon_name);
        END LOOP;
        CLOSE cur_icons;
    END LOOP;
    
    CLOSE cur;
    
    -- Retornar los iconos por usuario
    SELECT *
    FROM temp_iconos_por_usuario;
    
    -- Limpiar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS temp_iconos_por_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_credit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_credit`(
    IN p_idCredito INT
)
BEGIN
    SELECT * FROM credits WHERE idCredito = p_idCredito;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_grade_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_grade_report`(
    IN p_idBoleta INT
)
BEGIN
    SELECT * FROM grade_report WHERE idBoleta = p_idBoleta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_graduation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_graduation`(
    IN p_idTitulacion INT
)
BEGIN
    SELECT * FROM graduation WHERE idTitulacion = p_idTitulacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_payment`(
    IN p_idPago INT
)
BEGIN
    SELECT * FROM payments WHERE idPago = p_idPago;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_professional_license` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_professional_license`(
    IN p_idCedula INT
)
BEGIN
    SELECT * FROM professional_license WHERE idCedula = p_idCedula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_reinscripcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_reinscripcion`(
    IN p_idReinscripcion INT
)
BEGIN
    SELECT * FROM reinscripcion WHERE idReinscripcion = p_idReinscripcion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_subject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_subject`(
    IN p_idAsignatura INT
)
BEGIN
    SELECT * FROM subjects WHERE idAsignatura = p_idAsignatura;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `read_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_user`(
    IN p_idUser VARCHAR(255)
)
BEGIN
    SELECT * FROM user WHERE idUser = p_idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `restore_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_table`(IN table_name VARCHAR(255))
BEGIN
    DECLARE backup_table_name VARCHAR(255);
    DECLARE error_message VARCHAR(255); -- Declaración de la variable fuera del bloque IF

    SET backup_table_name = CONCAT(table_name, '_backup');

    -- Verificar si la tabla de respaldo existe
    IF NOT EXISTS (SELECT * FROM information_schema.tables WHERE table_name = backup_table_name) THEN
        SET error_message = CONCAT('No se puede restaurar la tabla ', table_name, ' porque no existe una tabla de respaldo.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    ELSE
        -- Eliminar datos de la tabla original
        SET @truncate_table_sql = CONCAT('TRUNCATE TABLE ', table_name);
        PREPARE truncate_table_stmt FROM @truncate_table_sql;
        EXECUTE truncate_table_stmt;
        DEALLOCATE PREPARE truncate_table_stmt;

        -- Insertar datos desde la tabla de respaldo a la tabla original
        SET @restore_data_sql = CONCAT('INSERT INTO ', table_name, ' SELECT * FROM ', backup_table_name);
        PREPARE restore_data_stmt FROM @restore_data_sql;
        EXECUTE restore_data_stmt;
        DEALLOCATE PREPARE restore_data_stmt;

        SELECT CONCAT('La tabla ', table_name, ' se ha restaurado correctamente desde ', backup_table_name) AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_grade_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_grade_report`(
    IN p_idBoleta INT,
    IN p_idUser VARCHAR(255),
    IN p_idAsignatura INT,
    IN p_semestre INT,
    IN p_calificacion DECIMAL(5,2),
    IN p_fecha DATE
)
BEGIN
    UPDATE grade_report
    SET idUser = p_idUser,
        idAsignatura = p_idAsignatura,
        semestre = p_semestre,
        calificacion = p_calificacion,
        fecha = p_fecha
    WHERE idBoleta = p_idBoleta;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_graduation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_graduation`(
    IN p_idTitulacion INT,
    IN p_idUser VARCHAR(255),
    IN p_tipoTitulacion VARCHAR(255),
    IN p_fechaInicio DATE,
    IN p_fechaFinalizacion DATE,
    IN p_estado VARCHAR(255)
)
BEGIN
    UPDATE graduation
    SET idUser = p_idUser,
        tipoTitulacion = p_tipoTitulacion,
        fechaInicio = p_fechaInicio,
        fechaFinalizacion = p_fechaFinalizacion,
        estado = p_estado
    WHERE idTitulacion = p_idTitulacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_payment`(
    IN p_idPago INT,
    IN p_idUser VARCHAR(255),
    IN p_tipoPago VARCHAR(255),
    IN p_monto DECIMAL(10,2),
    IN p_fechaPago DATE
)
BEGIN
    UPDATE payments
    SET idUser = p_idUser,
        tipoPago = p_tipoPago,
        monto = p_monto,
        fechaPago = p_fechaPago
    WHERE idPago = p_idPago;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_professional_license` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_professional_license`(
    IN p_idCedula INT,
    IN p_idUser VARCHAR(255),
    IN p_numeroCedula VARCHAR(255),
    IN p_fechaExpedicion DATE,
    IN p_autoridad VARCHAR(255)
)
BEGIN
    UPDATE professional_license
    SET idUser = p_idUser,
        numeroCedula = p_numeroCedula,
        fechaExpedicion = p_fechaExpedicion,
        autoridad = p_autoridad
    WHERE idCedula = p_idCedula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_reinscripcion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_reinscripcion`(
    IN p_idReinscripcion INT,
    IN p_idUser VARCHAR(255),
    IN p_semestre INT,
    IN p_fecha DATE,
    IN p_estado VARCHAR(255)
)
BEGIN
    UPDATE reinscripcion
    SET idUser = p_idUser,
        semestre = p_semestre,
        fecha = p_fecha,
        estado = p_estado
    WHERE idReinscripcion = p_idReinscripcion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_subject` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_subject`(
    IN p_idAsignatura INT,
    IN p_nombre VARCHAR(255),
    IN p_semestre INT,
    IN p_icon_name VARCHAR(255)
)
BEGIN
    UPDATE subjects
    SET nombre = p_nombre,
        semestre = p_semestre,
        icon_name = p_icon_name
    WHERE idAsignatura = p_idAsignatura;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_teacher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_teacher`(
    IN teacher_id_param INT,
    IN new_name VARCHAR(255),
    IN new_enrollment VARCHAR(50)
)
BEGIN
    UPDATE teachers SET name = new_name, enrollment = new_enrollment WHERE teacher_id = teacher_id_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user`(
    IN p_idUser VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_lastName VARCHAR(255),
    IN p_nControl INT,
    IN p_rankId INT,
    IN p_semester INT,
    IN p_regular VARCHAR(2),
    IN p_score INT
)
BEGIN
    UPDATE user
    SET password = p_password,
        name = p_name,
        lastName = p_lastName,
        nControl = p_nControl,
        rankId = p_rankId,
        semester = p_semester,
        regular = p_regular,
        score = p_score
    WHERE idUser = p_idUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `estudiantesporsemestre`
--

/*!50001 DROP VIEW IF EXISTS `estudiantesporsemestre`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `estudiantesporsemestre` AS select `user`.`semester` AS `semester`,count(0) AS `cantidad_estudiantes` from `user` group by `user`.`semester` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `estudiantesregulares`
--

/*!50001 DROP VIEW IF EXISTS `estudiantesregulares`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `estudiantesregulares` AS select `user`.`idUser` AS `idUser`,`user`.`password` AS `password`,`user`.`name` AS `name`,`user`.`lastName` AS `lastName`,`user`.`nControl` AS `nControl`,`user`.`rankId` AS `rankId`,`user`.`semester` AS `semester`,`user`.`regular` AS `regular` from `user` where (`user`.`regular` = 'Si') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacher_subject_view`
--

/*!50001 DROP VIEW IF EXISTS `teacher_subject_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teacher_subject_view` AS select `t`.`name` AS `teacher_name`,`t`.`enrollment` AS `enrollment`,`s`.`nombre` AS `subject_name` from ((`teachers` `t` join `subjects_taught_by_teacher` `st` on((`t`.`teacher_id` = `st`.`teacher_id`))) join `subjects` `s` on((`st`.`subject_id` = `s`.`idAsignatura`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usercredits`
--

/*!50001 DROP VIEW IF EXISTS `usercredits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usercredits` AS select `credits`.`idUser` AS `idUser`,`credits`.`semestre` AS `semestre`,`credits`.`creditosAcademicos` AS `creditosAcademicos`,`credits`.`creditosExtraescolares` AS `creditosExtraescolares` from `credits` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `userdetails`
--

/*!50001 DROP VIEW IF EXISTS `userdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userdetails` AS select `user`.`idUser` AS `idUser`,`user`.`name` AS `name`,`user`.`lastName` AS `lastName`,`user`.`nControl` AS `nControl`,`user`.`semester` AS `semester`,`user`.`regular` AS `regular` from `user` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usergradereport`
--

/*!50001 DROP VIEW IF EXISTS `usergradereport`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usergradereport` AS select `grade_report`.`idBoleta` AS `idBoleta`,`grade_report`.`idUser` AS `idUser`,`grade_report`.`idAsignatura` AS `idAsignatura`,`grade_report`.`semestre` AS `semestre`,`grade_report`.`calificacion` AS `calificacion`,`grade_report`.`fecha` AS `fecha` from `grade_report` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usergraduations`
--

/*!50001 DROP VIEW IF EXISTS `usergraduations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usergraduations` AS select `graduation`.`idTitulacion` AS `idTitulacion`,`graduation`.`idUser` AS `idUser`,`graduation`.`tipoTitulacion` AS `tipoTitulacion`,`graduation`.`fechaInicio` AS `fechaInicio`,`graduation`.`fechaFinalizacion` AS `fechaFinalizacion`,`graduation`.`estado` AS `estado` from `graduation` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `userprofessionallicenses`
--

/*!50001 DROP VIEW IF EXISTS `userprofessionallicenses`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userprofessionallicenses` AS select `professional_license`.`idCedula` AS `idCedula`,`professional_license`.`idUser` AS `idUser`,`professional_license`.`numeroCedula` AS `numeroCedula`,`professional_license`.`fechaExpedicion` AS `fechaExpedicion`,`professional_license`.`autoridad` AS `autoridad` from `professional_license` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `userreinscriptions`
--

/*!50001 DROP VIEW IF EXISTS `userreinscriptions`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `userreinscriptions` AS select `reinscripcion`.`idReinscripcion` AS `idReinscripcion`,`reinscripcion`.`idUser` AS `idUser`,`reinscripcion`.`semestre` AS `semestre`,`reinscripcion`.`fecha` AS `fecha`,`reinscripcion`.`estado` AS `estado` from `reinscripcion` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `usersubjects`
--

/*!50001 DROP VIEW IF EXISTS `usersubjects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usersubjects` AS select `u`.`idUser` AS `idUser`,`u`.`name` AS `name`,`u`.`lastName` AS `lastName`,`s`.`nombre` AS `asignatura`,`s`.`semestre` AS `semestre` from ((`user` `u` join `user_subject` `us` on((`u`.`idUser` = `us`.`idUser`))) join `subjects` `s` on((`us`.`idAsignatura` = `s`.`idAsignatura`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_detailed_grade_report`
--

/*!50001 DROP VIEW IF EXISTS `view_detailed_grade_report`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_detailed_grade_report` AS select `g`.`idBoleta` AS `idBoleta`,`u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,`s`.`idAsignatura` AS `idAsignatura`,`s`.`nombre` AS `nombre_asignatura`,`s`.`semestre` AS `semestre`,`g`.`calificacion` AS `calificacion`,`g`.`fecha` AS `fecha` from ((`grade_report` `g` join `subjects` `s` on((`g`.`idAsignatura` = `s`.`idAsignatura`))) join `user` `u` on((`g`.`idUser` = `u`.`idUser`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_graduated_users`
--

/*!50001 DROP VIEW IF EXISTS `view_graduated_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_graduated_users` AS select `g`.`idTitulacion` AS `idTitulacion`,`u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,`g`.`tipoTitulacion` AS `tipoTitulacion`,`g`.`fechaFinalizacion` AS `fechaFinalizacion` from (`graduation` `g` join `user` `u` on((`g`.`idUser` = `u`.`idUser`))) where (`g`.`estado` = 'Graduado') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_professional_license`
--

/*!50001 DROP VIEW IF EXISTS `view_professional_license`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_professional_license` AS select `pl`.`idCedula` AS `idCedula`,`u`.`idUser` AS `idUser`,`u`.`name` AS `name`,`u`.`lastName` AS `lastName`,`pl`.`numeroCedula` AS `numeroCedula`,`pl`.`fechaExpedicion` AS `fechaExpedicion`,`pl`.`autoridad` AS `autoridad` from (`professional_license` `pl` join `user` `u` on((`pl`.`idUser` = `u`.`idUser`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_reinscripcion`
--

/*!50001 DROP VIEW IF EXISTS `view_reinscripcion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_reinscripcion` AS select `r`.`idReinscripcion` AS `idReinscripcion`,`u`.`idUser` AS `idUser`,`u`.`name` AS `name`,`u`.`lastName` AS `lastName`,`r`.`semestre` AS `semestre`,`r`.`fecha` AS `fecha`,`r`.`estado` AS `estado` from (`reinscripcion` `r` join `user` `u` on((`r`.`idUser` = `u`.`idUser`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_subjects_by_semester`
--

/*!50001 DROP VIEW IF EXISTS `view_subjects_by_semester`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_subjects_by_semester` AS select `s`.`semestre` AS `semestre`,group_concat(`s`.`nombre` order by `s`.`nombre` ASC separator ', ') AS `asignaturas` from `subjects` `s` group by `s`.`semestre` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_user_payments`
--

/*!50001 DROP VIEW IF EXISTS `view_user_payments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_user_payments` AS select `u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,count(`p`.`idPago`) AS `total_pagos`,sum(`p`.`monto`) AS `total_monto_pagado` from (`user` `u` left join `payments` `p` on((`u`.`idUser` = `p`.`idUser`))) group by `u`.`idUser` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_user_subject_info`
--

/*!50001 DROP VIEW IF EXISTS `view_user_subject_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_user_subject_info` AS select `u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,`u`.`semester` AS `semester`,`s`.`idAsignatura` AS `idAsignatura`,`s`.`nombre` AS `nombre_asignatura`,`s`.`semestre` AS `semestre_asignatura` from ((`user` `u` join `user_subject` `us` on((`u`.`idUser` = `us`.`idUser`))) join `subjects` `s` on((`us`.`idAsignatura` = `s`.`idAsignatura`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_users_with_completed_credits`
--

/*!50001 DROP VIEW IF EXISTS `view_users_with_completed_credits`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_users_with_completed_credits` AS select `u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,sum(`c`.`creditosAcademicos`) AS `total_creditos_academicos` from (`user` `u` join `credits` `c` on((`u`.`idUser` = `c`.`idUser`))) group by `u`.`idUser` having (`total_creditos_academicos` >= 200) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_users_with_passing_grades`
--

/*!50001 DROP VIEW IF EXISTS `view_users_with_passing_grades`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_users_with_passing_grades` AS select `u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,avg(`g`.`calificacion`) AS `promedio_calificaciones` from (`user` `u` join `grade_report` `g` on((`u`.`idUser` = `g`.`idUser`))) where (`g`.`calificacion` >= 70) group by `u`.`idUser` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_users_with_recent_payments`
--

/*!50001 DROP VIEW IF EXISTS `view_users_with_recent_payments`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_users_with_recent_payments` AS select `p`.`idPago` AS `idPago`,`u`.`idUser` AS `idUser`,concat(`u`.`name`,' ',`u`.`lastName`) AS `student_name`,`p`.`tipoPago` AS `tipoPago`,`p`.`monto` AS `monto`,`p`.`fechaPago` AS `fechaPago` from (`payments` `p` join `user` `u` on((`p`.`idUser` = `u`.`idUser`))) where (`p`.`fechaPago` >= (curdate() - interval 1 month)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_aprobados_reprobados`
--

/*!50001 DROP VIEW IF EXISTS `vista_aprobados_reprobados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_aprobados_reprobados` AS select `user`.`name` AS `name`,`user`.`lastName` AS `lastName`,`user`.`semester` AS `semester`,(case when (`user`.`score` >= 70) then 'Aprobado' else 'Reprobado' end) AS `Estado` from `user` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-03 13:04:54
