# ************************************************************
# Sequel Ace SQL dump
# Version 20051
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.01 (MySQL 8.0.33)
# Database: TechTest2023
# Generation Time: 2023-09-13 08:26:49 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assembly
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assembly`;

CREATE TABLE `assembly` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `accession_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `assembly` WRITE;
/*!40000 ALTER TABLE `assembly` DISABLE KEYS */;

INSERT INTO `assembly` (`id`, `accession_id`)
VALUES
	(1,'GCA_000001405.29'),
	(2,'GCA_000001405.14'),
	(3,'GCA_000001635.9');

/*!40000 ALTER TABLE `assembly` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gene
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gene`;

CREATE TABLE `gene` (
  `gene_id` int unsigned NOT NULL AUTO_INCREMENT,
  `symbol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `stable_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`gene_id`),
  KEY `gene_id` (`gene_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `gene` WRITE;
/*!40000 ALTER TABLE `gene` DISABLE KEYS */;

INSERT INTO `gene` (`gene_id`, `symbol`, `stable_id`)
VALUES
	(1,'JAG1','ENSG00000101384.12'),
	(2,'JAG1','ENSG00000101384.11'),
	(3,'JAG1','ENSG00000101384.7'),
	(4,'JAG1','ENSMUSG00000027276.8'),
	(5,'ACE2','ENSMUSG00000015405.16');

/*!40000 ALTER TABLE `gene` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table region
# ------------------------------------------------------------

DROP TABLE IF EXISTS `region`;

CREATE TABLE `region` (
  `region_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `assembly_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;

INSERT INTO `region` (`region_id`, `name`, `assembly_id`)
VALUES
	(1,'20',1),
	(2,'2',3),
	(3,'X',3),
	(4,'20',2);

/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table transcript
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transcript`;

CREATE TABLE `transcript` (
  `transcript_id` int unsigned NOT NULL AUTO_INCREMENT,
  `stable_id` varchar(50) NOT NULL,
  `gene_id` int unsigned NOT NULL,
  PRIMARY KEY (`transcript_id`),
  KEY `gene_id` (`gene_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `transcript` WRITE;
/*!40000 ALTER TABLE `transcript` DISABLE KEYS */;

INSERT INTO `transcript` (`transcript_id`, `stable_id`, `gene_id`)
VALUES
	(1,'ENST00000254958.10',1),
	(2,'ENST00000254958.9',2),
	(3,'ENST00000254958.5',3),
	(4,'ENST00000423891.2',3),
	(5,'ENSMUST00000028735.8',4),
	(9,'ENSMUST00000112271.10',5);

/*!40000 ALTER TABLE `transcript` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table transcript_location
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transcript_location`;

CREATE TABLE `transcript_location` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `transcript_id` int unsigned NOT NULL,
  `start` int NOT NULL,
  `end` int NOT NULL,
  `region_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transcript_id` (`transcript_id`),
  KEY `region_id` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `transcript_location` WRITE;
/*!40000 ALTER TABLE `transcript_location` DISABLE KEYS */;

INSERT INTO `transcript_location` (`id`, `transcript_id`, `start`, `end`, `region_id`)
VALUES
	(1,1,10637684,10673999,1),
	(2,2,10637684,10674107,1),
	(3,3,10618332,10654694,4),
	(4,4,10618407,10643154,4),
	(5,5,136923376,136958564,2),
	(6,6,162922328,162971416,3);

/*!40000 ALTER TABLE `transcript_location` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
