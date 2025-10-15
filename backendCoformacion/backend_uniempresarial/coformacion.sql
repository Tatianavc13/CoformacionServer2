-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coformacion1
-- ------------------------------------------------------
-- Server version	9.3.0

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
-- Base de datos: `coformacion1`
--
drop database if exists coformacion1;
CREATE DATABASE coformacion1;
USE coformacion1;
-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendario_actividades`
--

DROP TABLE IF EXISTS `calendario_actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendario_actividades` (
  `actividad_id` int NOT NULL AUTO_INCREMENT,
  `tipo_act_id` int NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `proceso_id` int DEFAULT NULL,
  `ubicacion` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` enum('Pendiente','En Proceso','Completada','Cancelada') COLLATE utf8mb4_spanish_ci DEFAULT 'Pendiente',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actividad_id`),
  KEY `tipo_act_id` (`tipo_act_id`),
  KEY `proceso_id` (`proceso_id`),
  KEY `idx_calendario_fechas` (`fecha_inicio`,`fecha_fin`,`estado`),
  CONSTRAINT `calendario_actividades_ibfk_1` FOREIGN KEY (`tipo_act_id`) REFERENCES `tipos_actividad` (`tipo_act_id`) ON DELETE RESTRICT,
  CONSTRAINT `calendario_actividades_ibfk_2` FOREIGN KEY (`proceso_id`) REFERENCES `procesos_coformacion` (`proceso_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario_actividades`
--

LOCK TABLES `calendario_actividades` WRITE;
/*!40000 ALTER TABLE `calendario_actividades` DISABLE KEYS */;
INSERT INTO `calendario_actividades` VALUES (1,1,'Capacitación Inicial','Inducción al sistema y normas','2024-06-10 08:00:00','2024-06-10 12:00:00',1,'Auditorio Principal','Pendiente','2025-06-11 23:00:10','2025-06-11 23:00:10'),(2,2,'Seguimiento Primer Mes','Evaluación de desempeño','2024-07-10 10:00:00','2024-07-10 12:00:00',1,'Sala de reuniones','Pendiente','2025-06-11 23:00:10','2025-06-11 23:00:10');
/*!40000 ALTER TABLE `calendario_actividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos_empresa`
--

DROP TABLE IF EXISTS `contactos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contactos_empresa` (
  `contacto_id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `cargo` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `area` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `celular` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `tipo` enum('Prácticas','Talento Humano','Tutor','Otros') COLLATE utf8mb4_spanish_ci NOT NULL,
  `es_principal` tinyint(1) DEFAULT '0',
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`contacto_id`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `contactos_empresa_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos_empresa`
--

LOCK TABLES `contactos_empresa` WRITE;
/*!40000 ALTER TABLE `contactos_empresa` DISABLE KEYS */;
INSERT INTO `contactos_empresa` VALUES (1,1,'Laura Gómez','Coordinadora TI','Tecnología','6013214567','3009876543','laura@soldigital.com','Tutor',1,1,'2025-06-11 23:00:10','2025-06-11 23:00:10'),(2,2,'Carlos Ramírez','Director Académico','Académica','6024567890','3101234567','carlos@ileduc.org','Prácticas',1,1,'2025-06-11 23:00:10','2025-06-11 23:00:10');
/*!40000 ALTER TABLE `contactos_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-12 04:10:36.976963'),(2,'auth','0001_initial','2025-06-12 04:10:37.401060'),(3,'admin','0001_initial','2025-06-12 04:10:37.639153'),(4,'admin','0002_logentry_remove_auto_add','2025-06-12 04:10:37.646155'),(5,'admin','0003_logentry_add_action_flag_choices','2025-06-12 04:10:37.652155'),(6,'contenttypes','0002_remove_content_type_name','2025-06-12 04:10:37.742864'),(7,'auth','0002_alter_permission_name_max_length','2025-06-12 04:10:37.793801'),(8,'auth','0003_alter_user_email_max_length','2025-06-12 04:10:37.815806'),(9,'auth','0004_alter_user_username_opts','2025-06-12 04:10:37.821808'),(10,'auth','0005_alter_user_last_login_null','2025-06-12 04:10:37.872819'),(11,'auth','0006_require_contenttypes_0002','2025-06-12 04:10:37.874820'),(12,'auth','0007_alter_validators_add_error_messages','2025-06-12 04:10:37.880820'),(13,'auth','0008_alter_user_username_max_length','2025-06-12 04:10:37.934817'),(14,'auth','0009_alter_user_last_name_max_length','2025-06-12 04:10:37.990820'),(15,'auth','0010_alter_group_name_max_length','2025-06-12 04:10:38.007823'),(16,'auth','0011_update_proxy_permissions','2025-06-12 04:10:38.014824'),(17,'auth','0012_alter_user_first_name_max_length','2025-06-12 04:10:38.065836'),(18,'sessions','0001_initial','2025-06-12 04:10:38.096855');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_proceso`
--

DROP TABLE IF EXISTS `documentos_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documentos_proceso` (
  `documento_id` int NOT NULL AUTO_INCREMENT,
  `proceso_id` int NOT NULL,
  `tipo_doc_id` int NOT NULL,
  `url_documento` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_envio` datetime NOT NULL,
  `fecha_revision` datetime DEFAULT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  `estado` enum('Pendiente','En Revisión','Aprobado','Devuelto') COLLATE utf8mb4_spanish_ci DEFAULT 'Pendiente',
  `observaciones` text COLLATE utf8mb4_spanish_ci,
  `revisado_por` int DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`documento_id`),
  KEY `proceso_id` (`proceso_id`),
  KEY `revisado_por` (`revisado_por`),
  KEY `idx_documentos_estado` (`estado`,`fecha_envio`),
  KEY `idx_docs_tipo_estado` (`tipo_doc_id`,`estado`),
  CONSTRAINT `documentos_proceso_ibfk_1` FOREIGN KEY (`proceso_id`) REFERENCES `procesos_coformacion` (`proceso_id`) ON DELETE RESTRICT,
  CONSTRAINT `documentos_proceso_ibfk_2` FOREIGN KEY (`tipo_doc_id`) REFERENCES `tipos_documento` (`tipo_doc_id`) ON DELETE RESTRICT,
  CONSTRAINT `documentos_proceso_ibfk_3` FOREIGN KEY (`revisado_por`) REFERENCES `roles` (`rol_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_proceso`
--

LOCK TABLES `documentos_proceso` WRITE;
/*!40000 ALTER TABLE `documentos_proceso` DISABLE KEYS */;
INSERT INTO `documentos_proceso` VALUES (1,1,1,'https://uni.edu.co/docs/carta_presentacion_maria.pdf','2024-06-01 00:00:00',NULL,NULL,'Pendiente',NULL,NULL,'2025-06-11 23:00:10','2025-06-11 23:00:10'),(2,1,2,'https://uni.edu.co/docs/convenio_maria.pdf','2024-06-03 00:00:00',NULL,NULL,'Pendiente',NULL,NULL,'2025-06-11 23:00:10','2025-06-11 23:00:10'),(3,2,1,'https://uni.edu.co/docs/carta_presentacion_juan.pdf','2024-06-05 00:00:00',NULL,NULL,'Pendiente',NULL,NULL,'2025-06-11 23:00:10','2025-06-11 23:00:10');
/*!40000 ALTER TABLE `documentos_proceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `empresa_id` int NOT NULL AUTO_INCREMENT,
  `razon_social` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre_comercial` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `sector_id` int NOT NULL,
  `tamano_id` int NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `ciudad` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `departamento` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `sitio_web` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `cuota_sena` int DEFAULT NULL,
  `numero_empleados` int DEFAULT NULL,
  `estado_convenio` enum('Vigente','No Vigente','En Trámite') COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'En Trámite',
  `fecha_convenio` date DEFAULT NULL,
  `convenio_url` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `actividad_economica` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `horario_laboral` text COLLATE utf8mb4_spanish_ci,
  `trabaja_sabado` tinyint(1) DEFAULT '0',
  `observaciones` text COLLATE utf8mb4_spanish_ci,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nit` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`empresa_id`),
  KEY `tamano_id` (`tamano_id`),
  KEY `idx_empresa_sector` (`sector_id`,`estado_convenio`),
  KEY `idx_empresa_estado` (`estado_convenio`,`estado`),
  CONSTRAINT `empresas_ibfk_1` FOREIGN KEY (`sector_id`) REFERENCES `sectores_economicos` (`sector_id`) ON DELETE RESTRICT,
  CONSTRAINT `empresas_ibfk_2` FOREIGN KEY (`tamano_id`) REFERENCES `tamanos_empresa` (`tamano_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'Soluciones Digitales S.A.S.','SolDigital',1,3,'Av. Siempre Viva 101','Bogotá','Cundinamarca','6011234567','https://soldigital.com',5,120,'Vigente','2023-03-15','https://soldigital.com/convenio.pdf','Desarrollo de software','Lunes a viernes 8am-5pm',0,NULL,1,'2025-06-11 23:00:10','2025-06-11 23:00:10',NULL),(2,'Instituto Latino de Educación','ILEDUC',2,2,'Calle 50 #30-40','Cali','Valle','6029876543','https://ileduc.org',3,40,'En Trámite',NULL,NULL,'Servicios educativos','Lunes a viernes 7am-4pm',0,NULL,1,'2025-06-11 23:00:10','2025-06-11 23:00:10',NULL),(9,'Constructora El Pilar S.A.S','El Pilar',1,2,'Calle 123 #45-67','Bogotá','Cundinamarca','3101234567','https://elpilar.com/',1,120,'Vigente','2024-01-15','https://elpilar.com/convenio.pdf','Construcción de obras de ingeniería civil','Lunes a viernes, 8:00 a.m. - 5:00 p.m.',0,NULL,1,'2025-06-12 01:38:20','2025-06-12 01:44:39','9001234567'),(10,'Industrias La Montaña S.A.','La Montaña',2,3,'Carrera 10 #20-30','Medellín','Antioquia','6041234567','https://lamontana.com/',1,350,'Vigente','2023-11-10','https://lamontana.com/convenio.pdf','Fabricación de productos alimenticios','Turnos rotativos',0,NULL,1,'2025-06-12 01:38:20','2025-06-12 01:38:20','800987654-3'),(11,'Transportes Nacionales Ltda.','TransNac',2,1,'Av. Las Palmas #30-50','Cali','Valle del Cauca','3029876543','https://tnl.com.co/',0,45,'En Trámite','2022-05-20','https://tnl.com.co/convenio.pdf','Transporte terrestre de carga','Lunes a sábado, 7:00 a.m. - 6:00 p.m.',0,NULL,1,'2025-06-12 01:38:20','2025-06-12 01:38:20','901222333-1');
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados_cartera`
--

DROP TABLE IF EXISTS `estados_cartera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados_cartera` (
  `estado_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`estado_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados_cartera`
--

LOCK TABLES `estados_cartera` WRITE;
/*!40000 ALTER TABLE `estados_cartera` DISABLE KEYS */;
INSERT INTO `estados_cartera` VALUES (1,'Al día'),(3,'Mora grave'),(2,'Mora leve');
/*!40000 ALTER TABLE `estados_cartera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados_proceso`
--

DROP TABLE IF EXISTS `estados_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados_proceso` (
  `estado_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `color` varchar(7) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `orden` int NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`estado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados_proceso`
--

LOCK TABLES `estados_proceso` WRITE;
/*!40000 ALTER TABLE `estados_proceso` DISABLE KEYS */;
INSERT INTO `estados_proceso` VALUES (1,'Pendiente','Proceso iniciado','#FFA500',1,1,'2025-06-11 22:47:33'),(2,'En Revisión','Documentos en revisión','#FFD700',2,1,'2025-06-11 22:47:33'),(3,'Aprobado','Proceso aprobado','#32CD32',3,1,'2025-06-11 22:47:33'),(4,'Rechazado','Proceso no aprobado','#FF0000',4,1,'2025-06-11 22:47:33'),(5,'Finalizado','Proceso completado','#4169E1',5,1,'2025-06-11 22:47:33');
/*!40000 ALTER TABLE `estados_proceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes` (
  `estudiante_id` int NOT NULL AUTO_INCREMENT,
  `codigo_estudiante` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre_completo` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `tipo_documento` enum('CC','CE','PAS','TI') COLLATE utf8mb4_spanish_ci NOT NULL,
  `numero_documento` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('M','F','O') COLLATE utf8mb4_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `celular` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email_institucional` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `email_personal` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `ciudad` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `foto_url` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `programa_id` int NOT NULL,
  `semestre` int NOT NULL,
  `jornada` enum('Diurna','Nocturna','Mixta') COLLATE utf8mb4_spanish_ci NOT NULL,
  `promedio_acumulado` decimal(3,2) DEFAULT NULL,
  `estado` enum('Activo','Inactivo','Graduado','Retirado') COLLATE utf8mb4_spanish_ci DEFAULT 'Activo',
  `fecha_ingreso` date NOT NULL,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nivel_ingles_id` int DEFAULT NULL,
  `estado_cartera_id` int DEFAULT NULL,
  `promocion_id` int DEFAULT NULL,
  `empresa_id` int DEFAULT NULL,
  PRIMARY KEY (`estudiante_id`),
  UNIQUE KEY `codigo_estudiante` (`codigo_estudiante`),
  UNIQUE KEY `numero_documento` (`numero_documento`),
  UNIQUE KEY `email_institucional` (`email_institucional`),
  KEY `idx_estudiante_programa` (`programa_id`,`semestre`),
  KEY `nivel_ingles_id` (`nivel_ingles_id`),
  KEY `estado_cartera_id` (`estado_cartera_id`),
  KEY `promocion_id` (`promocion_id`),
  KEY `idx_estudiante_email` (`email_institucional`),
  KEY `empresa_id` (`empresa_id`),
  CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`programa_id`) REFERENCES `programas` (`programa_id`) ON DELETE RESTRICT,
  CONSTRAINT `estudiantes_ibfk_2` FOREIGN KEY (`nivel_ingles_id`) REFERENCES `niveles_ingles` (`nivel_id`),
  CONSTRAINT `estudiantes_ibfk_3` FOREIGN KEY (`estado_cartera_id`) REFERENCES `estados_cartera` (`estado_id`),
  CONSTRAINT `estudiantes_ibfk_4` FOREIGN KEY (`promocion_id`) REFERENCES `promociones` (`promocion_id`),
  CONSTRAINT `estudiantes_chk_1` CHECK (((`semestre` > 0) and (`semestre` <= 12))),
  CONSTRAINT `estudiantes_ibfk_5` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` VALUES (1,'EST001','María Pérez','CC','10000001','2002-04-12','F','123456','3214567890','maria.perez@uni.edu.co','mariap@gmail.com','Calle 123','Bogotá',NULL,1,5,'Diurna',4.20,'Activo','2022-01-15','2025-06-11 23:00:10','2025-06-12 06:10:00',3,1,1,1),(2,'EST002','Juan Torres','CC','10000002','2001-08-25','M',NULL,'3001234567','juan.torres@uni.edu.co','juant@hotmail.com','Cra 45','Medellín',NULL,2,3,'Nocturna',3.80,'Activo','2023-01-20','2025-06-11 23:00:10','2025-06-11 23:00:10',2,2,2,2);
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facultades`
--

DROP TABLE IF EXISTS `facultades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facultades` (
  `facultad_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`facultad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultades`
--

LOCK TABLES `facultades` WRITE;
/*!40000 ALTER TABLE `facultades` DISABLE KEYS */;
INSERT INTO `facultades` VALUES (1,'Facultad de Ingeniería',1,'2025-06-11 23:00:10'),(2,'Facultad de Ciencias Sociales',1,'2025-06-11 23:00:10');
/*!40000 ALTER TABLE `facultades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_comunicaciones`
--

DROP TABLE IF EXISTS `historial_comunicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_comunicaciones` (
  `comunicacion_id` int NOT NULL AUTO_INCREMENT,
  `proceso_id` int NOT NULL,
  `plantilla_id` int NOT NULL,
  `fecha_envio` datetime NOT NULL,
  `destinatarios` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `asunto` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `contenido` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` enum('Enviado','Error','Pendiente') COLLATE utf8mb4_spanish_ci DEFAULT 'Pendiente',
  `error_mensaje` text COLLATE utf8mb4_spanish_ci,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comunicacion_id`),
  KEY `proceso_id` (`proceso_id`),
  KEY `plantilla_id` (`plantilla_id`),
  CONSTRAINT `historial_comunicaciones_ibfk_1` FOREIGN KEY (`proceso_id`) REFERENCES `procesos_coformacion` (`proceso_id`) ON DELETE RESTRICT,
  CONSTRAINT `historial_comunicaciones_ibfk_2` FOREIGN KEY (`plantilla_id`) REFERENCES `plantillas_correo` (`plantilla_id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_comunicaciones`
--

LOCK TABLES `historial_comunicaciones` WRITE;
/*!40000 ALTER TABLE `historial_comunicaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `historial_comunicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias_nucleo`
--

DROP TABLE IF EXISTS `materias_nucleo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materias_nucleo` (
  `materia_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `programa_id` int NOT NULL,
  `semestre` int NOT NULL,
  `creditos` int NOT NULL,
  `horas_teoricas` int DEFAULT NULL,
  `horas_practicas` int DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`materia_id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `programa_id` (`programa_id`),
  CONSTRAINT `materias_nucleo_ibfk_1` FOREIGN KEY (`programa_id`) REFERENCES `programas` (`programa_id`) ON DELETE RESTRICT,
  CONSTRAINT `materias_nucleo_chk_1` CHECK (((`semestre` > 0) and (`semestre` <= 12)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias_nucleo`
--

LOCK TABLES `materias_nucleo` WRITE;
/*!40000 ALTER TABLE `materias_nucleo` DISABLE KEYS */;
/*!40000 ALTER TABLE `materias_nucleo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `niveles_ingles`
--

DROP TABLE IF EXISTS `niveles_ingles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `niveles_ingles` (
  `nivel_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`nivel_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveles_ingles`
--

LOCK TABLES `niveles_ingles` WRITE;
/*!40000 ALTER TABLE `niveles_ingles` DISABLE KEYS */;
INSERT INTO `niveles_ingles` VALUES (1,'A1'),(2,'A2'),(3,'B1'),(4,'B2'),(5,'C1');
/*!40000 ALTER TABLE `niveles_ingles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objetivos_aprendizaje`
--

DROP TABLE IF EXISTS `objetivos_aprendizaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `objetivos_aprendizaje` (
  `objetivo_id` int NOT NULL AUTO_INCREMENT,
  `materia_id` int NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `tipo` enum('General','Específico') COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`objetivo_id`),
  KEY `materia_id` (`materia_id`),
  CONSTRAINT `objetivos_aprendizaje_ibfk_1` FOREIGN KEY (`materia_id`) REFERENCES `materias_nucleo` (`materia_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objetivos_aprendizaje`
--

LOCK TABLES `objetivos_aprendizaje` WRITE;
/*!40000 ALTER TABLE `objetivos_aprendizaje` DISABLE KEYS */;
/*!40000 ALTER TABLE `objetivos_aprendizaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofertasempresas`
--

DROP TABLE IF EXISTS `ofertasempresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ofertasempresas` (
  `idOferta` int NOT NULL AUTO_INCREMENT,
  `nacional` enum('No','Si') COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombreTutor` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  `apoyoEconomico` decimal(10,2) NOT NULL,
  `modalidad` enum('Presencial','Virtual','Híbrido') COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombreEmpresa` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `empresa_id` int NOT NULL,
  `programa_id` int DEFAULT NULL,
  PRIMARY KEY (`idOferta`),
  KEY `empresa_id` (`empresa_id`),
  KEY `programa_id` (`programa_id`),
  CONSTRAINT `ofertasempresas_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE RESTRICT,
  CONSTRAINT `ofertasempresas_ibfk_2` FOREIGN KEY (`programa_id`) REFERENCES `programas` (`programa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertasempresas`
--

LOCK TABLES `ofertasempresas` WRITE;
/*!40000 ALTER TABLE `ofertasempresas` DISABLE KEYS */;
INSERT INTO `ofertasempresas` VALUES (1,'Si','Laura Gómez',1200000.00,'Presencial','SolDigital',1,1),(2,'No','Carlos Ramírez',800000.00,'Virtual','ILEDUC',2,2);
/*!40000 ALTER TABLE `ofertasempresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permisos` (
  `permiso_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `modulo` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`permiso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plantillas_correo`
--

DROP TABLE IF EXISTS `plantillas_correo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantillas_correo` (
  `plantilla_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `asunto` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `cuerpo` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `variables` text COLLATE utf8mb4_spanish_ci,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`plantilla_id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantillas_correo`
--

LOCK TABLES `plantillas_correo` WRITE;
/*!40000 ALTER TABLE `plantillas_correo` DISABLE KEYS */;
INSERT INTO `plantillas_correo` VALUES (1,'INI001','Bienvenida Estudiante','Bienvenido(a) al proceso de coformación','Hola {{nombre}}, bienvenido al proceso...',NULL,1,'2025-06-11 23:00:10','2025-06-11 23:00:10'),(2,'REV001','Documentos en Revisión','Revisión de documentos enviados','Estimado(a) {{nombre}}, tus documentos están en revisión...',NULL,1,'2025-06-11 23:00:10','2025-06-11 23:00:10');
/*!40000 ALTER TABLE `plantillas_correo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procesos_coformacion`
--

DROP TABLE IF EXISTS `procesos_coformacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procesos_coformacion` (
  `proceso_id` int NOT NULL AUTO_INCREMENT,
  `estudiante_id` int NOT NULL,
  `empresa_id` int NOT NULL,
  `estado_id` int NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `horario` text COLLATE utf8mb4_spanish_ci,
  `trabaja_sabado` tinyint(1) DEFAULT '0',
  `salario` decimal(10,2) DEFAULT NULL,
  `modalidad` enum('Presencial','Virtual','Híbrido') COLLATE utf8mb4_spanish_ci NOT NULL,
  `observaciones` text COLLATE utf8mb4_spanish_ci,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`proceso_id`),
  KEY `estudiante_id` (`estudiante_id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `idx_proceso_fechas` (`fecha_inicio`,`fecha_fin`),
  KEY `idx_proceso_estado_empresa` (`estado_id`,`empresa_id`),
  CONSTRAINT `procesos_coformacion_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`estudiante_id`) ON DELETE RESTRICT,
  CONSTRAINT `procesos_coformacion_ibfk_2` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`) ON DELETE RESTRICT,
  CONSTRAINT `procesos_coformacion_ibfk_3` FOREIGN KEY (`estado_id`) REFERENCES `estados_proceso` (`estado_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procesos_coformacion`
--

LOCK TABLES `procesos_coformacion` WRITE;
/*!40000 ALTER TABLE `procesos_coformacion` DISABLE KEYS */;
INSERT INTO `procesos_coformacion` VALUES (1,1,1,1,'2024-06-01',NULL,NULL,0,1200000.00,'Presencial',NULL,'2025-06-11 23:00:10','2025-06-11 23:00:10'),(2,2,2,1,'2024-06-15',NULL,NULL,0,800000.00,'Virtual',NULL,'2025-06-11 23:00:10','2025-06-11 23:00:10');
/*!40000 ALTER TABLE `procesos_coformacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programas`
--

DROP TABLE IF EXISTS `programas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programas` (
  `programa_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `facultad_id` int NOT NULL,
  `duracion_semestres` int NOT NULL,
  `modalidad` enum('Presencial','Virtual','Híbrido') COLLATE utf8mb4_spanish_ci NOT NULL,
  `nivel` enum('Técnico','Tecnólogo','Profesional','Especialización','Maestría') COLLATE utf8mb4_spanish_ci NOT NULL,
  `resolucion_registro` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `fecha_resolucion` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`programa_id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `facultad_id` (`facultad_id`),
  CONSTRAINT `programas_ibfk_1` FOREIGN KEY (`facultad_id`) REFERENCES `facultades` (`facultad_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programas`
--

LOCK TABLES `programas` WRITE;
/*!40000 ALTER TABLE `programas` DISABLE KEYS */;
INSERT INTO `programas` VALUES (1,'ING01','Ingeniería de Sistemas',1,10,'Presencial','Profesional','1234-AB','2022-01-10',1,'2025-06-11 23:00:10','2025-06-11 23:00:10'),(2,'SOC01','Trabajo Social',2,8,'Virtual','Profesional','5678-CD','2021-05-15',1,'2025-06-11 23:00:10','2025-06-11 23:00:10');
/*!40000 ALTER TABLE `programas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones` (
  `promocion_id` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`promocion_id`),
  UNIQUE KEY `descripcion` (`descripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'2023-I'),(2,'2023-II'),(3,'2024-I');
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `rol_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Acceso completo al sistema',1,'2025-06-11 22:47:33','2025-06-11 22:47:33'),(2,'Coordinador','Gestión de procesos de coformación',1,'2025-06-11 22:47:33','2025-06-11 22:47:33'),(3,'Docente','Seguimiento a estudiantes',1,'2025-06-11 22:47:33','2025-06-11 22:47:33'),(4,'Estudiante','Acceso a su perfil y documentos',1,'2025-06-11 22:47:33','2025-06-11 22:47:33'),(5,'Empresa','Acceso a perfiles y procesos',1,'2025-06-11 22:47:33','2025-06-11 22:47:33');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_permisos`
--

DROP TABLE IF EXISTS `roles_permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_permisos` (
  `rol_id` int NOT NULL,
  `permiso_id` int NOT NULL,
  `fecha_asignacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rol_id`,`permiso_id`),
  KEY `permiso_id` (`permiso_id`),
  CONSTRAINT `roles_permisos_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`) ON DELETE CASCADE,
  CONSTRAINT `roles_permisos_ibfk_2` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`permiso_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_permisos`
--

LOCK TABLES `roles_permisos` WRITE;
/*!40000 ALTER TABLE `roles_permisos` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectores_economicos`
--

DROP TABLE IF EXISTS `sectores_economicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sectores_economicos` (
  `sector_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(10) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sector_id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectores_economicos`
--

LOCK TABLES `sectores_economicos` WRITE;
/*!40000 ALTER TABLE `sectores_economicos` DISABLE KEYS */;
INSERT INTO `sectores_economicos` VALUES (1,'TI01','Tecnología',NULL,1,'2025-06-11 23:00:10'),(2,'EDU01','Educación',NULL,1,'2025-06-11 23:00:10');
/*!40000 ALTER TABLE `sectores_economicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tamanos_empresa`
--

DROP TABLE IF EXISTS `tamanos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tamanos_empresa` (
  `tamano_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  `rango_empleados` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `rango_activos` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tamano_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tamanos_empresa`
--

LOCK TABLES `tamanos_empresa` WRITE;
/*!40000 ALTER TABLE `tamanos_empresa` DISABLE KEYS */;
INSERT INTO `tamanos_empresa` VALUES (1,'Microempresa','1-10 empleados',NULL,1,'2025-06-11 22:47:33'),(2,'Pequeña','11-50 empleados',NULL,1,'2025-06-11 22:47:33'),(3,'Mediana','51-200 empleados',NULL,1,'2025-06-11 22:47:33'),(4,'Grande','Más de 200 empleados',NULL,1,'2025-06-11 22:47:33');
/*!40000 ALTER TABLE `tamanos_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_actividad`
--

DROP TABLE IF EXISTS `tipos_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_actividad` (
  `tipo_act_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `color` varchar(7) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tipo_act_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_actividad`
--

LOCK TABLES `tipos_actividad` WRITE;
/*!40000 ALTER TABLE `tipos_actividad` DISABLE KEYS */;
INSERT INTO `tipos_actividad` VALUES (1,'Capacitación','Sesiones de formación para estudiantes','#00CED1',1,'2025-06-11 23:00:10'),(2,'Seguimiento','Revisión de avance del estudiante','#FFD700',1,'2025-06-11 23:00:10');
/*!40000 ALTER TABLE `tipos_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_contacto`
--

DROP TABLE IF EXISTS `tipos_contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_contacto` (
  `tipo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_contacto`
--

LOCK TABLES `tipos_contacto` WRITE;
/*!40000 ALTER TABLE `tipos_contacto` DISABLE KEYS */;
INSERT INTO `tipos_contacto` VALUES (4,'Apoyo Administrativo'),(3,'Coordinador'),(2,'Responsable Empresarial'),(1,'Tutor Académico');
/*!40000 ALTER TABLE `tipos_contacto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_documento`
--

DROP TABLE IF EXISTS `tipos_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_documento` (
  `tipo_doc_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci,
  `es_obligatorio` tinyint(1) DEFAULT '1',
  `formato_url` varchar(255) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tipo_doc_id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_documento`
--

LOCK TABLES `tipos_documento` WRITE;
/*!40000 ALTER TABLE `tipos_documento` DISABLE KEYS */;
INSERT INTO `tipos_documento` VALUES (1,'DOC001','Carta de Presentación','Documento inicial de contacto con la empresa',1,NULL,1,'2025-06-11 23:00:10'),(2,'DOC002','Convenio Firmado','Convenio entre institución y empresa',1,NULL,1,'2025-06-11 23:00:10');
/*!40000 ALTER TABLE `tipos_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coformacion`
--

DROP TABLE IF EXISTS `coformacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coformacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `identificacion` varchar(20) COLLATE utf8mb4_spanish_ci NOT NULL,
  `rol` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identificacion` (`identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coformacion`
--

LOCK TABLES `coformacion` WRITE;
/*!40000 ALTER TABLE `coformacion` DISABLE KEYS */;
INSERT INTO `coformacion` VALUES
(1,'Ana María Rodríguez','1234567890','Coordinadora',1,'2025-06-12 10:00:00'),
(2,'Carlos Eduardo Gómez','2345678901','Supervisor',1,'2025-06-12 10:00:00'),
(3,'Laura Patricia Sánchez','3456789012','Asesora',1,'2025-06-12 10:00:00'),
(4,'Juan David Martínez','4567890123','Tutor',1,'2025-06-12 10:00:00'),
(5,'María Fernanda López','5678901234','Coordinadora',1,'2025-06-12 10:00:00');
/*!40000 ALTER TABLE `coformacion` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-12  2:48:54
