-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: coformacion1
-- ------------------------------------------------------
-- Server version	8.0.42

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add coformacion',7,'add_coformacion'),(26,'Can change coformacion',7,'change_coformacion'),(27,'Can delete coformacion',7,'delete_coformacion'),(28,'Can view coformacion',7,'view_coformacion'),(29,'Can add empresas',8,'add_empresas'),(30,'Can change empresas',8,'change_empresas'),(31,'Can delete empresas',8,'delete_empresas'),(32,'Can view empresas',8,'view_empresas'),(33,'Can add estado proceso',9,'add_estadoproceso'),(34,'Can change estado proceso',9,'change_estadoproceso'),(35,'Can delete estado proceso',9,'delete_estadoproceso'),(36,'Can view estado proceso',9,'view_estadoproceso'),(37,'Can add estados cartera',10,'add_estadoscartera'),(38,'Can change estados cartera',10,'change_estadoscartera'),(39,'Can delete estados cartera',10,'delete_estadoscartera'),(40,'Can view estados cartera',10,'view_estadoscartera'),(41,'Can add facultades',11,'add_facultades'),(42,'Can change facultades',11,'change_facultades'),(43,'Can delete facultades',11,'delete_facultades'),(44,'Can view facultades',11,'view_facultades'),(45,'Can add materias nucleo',12,'add_materiasnucleo'),(46,'Can change materias nucleo',12,'change_materiasnucleo'),(47,'Can delete materias nucleo',12,'delete_materiasnucleo'),(48,'Can view materias nucleo',12,'view_materiasnucleo'),(49,'Can add niveles ingles',13,'add_nivelesingles'),(50,'Can change niveles ingles',13,'change_nivelesingles'),(51,'Can delete niveles ingles',13,'delete_nivelesingles'),(52,'Can view niveles ingles',13,'view_nivelesingles'),(53,'Can add permisos',14,'add_permisos'),(54,'Can change permisos',14,'change_permisos'),(55,'Can delete permisos',14,'delete_permisos'),(56,'Can view permisos',14,'view_permisos'),(57,'Can add plantillas correo',15,'add_plantillascorreo'),(58,'Can change plantillas correo',15,'change_plantillascorreo'),(59,'Can delete plantillas correo',15,'delete_plantillascorreo'),(60,'Can view plantillas correo',15,'view_plantillascorreo'),(61,'Can add promociones',16,'add_promociones'),(62,'Can change promociones',16,'change_promociones'),(63,'Can delete promociones',16,'delete_promociones'),(64,'Can view promociones',16,'view_promociones'),(65,'Can add roles',17,'add_roles'),(66,'Can change roles',17,'change_roles'),(67,'Can delete roles',17,'delete_roles'),(68,'Can view roles',17,'view_roles'),(69,'Can add sectores economicos',18,'add_sectoreseconomicos'),(70,'Can change sectores economicos',18,'change_sectoreseconomicos'),(71,'Can delete sectores economicos',18,'delete_sectoreseconomicos'),(72,'Can view sectores economicos',18,'view_sectoreseconomicos'),(73,'Can add tamanos empresa',19,'add_tamanosempresa'),(74,'Can change tamanos empresa',19,'change_tamanosempresa'),(75,'Can delete tamanos empresa',19,'delete_tamanosempresa'),(76,'Can view tamanos empresa',19,'view_tamanosempresa'),(77,'Can add tipos actividad',20,'add_tiposactividad'),(78,'Can change tipos actividad',20,'change_tiposactividad'),(79,'Can delete tipos actividad',20,'delete_tiposactividad'),(80,'Can view tipos actividad',20,'view_tiposactividad'),(81,'Can add tipos contacto',21,'add_tiposcontacto'),(82,'Can change tipos contacto',21,'change_tiposcontacto'),(83,'Can delete tipos contacto',21,'delete_tiposcontacto'),(84,'Can view tipos contacto',21,'view_tiposcontacto'),(85,'Can add tipos documento',22,'add_tiposdocumento'),(86,'Can change tipos documento',22,'change_tiposdocumento'),(87,'Can delete tipos documento',22,'delete_tiposdocumento'),(88,'Can view tipos documento',22,'view_tiposdocumento'),(89,'Can add contactos empresa',23,'add_contactosempresa'),(90,'Can change contactos empresa',23,'change_contactosempresa'),(91,'Can delete contactos empresa',23,'delete_contactosempresa'),(92,'Can view contactos empresa',23,'view_contactosempresa'),(93,'Can add estudiantes',24,'add_estudiantes'),(94,'Can change estudiantes',24,'change_estudiantes'),(95,'Can delete estudiantes',24,'delete_estudiantes'),(96,'Can view estudiantes',24,'view_estudiantes'),(97,'Can add objetivos aprendizaje',25,'add_objetivosaprendizaje'),(98,'Can change objetivos aprendizaje',25,'change_objetivosaprendizaje'),(99,'Can delete objetivos aprendizaje',25,'delete_objetivosaprendizaje'),(100,'Can view objetivos aprendizaje',25,'view_objetivosaprendizaje'),(101,'Can add ofertas empresas',26,'add_ofertasempresas'),(102,'Can change ofertas empresas',26,'change_ofertasempresas'),(103,'Can delete ofertas empresas',26,'delete_ofertasempresas'),(104,'Can view ofertas empresas',26,'view_ofertasempresas'),(105,'Can add historial comunicaciones',27,'add_historialcomunicaciones'),(106,'Can change historial comunicaciones',27,'change_historialcomunicaciones'),(107,'Can delete historial comunicaciones',27,'delete_historialcomunicaciones'),(108,'Can view historial comunicaciones',27,'view_historialcomunicaciones'),(109,'Can add proceso coformacion',28,'add_procesocoformacion'),(110,'Can change proceso coformacion',28,'change_procesocoformacion'),(111,'Can delete proceso coformacion',28,'delete_procesocoformacion'),(112,'Can view proceso coformacion',28,'view_procesocoformacion'),(113,'Can add documentos proceso',29,'add_documentosproceso'),(114,'Can change documentos proceso',29,'change_documentosproceso'),(115,'Can delete documentos proceso',29,'delete_documentosproceso'),(116,'Can view documentos proceso',29,'view_documentosproceso'),(117,'Can add programas',30,'add_programas'),(118,'Can change programas',30,'change_programas'),(119,'Can delete programas',30,'delete_programas'),(120,'Can view programas',30,'view_programas'),(121,'Can add calendario actividades',31,'add_calendarioactividades'),(122,'Can change calendario actividades',31,'change_calendarioactividades'),(123,'Can delete calendario actividades',31,'delete_calendarioactividades'),(124,'Can view calendario actividades',31,'view_calendarioactividades'),(125,'Can add roles permisos',32,'add_rolespermisos'),(126,'Can change roles permisos',32,'change_rolespermisos'),(127,'Can delete roles permisos',32,'delete_rolespermisos'),(128,'Can view roles permisos',32,'view_rolespermisos');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `descripcion` longtext NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time(6) NOT NULL,
  `hora_fin` time(6) NOT NULL,
  `proceso_id` int NOT NULL,
  `tipo_actividad_id` int DEFAULT NULL,
  PRIMARY KEY (`actividad_id`),
  KEY `calendario_actividad_proceso_id_4dc087a8_fk_proceso_c` (`proceso_id`),
  KEY `calendario_actividad_tipo_actividad_id_638dd678_fk_tipos_act` (`tipo_actividad_id`),
  CONSTRAINT `calendario_actividad_proceso_id_4dc087a8_fk_proceso_c` FOREIGN KEY (`proceso_id`) REFERENCES `proceso_coformacion` (`proceso_id`),
  CONSTRAINT `calendario_actividad_tipo_actividad_id_638dd678_fk_tipos_act` FOREIGN KEY (`tipo_actividad_id`) REFERENCES `tipos_actividad` (`tipo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario_actividades`
--

LOCK TABLES `calendario_actividades` WRITE;
/*!40000 ALTER TABLE `calendario_actividades` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendario_actividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coformacion`
--

DROP TABLE IF EXISTS `coformacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coformacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(255) NOT NULL,
  `identificacion` varchar(20) NOT NULL,
  `rol` varchar(100) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identificacion` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coformacion`
--

LOCK TABLES `coformacion` WRITE;
/*!40000 ALTER TABLE `coformacion` DISABLE KEYS */;
INSERT INTO `coformacion` VALUES (1,'María Alejandra Pérez','1012345678','Co-Formador Principal',1,'2024-01-15 00:00:00.000000'),(2,'Juan David Gómez','9876543210','Asistente Co-Formador',2,'2024-02-20 00:00:00.000000'),(3,'Laura Sofía Ramírez','1234567890','Co-Formador Técnico',1,'2023-11-01 00:00:00.000000'),(4,'Carlos Andrés Vargas','2345678901','Co-Formador de Apoyo',2,'2023-05-10 00:00:00.000000');
/*!40000 ALTER TABLE `coformacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos_empresa`
--

DROP TABLE IF EXISTS `contactos_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contactos_empresa` (
  `contacto_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `cargo` varchar(100) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `es_principal` tinyint(1) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `empresa_id` int NOT NULL,
  PRIMARY KEY (`contacto_id`),
  KEY `contactos_empresa_empresa_id_8b7d6290_fk_empresas_empresa_id` (`empresa_id`),
  CONSTRAINT `contactos_empresa_empresa_id_8b7d6290_fk_empresas_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos_empresa`
--

LOCK TABLES `contactos_empresa` WRITE;
/*!40000 ALTER TABLE `contactos_empresa` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(31,'coformacion','calendarioactividades'),(7,'coformacion','coformacion'),(23,'coformacion','contactosempresa'),(29,'coformacion','documentosproceso'),(8,'coformacion','empresas'),(9,'coformacion','estadoproceso'),(10,'coformacion','estadoscartera'),(24,'coformacion','estudiantes'),(11,'coformacion','facultades'),(27,'coformacion','historialcomunicaciones'),(12,'coformacion','materiasnucleo'),(13,'coformacion','nivelesingles'),(25,'coformacion','objetivosaprendizaje'),(26,'coformacion','ofertasempresas'),(14,'coformacion','permisos'),(15,'coformacion','plantillascorreo'),(28,'coformacion','procesocoformacion'),(30,'coformacion','programas'),(16,'coformacion','promociones'),(17,'coformacion','roles'),(32,'coformacion','rolespermisos'),(18,'coformacion','sectoreseconomicos'),(19,'coformacion','tamanosempresa'),(20,'coformacion','tiposactividad'),(21,'coformacion','tiposcontacto'),(22,'coformacion','tiposdocumento'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-06-25 03:00:00.287082'),(2,'auth','0001_initial','2025-06-25 03:00:01.081704'),(3,'admin','0001_initial','2025-06-25 03:00:01.279638'),(4,'admin','0002_logentry_remove_auto_add','2025-06-25 03:00:01.296290'),(5,'admin','0003_logentry_add_action_flag_choices','2025-06-25 03:00:01.309892'),(6,'contenttypes','0002_remove_content_type_name','2025-06-25 03:00:01.468645'),(7,'auth','0002_alter_permission_name_max_length','2025-06-25 03:00:01.560642'),(8,'auth','0003_alter_user_email_max_length','2025-06-25 03:00:01.615660'),(9,'auth','0004_alter_user_username_opts','2025-06-25 03:00:01.638401'),(10,'auth','0005_alter_user_last_login_null','2025-06-25 03:00:01.731832'),(11,'auth','0006_require_contenttypes_0002','2025-06-25 03:00:01.735507'),(12,'auth','0007_alter_validators_add_error_messages','2025-06-25 03:00:01.751740'),(13,'auth','0008_alter_user_username_max_length','2025-06-25 03:00:01.856262'),(14,'auth','0009_alter_user_last_name_max_length','2025-06-25 03:00:01.954075'),(15,'auth','0010_alter_group_name_max_length','2025-06-25 03:00:01.997154'),(16,'auth','0011_update_proxy_permissions','2025-06-25 03:00:02.014158'),(17,'auth','0012_alter_user_first_name_max_length','2025-06-25 03:00:02.106316'),(18,'coformacion','0001_initial','2025-06-25 03:00:05.060122'),(19,'coformacion','0002_empresas_actividad_economica_empresas_ciudad_and_more','2025-06-25 03:00:08.599054'),(20,'coformacion','0003_update_ofertas_empresas','2025-06-25 03:00:09.044495'),(21,'sessions','0001_initial','2025-06-25 03:00:09.095329');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4c6fa15vtjs35uecmimdcyxwh8973jkz','.eJxVjMEOwiAQRP-FsyGlywJ69O43EFgWqRpISnsy_rtt0oNmbvPezFv4sC7Fr51nPyVxEUqcfrsY6Ml1B-kR6r1JanWZpyh3RR60y1tL_Loe7t9BCb1sa0dgiCmjGSDYQSkTcTxDxOg0acxJRxMsuOwgMW6xwGCRRkSG5JT4fAHeZzev:1uR3c1:Rjt-WzUb6U5zEwp0w7x9E396-MVCj0pxB6fTN4a2IOc','2025-06-30 06:46:33.456215');
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
  `nombre` varchar(255) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `fecha_subida` datetime(6) NOT NULL,
  `proceso_id` int NOT NULL,
  PRIMARY KEY (`documento_id`),
  KEY `documentos_proceso_proceso_id_917ffa4b_fk_proceso_c` (`proceso_id`),
  CONSTRAINT `documentos_proceso_proceso_id_917ffa4b_fk_proceso_c` FOREIGN KEY (`proceso_id`) REFERENCES `proceso_coformacion` (`proceso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_proceso`
--

LOCK TABLES `documentos_proceso` WRITE;
/*!40000 ALTER TABLE `documentos_proceso` DISABLE KEYS */;
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
  `nombre_comercial` varchar(255) DEFAULT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `sector_id` int NOT NULL,
  `tamano_id` int NOT NULL,
  `actividad_economica` longtext NOT NULL DEFAULT (_utf8mb4'Tecnologia'),
  `ciudad` varchar(100) NOT NULL,
  `convenio_url` varchar(255) DEFAULT NULL,
  `cuota_sena` int DEFAULT NULL,
  `departamento` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `estado_convenio` varchar(20) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `fecha_convenio` date DEFAULT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `horario_laboral` longtext,
  `numero_empleados` int DEFAULT NULL,
  `observaciones` longtext,
  `razon_social` varchar(255) NOT NULL,
  `sitio_web` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `trabaja_sabado` tinyint(1) NOT NULL,
  PRIMARY KEY (`empresa_id`),
  KEY `empresas_tamano_id_6347345b_fk_tamanos_empresa_tamano_id` (`tamano_id`),
  KEY `idx_empresa_sector` (`sector_id`,`estado_convenio`),
  KEY `idx_empresa_estado` (`estado_convenio`,`estado`),
  CONSTRAINT `empresas_sector_id_8d47f51a_fk_sectores_economicos_sector_id` FOREIGN KEY (`sector_id`) REFERENCES `sectores_economicos` (`sector_id`),
  CONSTRAINT `empresas_tamano_id_6347345b_fk_tamanos_empresa_tamano_id` FOREIGN KEY (`tamano_id`) REFERENCES `tamanos_empresa` (`tamano_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (3,'Soluciones Digitales S.A.S.','9001234567',1,2,'Tecnologia','Bogota',NULL,NULL,'Bogota','cll 50',1,'En Trámite','2025-06-16 07:32:28.881683',NULL,'2025-06-16 07:32:28.964702',NULL,NULL,NULL,'richard',NULL,NULL,0),(4,'Transportes Rápidos S.A.','8901234569',5,3,'Tecnologia','Bogota',NULL,NULL,'Bogota','cll 50',1,'En Trámite','2025-06-16 07:32:28.881683',NULL,'2025-06-16 07:32:28.964702',NULL,NULL,NULL,'richard',NULL,NULL,0),(5,'Marketing Innova SAS','9009876543',1,1,'Tecnologia','Bogota',NULL,NULL,'Bogota','cll 50',1,'En Trámite','2025-06-16 07:32:28.881683',NULL,'2025-06-16 07:32:28.964702',NULL,NULL,NULL,'richard',NULL,NULL,0),(8,'El Sabor Casero Ltda.','8001122330',3,4,'Tecnologia','Bogota',NULL,NULL,'Bogota','cll 50',1,'En Trámite','2025-06-16 07:32:28.881683',NULL,'2025-06-16 07:32:28.964702',NULL,NULL,NULL,'richard',NULL,NULL,0),(9,'Confecciones Moda Total','7776665554',3,2,'Tecnologia','Bogota',NULL,NULL,'Bogota','cll 50',1,'En Trámite','2025-06-16 07:32:28.881683',NULL,'2025-06-16 07:32:28.964702',NULL,NULL,NULL,'richard',NULL,NULL,0),(10,'Salsas','9102391009',2,1,'Salsas','Teusaquillo','',NULL,'Departamento','Calle 50',1,'En Trámite','2025-06-19 01:31:51.701554','2025-06-17','2025-06-19 01:31:51.701554','',NULL,'','SALSA S.A.S','salsas.com','',0),(11,'GANADO RICHI','9003212839',6,3,'Agricola','MUZO','',NULL,'BOYACÁ','Cra 69 #10-55',1,'Vigente','2025-06-19 03:07:20.762075','2025-06-02','2025-06-19 03:07:20.762075','',NULL,'','GANADEROS','richi.com','',0);
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_proceso`
--

DROP TABLE IF EXISTS `estado_proceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_proceso` (
  `estado_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`estado_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_proceso`
--

LOCK TABLES `estado_proceso` WRITE;
/*!40000 ALTER TABLE `estado_proceso` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_proceso` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados_cartera`
--

LOCK TABLES `estados_cartera` WRITE;
/*!40000 ALTER TABLE `estados_cartera` DISABLE KEYS */;
INSERT INTO `estados_cartera` VALUES (1,'Al día'),(5,'Condonado'),(3,'En acuerdo de pago'),(2,'En mora'),(7,'En revisión'),(4,'Incobrable'),(6,'Pagado');
/*!40000 ALTER TABLE `estados_cartera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes` (
  `estudiante_id` int NOT NULL AUTO_INCREMENT,
  `codigo_estudiante` varchar(20) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `tipo_documento` varchar(3) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` varchar(1) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `celular` varchar(20) NOT NULL,
  `email_institucional` varchar(254) NOT NULL,
  `email_personal` varchar(254) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `foto_url` varchar(255) DEFAULT NULL,
  `semestre` int NOT NULL,
  `jornada` varchar(8) NOT NULL,
  `promedio_acumulado` decimal(3,2) DEFAULT NULL,
  `estado` varchar(9) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `empresa_id` int DEFAULT NULL,
  `estado_cartera_id` int DEFAULT NULL,
  `nivel_ingles_id` int DEFAULT NULL,
  `programa_id` int NOT NULL,
  `promocion_id` int DEFAULT NULL,
  PRIMARY KEY (`estudiante_id`),
  UNIQUE KEY `codigo_estudiante` (`codigo_estudiante`),
  UNIQUE KEY `numero_documento` (`numero_documento`),
  UNIQUE KEY `email_institucional` (`email_institucional`),
  KEY `estudiantes_programa_id_e679bcd7_fk_programas_programa_id` (`programa_id`),
  KEY `estudiantes_promocion_id_a995aa3a_fk_promociones_promocion_id` (`promocion_id`),
  KEY `estudiantes_empresa_id_02bc6c3f_fk_empresas_empresa_id` (`empresa_id`),
  KEY `estudiantes_estado_cartera_id_3400bd5c_fk_estados_c` (`estado_cartera_id`),
  KEY `estudiantes_nivel_ingles_id_dabc4a6a_fk_niveles_ingles_nivel_id` (`nivel_ingles_id`),
  CONSTRAINT `estudiantes_empresa_id_02bc6c3f_fk_empresas_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`),
  CONSTRAINT `estudiantes_estado_cartera_id_3400bd5c_fk_estados_c` FOREIGN KEY (`estado_cartera_id`) REFERENCES `estados_cartera` (`estado_id`),
  CONSTRAINT `estudiantes_nivel_ingles_id_dabc4a6a_fk_niveles_ingles_nivel_id` FOREIGN KEY (`nivel_ingles_id`) REFERENCES `niveles_ingles` (`nivel_id`),
  CONSTRAINT `estudiantes_programa_id_e679bcd7_fk_programas_programa_id` FOREIGN KEY (`programa_id`) REFERENCES `programas` (`programa_id`),
  CONSTRAINT `estudiantes_promocion_id_a995aa3a_fk_promociones_promocion_id` FOREIGN KEY (`promocion_id`) REFERENCES `promociones` (`promocion_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` VALUES (1,'001','Daniel Camargo','CC','1920391029','2005-06-14','M','3219228344','3219228343','dmargo@uniempresarial.edu.co','dargo@gmail.com','Calle 127 #47-63','Bogotá','ejemplo.jpg',1,'Diurna',4.00,'Activo','2025-06-02','2025-06-19 00:55:27.030081','2025-06-19 02:59:41.376396',NULL,1,2,2,7),(2,'0002','Alejandro Pinzon','CC','1193808693','2006-06-13','M','3219228388','3219228388','Apinzon@uniempresarial.edu.co','Alejandro123@gmail.com','Calle 50 #11-20','Bogotá','https://drive.com/foto.jpg',1,'Diurna',3.80,'Activo','2025-01-13','2025-06-19 01:34:53.572206','2025-06-19 01:34:53.572206',NULL,1,3,2,8),(3,'0007','Ricardo Arevalo','CC','1083293812','2006-03-09','M','3219228322','3219228322','darevalop@uniempresarial.edu.co','deividarevalo12@gmail.com','Calle 169 #50-18','Bogotá','',5,'Diurna',3.00,'Activo','2023-01-16','2025-06-19 03:11:41.036569','2025-06-19 03:11:41.036569',NULL,6,1,3,6);
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
  `nombre` varchar(255) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  PRIMARY KEY (`facultad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facultades`
--

LOCK TABLES `facultades` WRITE;
/*!40000 ALTER TABLE `facultades` DISABLE KEYS */;
INSERT INTO `facultades` VALUES (1,'Tecnologia',1,'2024-04-05 00:00:00.000000'),(2,'Ingenieria',2,'2024-04-05 00:00:00.000000'),(3,'Derecho',1,'2024-04-05 00:00:00.000000'),(4,'Ciencias',2,'2024-04-05 00:00:00.000000');
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
  `fecha_envio` datetime(6) NOT NULL,
  `enviado_por` varchar(100) NOT NULL,
  `estudiante_id` int NOT NULL,
  `plantilla_id` int DEFAULT NULL,
  PRIMARY KEY (`comunicacion_id`),
  KEY `historial_comunicaci_estudiante_id_092810ab_fk_estudiant` (`estudiante_id`),
  KEY `historial_comunicaci_plantilla_id_532f16dc_fk_plantilla` (`plantilla_id`),
  CONSTRAINT `historial_comunicaci_estudiante_id_092810ab_fk_estudiant` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`estudiante_id`),
  CONSTRAINT `historial_comunicaci_plantilla_id_532f16dc_fk_plantilla` FOREIGN KEY (`plantilla_id`) REFERENCES `plantillas_correo` (`plantilla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `nombre` varchar(100) NOT NULL,
  `programa_id` int NOT NULL,
  PRIMARY KEY (`materia_id`),
  KEY `materias_nucleo_programa_id_b94deb3f_fk_programas_programa_id` (`programa_id`),
  CONSTRAINT `materias_nucleo_programa_id_b94deb3f_fk_programas_programa_id` FOREIGN KEY (`programa_id`) REFERENCES `programas` (`programa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveles_ingles`
--

LOCK TABLES `niveles_ingles` WRITE;
/*!40000 ALTER TABLE `niveles_ingles` DISABLE KEYS */;
INSERT INTO `niveles_ingles` VALUES (1,'A1 - Principiante'),(2,'A2 - Básico'),(3,'B1 - Intermedio bajo'),(4,'B2 - Intermedio alto'),(5,'C1 - Avanzado'),(6,'C2 - Experto');
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
  `descripcion` longtext NOT NULL,
  `materia_id` int NOT NULL,
  PRIMARY KEY (`objetivo_id`),
  KEY `objetivos_aprendizaj_materia_id_ae1d0ca3_fk_materias_` (`materia_id`),
  CONSTRAINT `objetivos_aprendizaj_materia_id_ae1d0ca3_fk_materias_` FOREIGN KEY (`materia_id`) REFERENCES `materias_nucleo` (`materia_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `oferta_id` int NOT NULL AUTO_INCREMENT,
  `descripcion` longtext NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `empresa_id` int NOT NULL,
  `programa_id` int DEFAULT NULL,
  `tipo_oferta` varchar(20) DEFAULT NULL,
  `apoyo_economico` varchar(2) DEFAULT NULL,
  `nombre_responsable` varchar(255) DEFAULT NULL,
  `modalidad` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`oferta_id`),
  KEY `ofertasempresas_empresa_id_985b0d99_fk_empresas_empresa_id` (`empresa_id`),
  KEY `ofertasempresas_programa_id_c5fe4d38_fk_programas_programa_id` (`programa_id`),
  CONSTRAINT `ofertasempresas_empresa_id_985b0d99_fk_empresas_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`),
  CONSTRAINT `ofertasempresas_programa_id_c5fe4d38_fk_programas_programa_id` FOREIGN KEY (`programa_id`) REFERENCES `programas` (`programa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertasempresas`
--

LOCK TABLES `ofertasempresas` WRITE;
/*!40000 ALTER TABLE `ofertasempresas` DISABLE KEYS */;
INSERT INTO `ofertasempresas` VALUES (11,'Oferta de práctica en marketing digital para estudiantes de administración','2025-07-01','2025-12-15',3,1,'Nacional','1','Laura Ramírez','Presencial'),(12,'Desarrollo web para empresa de software','2025-08-01','2026-01-31',5,2,'Internacional','1','Carlos Pérez','Remoto'),(13,'Asistente financiero junior','2025-07-15','2025-11-30',4,3,'Nacional','0','Andrea Gómez','Híbrido'),(14,'Analista de datos en firma consultora','2025-09-01','2026-02-28',3,3,'Nacional','1','Luis Torres','Presencial'),(15,'Práctica en relaciones internacionales','2025-07-10','2025-12-10',8,2,'Internacional','0','Sofía Martínez','Remoto');
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
  `nombre` varchar(100) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `descripcion` longtext,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`permiso_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `nombre` varchar(100) NOT NULL,
  `asunto` varchar(255) NOT NULL,
  `cuerpo` longtext NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  PRIMARY KEY (`plantilla_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantillas_correo`
--

LOCK TABLES `plantillas_correo` WRITE;
/*!40000 ALTER TABLE `plantillas_correo` DISABLE KEYS */;
/*!40000 ALTER TABLE `plantillas_correo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proceso_coformacion`
--

DROP TABLE IF EXISTS `proceso_coformacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proceso_coformacion` (
  `proceso_id` int NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `observaciones` longtext,
  `empresa_id` int NOT NULL,
  `estado_id` int DEFAULT NULL,
  `estudiante_id` int NOT NULL,
  `oferta_id` int NOT NULL,
  PRIMARY KEY (`proceso_id`),
  KEY `proceso_coformacion_empresa_id_570f6a9d_fk_empresas_empresa_id` (`empresa_id`),
  KEY `proceso_coformacion_estado_id_5a7c483a_fk_estado_pr` (`estado_id`),
  KEY `proceso_coformacion_estudiante_id_8821ffa3_fk_estudiant` (`estudiante_id`),
  KEY `proceso_coformacion_oferta_id_064a9451_fk_ofertasem` (`oferta_id`),
  CONSTRAINT `proceso_coformacion_empresa_id_570f6a9d_fk_empresas_empresa_id` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`empresa_id`),
  CONSTRAINT `proceso_coformacion_estado_id_5a7c483a_fk_estado_pr` FOREIGN KEY (`estado_id`) REFERENCES `estado_proceso` (`estado_id`),
  CONSTRAINT `proceso_coformacion_estudiante_id_8821ffa3_fk_estudiant` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`estudiante_id`),
  CONSTRAINT `proceso_coformacion_oferta_id_064a9451_fk_ofertasem` FOREIGN KEY (`oferta_id`) REFERENCES `ofertasempresas` (`oferta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proceso_coformacion`
--

LOCK TABLES `proceso_coformacion` WRITE;
/*!40000 ALTER TABLE `proceso_coformacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `proceso_coformacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programas`
--

DROP TABLE IF EXISTS `programas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programas` (
  `programa_id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `duracion_semestres` int NOT NULL,
  `modalidad` varchar(10) NOT NULL,
  `nivel` varchar(15) NOT NULL,
  `resolucion_registro` varchar(100) DEFAULT NULL,
  `fecha_resolucion` date DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `facultad_id` int NOT NULL,
  PRIMARY KEY (`programa_id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `programas_facultad_id_f0b01982_fk_facultades_facultad_id` (`facultad_id`),
  CONSTRAINT `programas_facultad_id_f0b01982_fk_facultades_facultad_id` FOREIGN KEY (`facultad_id`) REFERENCES `facultades` (`facultad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programas`
--

LOCK TABLES `programas` WRITE;
/*!40000 ALTER TABLE `programas` DISABLE KEYS */;
INSERT INTO `programas` VALUES (1,'TI-2024','Tecnologías de la Información',8,'Presencial','Profesional','RES-2024-001','2024-01-15',1,'2024-04-05 00:00:00.000000','2024-06-19 00:00:00.000000',1),(2,'ADM-2024','Administración de Empresas',10,'Presencial','Profesional','RES-2024-002','2024-02-10',1,'2024-04-10 00:00:00.000000','2024-06-19 00:00:00.000000',1),(3,'COM-2024','Contaduría Pública',9,'Virtual','Profesional','RES-2024-003','2024-03-20',1,'2024-04-15 00:00:00.000000','2024-06-19 00:00:00.000000',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'12A'),(2,'12B'),(3,'13A'),(4,'13B'),(5,'14A'),(6,'14B'),(7,'15A'),(8,'15B');
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
  `nombre` varchar(50) NOT NULL,
  `descripcion` longtext,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `fecha_actualizacion` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_permisos`
--

DROP TABLE IF EXISTS `roles_permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_permisos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_asignacion` datetime(6) DEFAULT NULL,
  `permiso_id` int NOT NULL,
  `rol_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_permisos_rol_id_permiso_id_daf91080_uniq` (`rol_id`,`permiso_id`),
  KEY `roles_permisos_permiso_id_ff70f233_fk_permisos_permiso_id` (`permiso_id`),
  CONSTRAINT `roles_permisos_permiso_id_ff70f233_fk_permisos_permiso_id` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`permiso_id`),
  CONSTRAINT `roles_permisos_rol_id_5daf3c70_fk_roles_rol_id` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`rol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`sector_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectores_economicos`
--

LOCK TABLES `sectores_economicos` WRITE;
/*!40000 ALTER TABLE `sectores_economicos` DISABLE KEYS */;
INSERT INTO `sectores_economicos` VALUES (1,'Tecnología'),(2,'Comercio Minorista'),(3,'Ingenieria'),(4,'Construcción'),(5,'Servicios Financieros'),(6,'Agricola');
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
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`tamano_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tamanos_empresa`
--

LOCK TABLES `tamanos_empresa` WRITE;
/*!40000 ALTER TABLE `tamanos_empresa` DISABLE KEYS */;
INSERT INTO `tamanos_empresa` VALUES (1,'Microempresa'),(2,'Pequeña Empresa'),(3,'Mediana Empresa'),(4,'Gran Empresa');
/*!40000 ALTER TABLE `tamanos_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_actividad`
--

DROP TABLE IF EXISTS `tipos_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_actividad` (
  `tipo_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` longtext,
  PRIMARY KEY (`tipo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_actividad`
--

LOCK TABLES `tipos_actividad` WRITE;
/*!40000 ALTER TABLE `tipos_actividad` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_contacto`
--

LOCK TABLES `tipos_contacto` WRITE;
/*!40000 ALTER TABLE `tipos_contacto` DISABLE KEYS */;
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
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` longtext,
  `es_obligatorio` tinyint(1) NOT NULL,
  `formato_url` varchar(255) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  PRIMARY KEY (`tipo_doc_id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_documento`
--

LOCK TABLES `tipos_documento` WRITE;
/*!40000 ALTER TABLE `tipos_documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipos_documento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25  2:16:26
