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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credits`
--

LOCK TABLES `credits` WRITE;
/*!40000 ALTER TABLE `credits` DISABLE KEYS */;
INSERT INTO `credits` VALUES (1,'anatorres',5,24,10),(2,'Block',6,28,8),(3,'carlasmith',5,25,6),(4,'carlosramirez',7,30,12),(5,'danielruiz',5,23,5),(6,'eduardogarcia',4,20,10),(7,'javiermartinez',7,28,9),(8,'juanperez',6,26,7),(9,'juliamartinez',7,29,8),(10,'lauragonzalez',4,22,6);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'anatorres','Inscripción',1660.21,'2024-01-01'),(2,'Block','Inscripción',1588.85,'2024-01-01'),(3,'carlasmith','Inscripción',963.59,'2024-01-01'),(4,'carlosramirez','Inscripción',51.43,'2024-01-01'),(5,'danielruiz','Inscripción',1366.35,'2024-01-01'),(6,'eduardogarcia','Inscripción',677.49,'2024-01-01'),(7,'existinguser','Inscripción',1288.39,'2024-01-01'),(8,'javiermartinez','Inscripción',409.50,'2024-01-01'),(9,'juanperez','Inscripción',182.30,'2024-01-01'),(10,'juliamartinez','Inscripción',1683.02,'2024-01-01');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professional_license`
--

LOCK TABLES `professional_license` WRITE;
/*!40000 ALTER TABLE `professional_license` DISABLE KEYS */;
INSERT INTO `professional_license` VALUES (1,'anatorres','CEDanatorres','2025-01-01','SEP'),(2,'Block','CEDBlock','2025-01-01','SEP'),(3,'carlasmith','CEDcarlasmith','2025-01-01','SEP'),(4,'carlosramirez','CEDcarlosramirez','2025-01-01','SEP'),(5,'danielruiz','CEDdanielruiz','2025-01-01','SEP'),(6,'eduardogarcia','CEDeduardogarcia','2025-01-01','SEP'),(7,'existinguser','CEDexistinguser','2025-01-01','SEP'),(8,'javiermartinez','CEDjaviermartinez','2025-01-01','SEP'),(9,'juanperez','CEDjuanperez','2025-01-01','SEP'),(10,'juliamartinez','CEDjuliamartinez','2025-01-01','SEP');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `idAsignatura` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `semestre` int NOT NULL,
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
INSERT INTO `subjects` VALUES (1,'Matemáticas I',1),(2,'Física I',1),(3,'Introducción a la Programación',1),(4,'Álgebra Lineal',1),(5,'Cálculo I',1),(6,'Programación Orientada a Objetos',2),(7,'Estructuras de Datos',2),(8,'Cálculo II',2),(9,'Bases de Datos',2),(10,'Análisis y Diseño de Algoritmos',2),(11,'Redes de Computadoras',3),(12,'Sistemas Operativos',3),(13,'Diseño de Interfaces de Usuario',3),(14,'Programación Web',3),(15,'Lenguajes de Programación',3),(16,'Inteligencia Artificial',4),(17,'Ingeniería de Software',4),(18,'Gestión de Proyectos de Software',4),(19,'Desarrollo Ágil',4),(20,'Seguridad Informática',4),(21,'Bases de Datos Avanzadas',5),(22,'Computación en la Nube',5),(23,'Big Data',5),(24,'Análisis Predictivo',5),(25,'Machine Learning',5),(26,'Desarrollo de Aplicaciones Móviles',6),(27,'Realidad Virtual y Aumentada',6),(28,'Blockchain',6),(29,'IoT y Sistemas Embebidos',6),(30,'Robótica',6),(31,'E-commerce y Marketing Digital',7),(32,'Business Intelligence',7),(33,'Gestión de la Cadena de Suministro',7),(34,'Customer Relationship Management',7),(35,'Gestión de la Calidad Total',7),(36,'Innovación y Emprendimiento',8),(37,'Ética y Responsabilidad Social',8),(38,'Liderazgo y Trabajo en Equipo',8),(39,'Comunicación Efectiva',8),(40,'Negociación y Resolución de Conflictos',8),(41,'Gestión Estratégica',9),(42,'Planificación Financiera',9),(43,'Gestión del Cambio Organizacional',9),(44,'Dirección de Proyectos',9),(45,'Marketing Estratégico',9);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
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
INSERT INTO `user` VALUES ('anatorres','An@T0rr3s','Ana','Torres',21080345,2,5,'Si',64),('Block','123','Alexis','Hurtado',21070012,2,6,'Si',72),('carlasmith','C@rl@Sm1th','Carla','Smith',21080890,2,5,'Si',71),('carlosramirez','C@rlosR@m1rez','Carlos','Ramirez',21090078,2,7,'Si',78),('danielruiz','D@ni3lRu!z','Daniel','Ruiz',21080789,2,5,'No',77),('eduardogarcia','3du@rd0G@rc1@','Eduardo','Garcia',21060901,2,4,'No',92),('existinguser','password123','Jane','Smith',987654321,2,NULL,'Si',87),('javiermartinez','J@vierM@rt1nez','Javier','Martinez',21090456,2,7,'Si',60),('juanperez','juAnP@ssw0rd','Juan','Perez',21070012,2,6,'Si',100),('juliamartinez','Juli@M@rt1nez','Julia','Martinez',21090567,2,7,'Si',99),('lauragonzalez','l@ur@G0nz','Laura','Gonzalez',21060123,2,4,'No',96),('luciamartinez','luci@M@rt1nez','Lucia','Martinez',21090123,2,7,'No',79),('luisfernandez','lui$F3rn@nd3z','Luis','Fernandez',21060567,2,4,'No',88),('mariagomez','m@ri@G0mez123','Maria','Gomez',21080045,2,5,'No',64),('monicagonzalez','M0nic@G0nz@l3z','Monica','Gonzalez',21071012,2,6,'Si',76),('nataliacastro','N@tali@c@str0','Natalia','Castro',21070678,2,6,'Si',90),('newuser','password123','John','Doe',123456789,2,NULL,'Si',78),('oscarrodriguez','0$carR0dr1gu3z','Oscar','Rodriguez',21080456,2,5,'No',60),('patriciadiaz','P@trici@d1@z','Patricia','Diaz',21070345,2,6,'Si',91),('pedrolopez','P3dr0L0pez!','Pedro','Lopez',21070234,2,6,'No',93),('raullopez','R@ulL0pez','Raul','Lopez',21060678,2,4,'No',92),('sergiohernandez','S3rgioH3rn@ndez','Sergio','Hernandez',21060234,2,4,'Si',78),('valerialopez','v@l3r1@l0pez','Valeria','Lopez',21070789,2,6,'No',95);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `user_subject` VALUES ('anatorres',21),('anatorres',22),('anatorres',23),('anatorres',24),('anatorres',25);
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

-- Dump completed on 2024-04-01 18:26:26
