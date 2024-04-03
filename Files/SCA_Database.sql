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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
INSERT INTO `user` VALUES ('anatorres','An@T0rr3s','Ana','Torres',21080345,2,5,'Si',64),('Block','123','Alexis','Hurtado',21070012,2,6,'Si',72),('carlasmith','C@rl@Sm1th','Carla','Smith',21080890,2,5,'Si',71),('carlosramirez','C@rlosR@m1rez','Carlos','Ramirez',21090078,2,7,'Si',78),('danielruiz','D@ni3lRu!z','Daniel','Ruiz',21080789,2,5,'No',77),('eduardogarcia','3du@rd0G@rc1@','Eduardo','Garcia',21060901,2,4,'No',92),('existinguser','password123','Jane','Smith',987654321,2,4,'Si',87),('javiermartinez','J@vierM@rt1nez','Javier','Martinez',21090456,2,7,'Si',60),('juanperez','juAnP@ssw0rd','Juan','Perez',21070012,2,6,'Si',100),('juliamartinez','Juli@M@rt1nez','Julia','Martinez',21090567,2,7,'Si',99),('lauragonzalez','l@ur@G0nz','Laura','Gonzalez',21060123,2,4,'No',96),('luciamartinez','luci@M@rt1nez','Lucia','Martinez',21090123,2,7,'No',79),('luisfernandez','lui$F3rn@nd3z','Luis','Fernandez',21060567,2,4,'No',88),('mariagomez','m@ri@G0mez123','Maria','Gomez',21080045,2,5,'No',64),('McBlockier','1234','Alexis','Lopez',21070012,2,6,'Si',100),('monicagonzalez','M0nic@G0nz@l3z','Monica','Gonzalez',21071012,2,6,'Si',76),('nataliacastro','N@tali@c@str0','Natalia','Castro',21070678,2,6,'Si',90),('newuser','password123','John','Doe',123456789,2,6,'Si',78),('oscarrodriguez','0$carR0dr1gu3z','Oscar','Rodriguez',21080456,2,5,'No',60),('patriciadiaz','P@trici@d1@z','Patricia','Diaz',21070345,2,6,'Si',91),('pedrolopez','P3dr0L0pez!','Pedro','Lopez',21070234,2,6,'No',93),('raullopez','R@ulL0pez','Raul','Lopez',21060678,2,4,'No',92),('sergiohernandez','S3rgioH3rn@ndez','Sergio','Hernandez',21060234,2,4,'Si',78),('valerialopez','v@l3r1@l0pez','Valeria','Lopez',21070789,2,6,'No',95);
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

-- Dump completed on 2024-04-03 10:55:21
