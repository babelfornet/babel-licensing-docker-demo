-- MySQL dump 10.13  Distrib 5.7.23, for macos10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: licenses
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

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

CREATE DATABASE IF NOT EXISTS licenses;
USE licenses;

--
-- Table structure for table `ApiKeys`
--

DROP TABLE IF EXISTS `ApiKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ApiKeys` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Key` longtext DEFAULT NULL,
  `ClientSecret` longtext DEFAULT NULL,
  `CreatedDate` datetime(6) NOT NULL,
  `ExpireDate` datetime(6) DEFAULT NULL,
  `OwnerId` varchar(255) DEFAULT NULL,
  `Revoked` tinyint(1) NOT NULL,
  `Permissions` int(11) NOT NULL,
  `Description` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_ApiKeys_OwnerId` (`OwnerId`),
  CONSTRAINT `FK_ApiKeys_AspNetUsers_OwnerId` FOREIGN KEY (`OwnerId`) REFERENCES `AspNetUsers` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ApiKeys`
--

LOCK TABLES `ApiKeys` WRITE;
/*!40000 ALTER TABLE `ApiKeys` DISABLE KEYS */;
INSERT INTO `ApiKeys` VALUES (1,'admin API Key','api_u3o7i1au2wycki8awj1kdmp8',NULL,'2025-01-17 06:53:48.530000',NULL,'7b167275-a36e-436b-91e8-1db8380be252',0,15,NULL);
/*!40000 ALTER TABLE `ApiKeys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetRoleClaims`
--

DROP TABLE IF EXISTS `AspNetRoleClaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetRoleClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `RoleId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetRoleClaims_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetRoleClaims_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetRoleClaims`
--

LOCK TABLES `AspNetRoleClaims` WRITE;
/*!40000 ALTER TABLE `AspNetRoleClaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetRoleClaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetRoles`
--

DROP TABLE IF EXISTS `AspNetRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetRoles` (
  `Id` varchar(255) NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `NormalizedName` varchar(256) DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`NormalizedName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetRoles`
--

LOCK TABLES `AspNetRoles` WRITE;
/*!40000 ALTER TABLE `AspNetRoles` DISABLE KEYS */;
INSERT INTO `AspNetRoles` VALUES ('001bd9ac-1b89-45a8-b65d-b5a504ee8b86','Application','APPLICATION',NULL),('1d3bb402-872d-4888-8a34-9e8a493d41d9','Administrator','ADMINISTRATOR',NULL),('31bc5b7f-9490-4702-93b3-fa8d942a5b54','Customer','CUSTOMER',NULL),('4ea60054-5959-4e5a-b11f-85e10a0fc6ff','Sales','SALES',NULL),('f6a86e40-9af5-4925-a01f-9b7052d618b2','LicenseManager','LICENSEMANAGER',NULL);
/*!40000 ALTER TABLE `AspNetRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserClaims`
--

DROP TABLE IF EXISTS `AspNetUserClaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetUserClaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(255) NOT NULL,
  `ClaimType` longtext DEFAULT NULL,
  `ClaimValue` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_AspNetUserClaims_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserClaims_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserClaims`
--

LOCK TABLES `AspNetUserClaims` WRITE;
/*!40000 ALTER TABLE `AspNetUserClaims` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetUserClaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserLogins`
--

DROP TABLE IF EXISTS `AspNetUserLogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetUserLogins` (
  `LoginProvider` varchar(255) NOT NULL,
  `ProviderKey` varchar(255) NOT NULL,
  `ProviderDisplayName` longtext DEFAULT NULL,
  `UserId` varchar(255) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`),
  KEY `IX_AspNetUserLogins_UserId` (`UserId`),
  CONSTRAINT `FK_AspNetUserLogins_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserLogins`
--

LOCK TABLES `AspNetUserLogins` WRITE;
/*!40000 ALTER TABLE `AspNetUserLogins` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetUserLogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserRoles`
--

DROP TABLE IF EXISTS `AspNetUserRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetUserRoles` (
  `UserId` varchar(255) NOT NULL,
  `RoleId` varchar(255) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_AspNetUserRoles_RoleId` (`RoleId`),
  CONSTRAINT `FK_AspNetUserRoles_AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `AspNetRoles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_AspNetUserRoles_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserRoles`
--

LOCK TABLES `AspNetUserRoles` WRITE;
/*!40000 ALTER TABLE `AspNetUserRoles` DISABLE KEYS */;
INSERT INTO `AspNetUserRoles` VALUES ('7b167275-a36e-436b-91e8-1db8380be252','1d3bb402-872d-4888-8a34-9e8a493d41d9');
/*!40000 ALTER TABLE `AspNetUserRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUserTokens`
--

DROP TABLE IF EXISTS `AspNetUserTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetUserTokens` (
  `UserId` varchar(255) NOT NULL,
  `LoginProvider` varchar(255) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Value` longtext DEFAULT NULL,
  PRIMARY KEY (`UserId`,`LoginProvider`,`Name`),
  CONSTRAINT `FK_AspNetUserTokens_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUserTokens`
--

LOCK TABLES `AspNetUserTokens` WRITE;
/*!40000 ALTER TABLE `AspNetUserTokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `AspNetUserTokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AspNetUsers`
--

DROP TABLE IF EXISTS `AspNetUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AspNetUsers` (
  `Id` varchar(255) NOT NULL,
  `Title` longtext DEFAULT NULL,
  `FirstName` longtext DEFAULT NULL,
  `LastName` longtext DEFAULT NULL,
  `Department` longtext DEFAULT NULL,
  `BirthDate` datetime(6) DEFAULT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `LastDismissMessages` datetime(6) DEFAULT NULL,
  `LastLogIn` datetime(6) DEFAULT NULL,
  `Rank` int(11) DEFAULT NULL,
  `Image` longblob DEFAULT NULL,
  `Address` longtext DEFAULT NULL,
  `PostalCode` longtext DEFAULT NULL,
  `Region` longtext DEFAULT NULL,
  `City` longtext DEFAULT NULL,
  `Country` longtext DEFAULT NULL,
  `CountryCode` longtext DEFAULT NULL,
  `Mobile` longtext DEFAULT NULL,
  `Notes` longtext DEFAULT NULL,
  `CustomerId` int(11) DEFAULT NULL,
  `UserName` varchar(256) DEFAULT NULL,
  `NormalizedUserName` varchar(256) DEFAULT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `NormalizedEmail` varchar(256) DEFAULT NULL,
  `EmailConfirmed` tinyint(1) NOT NULL,
  `PasswordHash` longtext DEFAULT NULL,
  `SecurityStamp` longtext DEFAULT NULL,
  `ConcurrencyStamp` longtext DEFAULT NULL,
  `PhoneNumber` longtext DEFAULT NULL,
  `PhoneNumberConfirmed` tinyint(1) NOT NULL,
  `TwoFactorEnabled` tinyint(1) NOT NULL,
  `LockoutEnd` datetime(6) DEFAULT NULL,
  `LockoutEnabled` tinyint(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserNameIndex` (`NormalizedUserName`),
  KEY `EmailIndex` (`NormalizedEmail`),
  KEY `IX_AspNetUsers_CustomerId` (`CustomerId`),
  CONSTRAINT `FK_AspNetUsers_Customers_CustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AspNetUsers`
--

LOCK TABLES `AspNetUsers` WRITE;
/*!40000 ALTER TABLE `AspNetUsers` DISABLE KEYS */;
INSERT INTO `AspNetUsers` VALUES ('7b167275-a36e-436b-91e8-1db8380be252',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin','ADMIN','admin@email.com','ADMIN@EMAIL.COM',0,'AQAAAAIAAYagAAAAEOH9UqYgmQxzo4WIU0VwXqZQTMF5nlIfSNTk5+bCn8gqoYDovc4IVc/fp0GmDuTegQ==','OEXW6ST7IJGLX3B3MIAVQCVOV5L3SCTS','75965345-077e-4082-90ac-89c3dd6ed6a7',NULL,0,0,NULL,1,0);
/*!40000 ALTER TABLE `AspNetUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Assemblies`
--

DROP TABLE IF EXISTS `Assemblies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Assemblies` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Version` longtext DEFAULT NULL,
  `Culture` longtext DEFAULT NULL,
  `PublicKeyToken` longtext DEFAULT NULL,
  `MappingFileId` int(11) DEFAULT NULL,
  `DebugSymbolsKey` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Assemblies_MappingFileId` (`MappingFileId`),
  CONSTRAINT `FK_Assemblies_Resources_MappingFileId` FOREIGN KEY (`MappingFileId`) REFERENCES `Resources` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assemblies`
--

LOCK TABLES `Assemblies` WRITE;
/*!40000 ALTER TABLE `Assemblies` DISABLE KEYS */;
/*!40000 ALTER TABLE `Assemblies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contacts`
--

DROP TABLE IF EXISTS `Contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contacts` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` longtext DEFAULT NULL,
  `FirstName` longtext DEFAULT NULL,
  `LastName` longtext DEFAULT NULL,
  `Email` longtext DEFAULT NULL,
  `Phone` longtext DEFAULT NULL,
  `Mobile` longtext DEFAULT NULL,
  `Fax` longtext DEFAULT NULL,
  `Details` longtext DEFAULT NULL,
  `CustomerId` int(11) NOT NULL,
  `Meta` longtext DEFAULT NULL,
  `Notify` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `IX_Contacts_CustomerId` (`CustomerId`),
  CONSTRAINT `FK_Contacts_Customers_CustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contacts`
--

LOCK TABLES `Contacts` WRITE;
/*!40000 ALTER TABLE `Contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerResources`
--

DROP TABLE IF EXISTS `CustomerResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerResources` (
  `CustomerId` int(11) NOT NULL,
  `ResourceId` int(11) NOT NULL,
  PRIMARY KEY (`CustomerId`,`ResourceId`),
  KEY `IX_CustomerResources_ResourceId` (`ResourceId`),
  CONSTRAINT `FK_CustomerResources_Customers_CustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_CustomerResources_Resources_ResourceId` FOREIGN KEY (`ResourceId`) REFERENCES `Resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerResources`
--

LOCK TABLES `CustomerResources` WRITE;
/*!40000 ALTER TABLE `CustomerResources` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Title` longtext DEFAULT NULL,
  `FirstName` longtext DEFAULT NULL,
  `LastName` longtext DEFAULT NULL,
  `Company` longtext DEFAULT NULL,
  `Code` longtext DEFAULT NULL,
  `VatCode` longtext DEFAULT NULL,
  `InvoiceCode` longtext DEFAULT NULL,
  `Rating` int(11) NOT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `Address` longtext DEFAULT NULL,
  `Address1` longtext DEFAULT NULL,
  `Address2` longtext DEFAULT NULL,
  `PostalCode` longtext DEFAULT NULL,
  `Region` longtext DEFAULT NULL,
  `City` longtext DEFAULT NULL,
  `Country` longtext DEFAULT NULL,
  `CountryCode` longtext DEFAULT NULL,
  `MapCoordinates` longtext DEFAULT NULL,
  `MapZoomLevel` double DEFAULT NULL,
  `Email` longtext DEFAULT NULL,
  `Phone` longtext DEFAULT NULL,
  `Mobile` longtext DEFAULT NULL,
  `Fax` longtext DEFAULT NULL,
  `Website` longtext DEFAULT NULL,
  `Notes` longtext DEFAULT NULL,
  `IsReseller` tinyint(1) NOT NULL,
  `Image` longblob DEFAULT NULL,
  `Meta` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DownloadHistories`
--

DROP TABLE IF EXISTS `DownloadHistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DownloadHistories` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `CreatedAt` datetime(6) NOT NULL,
  `Count` int(11) NOT NULL,
  `DownloadId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_DownloadHistories_DownloadId` (`DownloadId`),
  CONSTRAINT `FK_DownloadHistories_Downloads_DownloadId` FOREIGN KEY (`DownloadId`) REFERENCES `Downloads` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DownloadHistories`
--

LOCK TABLES `DownloadHistories` WRITE;
/*!40000 ALTER TABLE `DownloadHistories` DISABLE KEYS */;
/*!40000 ALTER TABLE `DownloadHistories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Downloads`
--

DROP TABLE IF EXISTS `Downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Downloads` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Title` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `Public` tinyint(1) NOT NULL,
  `Track` tinyint(1) NOT NULL,
  `Alias` longtext DEFAULT NULL,
  `Url` longtext DEFAULT NULL,
  `ResourceId` int(11) DEFAULT NULL,
  `CustomerId` int(11) DEFAULT NULL,
  `OrderId` int(11) DEFAULT NULL,
  `UserId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Downloads_CustomerId` (`CustomerId`),
  KEY `IX_Downloads_OrderId` (`OrderId`),
  KEY `IX_Downloads_ResourceId` (`ResourceId`),
  KEY `IX_Downloads_UserId` (`UserId`),
  CONSTRAINT `FK_Downloads_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`),
  CONSTRAINT `FK_Downloads_Customers_CustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`Id`),
  CONSTRAINT `FK_Downloads_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `Orders` (`Id`),
  CONSTRAINT `FK_Downloads_Resources_ResourceId` FOREIGN KEY (`ResourceId`) REFERENCES `Resources` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Downloads`
--

LOCK TABLES `Downloads` WRITE;
/*!40000 ALTER TABLE `Downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `Downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LicenseTemplates`
--

DROP TABLE IF EXISTS `LicenseTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LicenseTemplates` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Code` longtext DEFAULT NULL,
  `Format` longtext DEFAULT NULL,
  `LicenseFileName` longtext DEFAULT NULL,
  `GenerateKeyInfo` tinyint(1) NOT NULL,
  `Description` longtext DEFAULT NULL,
  `Template` longtext DEFAULT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `SignatureKeysId` int(11) DEFAULT NULL,
  `ReleaseId` int(11) DEFAULT NULL,
  `ExpireDays` int(11) DEFAULT NULL,
  `IssueDate` tinyint(1) NOT NULL DEFAULT 0,
  `LicenseType` longtext DEFAULT NULL,
  `LicensingMode` int(11) NOT NULL DEFAULT 0,
  `SupportDays` int(11) DEFAULT NULL,
  `UserKey` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_LicenseTemplates_ProductId` (`ProductId`),
  KEY `IX_LicenseTemplates_ReleaseId` (`ReleaseId`),
  KEY `IX_LicenseTemplates_SignatureKeysId` (`SignatureKeysId`),
  CONSTRAINT `FK_LicenseTemplates_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`Id`),
  CONSTRAINT `FK_LicenseTemplates_Releases_ReleaseId` FOREIGN KEY (`ReleaseId`) REFERENCES `Releases` (`Id`),
  CONSTRAINT `FK_LicenseTemplates_Resources_SignatureKeysId` FOREIGN KEY (`SignatureKeysId`) REFERENCES `Resources` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LicenseTemplates`
--

LOCK TABLES `LicenseTemplates` WRITE;
/*!40000 ALTER TABLE `LicenseTemplates` DISABLE KEYS */;
INSERT INTO `LicenseTemplates` VALUES (1,'Licensed Product License Template','','XML','',0,'Licensed Product license template','<Licenses xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n  <License issueDate=\"2025-01-18T14:04:02.6599643Z\" supportExpireDate=\"2026-01-18T14:04:02.6599643Z\" type=\"Full\">\n    <Product name=\"Licensed Product\">\n      <Description>Licensed Test Product</Description>\n    </Product>\n  </License>\n</Licenses>',1,NULL,NULL,NULL,1,'Full',1,365,'');
/*!40000 ALTER TABLE `LicenseTemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LicenseTokens`
--

DROP TABLE IF EXISTS `LicenseTokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LicenseTokens` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Token` longtext DEFAULT NULL,
  `Address` longtext DEFAULT NULL,
  `ClientId` longtext DEFAULT NULL,
  `ClientName` longtext DEFAULT NULL,
  `MachineId` longtext DEFAULT NULL,
  `IssueDate` datetime(6) DEFAULT NULL,
  `ExpireDate` datetime(6) DEFAULT NULL,
  `LastHeartbeat` datetime(6) DEFAULT NULL,
  `Hash` longtext DEFAULT NULL,
  `LicenseId` int(11) DEFAULT NULL,
  `NodeLockedLicenseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_LicenseTokens_LicenseId` (`LicenseId`),
  KEY `IX_LicenseTokens_NodeLockedLicenseId` (`NodeLockedLicenseId`),
  CONSTRAINT `FK_LicenseTokens_Licenses_LicenseId` FOREIGN KEY (`LicenseId`) REFERENCES `Licenses` (`Id`),
  CONSTRAINT `FK_LicenseTokens_Licenses_NodeLockedLicenseId` FOREIGN KEY (`NodeLockedLicenseId`) REFERENCES `Licenses` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LicenseTokens`
--

LOCK TABLES `LicenseTokens` WRITE;
/*!40000 ALTER TABLE `LicenseTokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `LicenseTokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LicenseTraces`
--

DROP TABLE IF EXISTS `LicenseTraces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LicenseTraces` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ClientIp` longtext DEFAULT NULL,
  `ClientName` longtext DEFAULT NULL,
  `MachineId` longtext DEFAULT NULL,
  `CreatedDate` datetime(6) DEFAULT NULL,
  `Action` int(11) NOT NULL,
  `GeoLocation` longtext DEFAULT NULL,
  `Meta` longtext DEFAULT NULL,
  `LicenseId` int(11) DEFAULT NULL,
  `ClientId` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_LicenseTraces_LicenseId` (`LicenseId`),
  CONSTRAINT `FK_LicenseTraces_Licenses_LicenseId` FOREIGN KEY (`LicenseId`) REFERENCES `Licenses` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LicenseTraces`
--

LOCK TABLES `LicenseTraces` WRITE;
/*!40000 ALTER TABLE `LicenseTraces` DISABLE KEYS */;
INSERT INTO `LicenseTraces` VALUES (1,'::ffff:172.18.0.4',NULL,NULL,'2025-01-18 14:03:27.014492',1,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `LicenseTraces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Licenses`
--

DROP TABLE IF EXISTS `Licenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Licenses` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `LicenseId` longtext DEFAULT NULL,
  `LicenseType` longtext DEFAULT NULL,
  `Format` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `IssueDate` datetime(6) DEFAULT NULL,
  `ExpireDate` datetime(6) DEFAULT NULL,
  `SupportExpireDate` datetime(6) DEFAULT NULL,
  `Revoked` tinyint(1) NOT NULL,
  `LicenseKey` longtext DEFAULT NULL,
  `MaxAllowedSites` int(11) DEFAULT NULL,
  `UserKey` longtext DEFAULT NULL,
  `Hash` longtext DEFAULT NULL,
  `LicensingMode` int(11) NOT NULL,
  `TemplateId` int(11) DEFAULT NULL,
  `SignatureKeysId` int(11) DEFAULT NULL,
  `CustomerId` int(11) DEFAULT NULL,
  `OrderId` int(11) DEFAULT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `LicenseeCompany` longtext DEFAULT NULL,
  `LicenseeEmail` longtext DEFAULT NULL,
  `LicenseeName` longtext DEFAULT NULL,
  `Meta` longtext DEFAULT NULL,
  `Trace` tinyint(1) NOT NULL DEFAULT 0,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Licenses_CustomerId` (`CustomerId`),
  KEY `IX_Licenses_OrderId` (`OrderId`),
  KEY `IX_Licenses_SignatureKeysId` (`SignatureKeysId`),
  KEY `IX_Licenses_TemplateId` (`TemplateId`),
  CONSTRAINT `FK_Licenses_Customers_CustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`Id`),
  CONSTRAINT `FK_Licenses_LicenseTemplates_TemplateId` FOREIGN KEY (`TemplateId`) REFERENCES `LicenseTemplates` (`Id`),
  CONSTRAINT `FK_Licenses_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `Orders` (`Id`),
  CONSTRAINT `FK_Licenses_Resources_SignatureKeysId` FOREIGN KEY (`SignatureKeysId`) REFERENCES `Resources` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Licenses`
--

LOCK TABLES `Licenses` WRITE;
/*!40000 ALTER TABLE `Licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `Licenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Logs`
--

DROP TABLE IF EXISTS `Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Logs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Message` longtext DEFAULT NULL,
  `MessageTemplate` longtext DEFAULT NULL,
  `Level` longtext DEFAULT NULL,
  `TimeStamp` datetime(6) NOT NULL,
  `Exception` longtext DEFAULT NULL,
  `Properties` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Logs`
--

LOCK TABLES `Logs` WRITE;
/*!40000 ALTER TABLE `Logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderResources`
--

DROP TABLE IF EXISTS `OrderResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderResources` (
  `OrderId` int(11) NOT NULL,
  `ResourceId` int(11) NOT NULL,
  PRIMARY KEY (`OrderId`,`ResourceId`),
  KEY `IX_OrderResources_ResourceId` (`ResourceId`),
  CONSTRAINT `FK_OrderResources_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `Orders` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_OrderResources_Resources_ResourceId` FOREIGN KEY (`ResourceId`) REFERENCES `Resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderResources`
--

LOCK TABLES `OrderResources` WRITE;
/*!40000 ALTER TABLE `OrderResources` DISABLE KEYS */;
/*!40000 ALTER TABLE `OrderResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNumber` longtext DEFAULT NULL,
  `Status` longtext DEFAULT NULL,
  `ProcessedBy` longtext DEFAULT NULL,
  `PurchaseOrder` longtext DEFAULT NULL,
  `Total` decimal(18,4) DEFAULT NULL,
  `Currency` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `InvoiceNumber` longtext DEFAULT NULL,
  `PaymentType` longtext DEFAULT NULL,
  `PaymentNumber` longtext DEFAULT NULL,
  `PaymentStatus` longtext DEFAULT NULL,
  `PaymentDate` datetime(6) DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `CustomerId` int(11) DEFAULT NULL,
  `ResellerId` int(11) DEFAULT NULL,
  `CreatedById` varchar(255) DEFAULT NULL,
  `Meta` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Orders_CreatedById` (`CreatedById`),
  KEY `IX_Orders_CustomerId` (`CustomerId`),
  KEY `IX_Orders_ResellerId` (`ResellerId`),
  CONSTRAINT `FK_Orders_AspNetUsers_CreatedById` FOREIGN KEY (`CreatedById`) REFERENCES `AspNetUsers` (`Id`),
  CONSTRAINT `FK_Orders_Customers_CustomerId` FOREIGN KEY (`CustomerId`) REFERENCES `Customers` (`Id`),
  CONSTRAINT `FK_Orders_Customers_ResellerId` FOREIGN KEY (`ResellerId`) REFERENCES `Customers` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductAssemblies`
--

DROP TABLE IF EXISTS `ProductAssemblies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductAssemblies` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ProductId` int(11) NOT NULL,
  `AssemblyId` int(11) DEFAULT NULL,
  `ReleaseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_ProductAssemblies_AssemblyId` (`AssemblyId`),
  KEY `IX_ProductAssemblies_ProductId` (`ProductId`),
  KEY `IX_ProductAssemblies_ReleaseId` (`ReleaseId`),
  CONSTRAINT `FK_ProductAssemblies_Assemblies_AssemblyId` FOREIGN KEY (`AssemblyId`) REFERENCES `Assemblies` (`Id`),
  CONSTRAINT `FK_ProductAssemblies_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ProductAssemblies_Releases_ReleaseId` FOREIGN KEY (`ReleaseId`) REFERENCES `Releases` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductAssemblies`
--

LOCK TABLES `ProductAssemblies` WRITE;
/*!40000 ALTER TABLE `ProductAssemblies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProductAssemblies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductLicenses`
--

DROP TABLE IF EXISTS `ProductLicenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductLicenses` (
  `ProductId` int(11) NOT NULL,
  `LicenseId` int(11) NOT NULL,
  PRIMARY KEY (`ProductId`,`LicenseId`),
  KEY `IX_ProductLicenses_LicenseId` (`LicenseId`),
  CONSTRAINT `FK_ProductLicenses_Licenses_LicenseId` FOREIGN KEY (`LicenseId`) REFERENCES `Licenses` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ProductLicenses_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductLicenses`
--

LOCK TABLES `ProductLicenses` WRITE;
/*!40000 ALTER TABLE `ProductLicenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProductLicenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductOrders`
--

DROP TABLE IF EXISTS `ProductOrders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductOrders` (
  `ProductId` int(11) NOT NULL,
  `OrderId` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `UnitPrice` decimal(18,4) DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Taxes` double DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  PRIMARY KEY (`ProductId`,`OrderId`),
  KEY `IX_ProductOrders_OrderId` (`OrderId`),
  CONSTRAINT `FK_ProductOrders_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `Orders` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ProductOrders_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductOrders`
--

LOCK TABLES `ProductOrders` WRITE;
/*!40000 ALTER TABLE `ProductOrders` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProductOrders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProductResources`
--

DROP TABLE IF EXISTS `ProductResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductResources` (
  `ProductId` int(11) NOT NULL,
  `ResourceId` int(11) NOT NULL,
  PRIMARY KEY (`ProductId`,`ResourceId`),
  KEY `IX_ProductResources_ResourceId` (`ResourceId`),
  CONSTRAINT `FK_ProductResources_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `Products` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ProductResources_Resources_ResourceId` FOREIGN KEY (`ResourceId`) REFERENCES `Resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductResources`
--

LOCK TABLES `ProductResources` WRITE;
/*!40000 ALTER TABLE `ProductResources` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProductResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Products` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` longtext DEFAULT NULL,
  `Name` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `Url` longtext DEFAULT NULL,
  `Copyright` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `Image` longblob DEFAULT NULL,
  `Price` decimal(18,4) DEFAULT NULL,
  `ResellerPrice` decimal(18,4) DEFAULT NULL,
  `Currency` longtext DEFAULT NULL,
  `SignatureKeysId` int(11) DEFAULT NULL,
  `Meta` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Products_SignatureKeysId` (`SignatureKeysId`),
  CONSTRAINT `FK_Products_Resources_SignatureKeysId` FOREIGN KEY (`SignatureKeysId`) REFERENCES `Resources` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (1,'TP1','Licensed Product','Licensed Test Product',NULL,NULL,'2025-01-17 07:43:05.000000','',0.0000,0.0000,'USD',1,NULL);
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReleaseResources`
--

DROP TABLE IF EXISTS `ReleaseResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReleaseResources` (
  `ReleaseId` int(11) NOT NULL,
  `ResourceId` int(11) NOT NULL,
  PRIMARY KEY (`ReleaseId`,`ResourceId`),
  KEY `IX_ReleaseResources_ResourceId` (`ResourceId`),
  CONSTRAINT `FK_ReleaseResources_Releases_ReleaseId` FOREIGN KEY (`ReleaseId`) REFERENCES `Releases` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_ReleaseResources_Resources_ResourceId` FOREIGN KEY (`ResourceId`) REFERENCES `Resources` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReleaseResources`
--

LOCK TABLES `ReleaseResources` WRITE;
/*!40000 ALTER TABLE `ReleaseResources` DISABLE KEYS */;
/*!40000 ALTER TABLE `ReleaseResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Releases`
--

DROP TABLE IF EXISTS `Releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Releases` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ReleaseDate` datetime(6) NOT NULL,
  `Name` longtext DEFAULT NULL,
  `Version` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Releases`
--

LOCK TABLES `Releases` WRITE;
/*!40000 ALTER TABLE `Releases` DISABLE KEYS */;
/*!40000 ALTER TABLE `Releases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReportProperties`
--

DROP TABLE IF EXISTS `ReportProperties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReportProperties` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Value` longtext DEFAULT NULL,
  `ReportId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_ReportProperties_ReportId` (`ReportId`),
  CONSTRAINT `FK_ReportProperties_Reports_ReportId` FOREIGN KEY (`ReportId`) REFERENCES `Reports` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReportProperties`
--

LOCK TABLES `ReportProperties` WRITE;
/*!40000 ALTER TABLE `ReportProperties` DISABLE KEYS */;
/*!40000 ALTER TABLE `ReportProperties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reports`
--

DROP TABLE IF EXISTS `Reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reports` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Uid` longtext DEFAULT NULL,
  `Name` longtext DEFAULT NULL,
  `Version` longtext DEFAULT NULL,
  `Date` datetime(6) DEFAULT NULL,
  `UserKey` longtext DEFAULT NULL,
  `MachineId` longtext DEFAULT NULL,
  `ClientId` longtext DEFAULT NULL,
  `ClientName` longtext DEFAULT NULL,
  `ContentType` longtext DEFAULT NULL,
  `Content` longtext DEFAULT NULL,
  `Address` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reports`
--

LOCK TABLES `Reports` WRITE;
/*!40000 ALTER TABLE `Reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Resources`
--

DROP TABLE IF EXISTS `Resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Resources` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Type` longtext DEFAULT NULL,
  `Code` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `Source` longtext DEFAULT NULL,
  `Password` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `Data` longblob DEFAULT NULL,
  `DataFormat` longtext DEFAULT NULL,
  `Meta` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Resources`
--

LOCK TABLES `Resources` WRITE;
/*!40000 ALTER TABLE `Resources` DISABLE KEYS */;
INSERT INTO `Resources` (`Id`, `Name`, `Type`, `Code`, `Description`, `Source`, `Password`, `CreatedAt`, `UpdatedAt`, `Data`, `DataFormat`, `Meta`) VALUES
(1, 'Keys', 'RSA', NULL, NULL, 'Keys.snk', NULL, '2025-01-18 20:12:33.458937', NULL, X'07020000002400005253413200040000010001000D6E4C8A9CFC8651DC909BCBCF01E29F3E5AA23CDC81F5638E2BA849F8850D853E2B65D8A7695C2E6B9211B00CA9C39741D3AB8E8C90EEB8C35BF846E097AEC436B14A5604733BF7FD4490B09DFC0D1004D171BCB95C841279AB7D34BBC467316F4BAB7F33E69BE3C8D07124469DF122235835BBF72A59257EFADA216254D5C47F0EFA749791F82B3470FD7B093E85160F1C6A46F31E71E6A670E9758536C6999B8C84E5AC5BF098A214D17F402220DA171E7ACD52E082D45E8AEF86469CDCE373957858355C8F19B912275183A84D94104ED52EEFFF60CB72C7A4F15E18CB6A291357EFF7043D343E9D3C16EC06450DDE2D870801517E3BD277BEC251D123DDB18DE81818A01976B092BE87D0298C682F915AA015DEDA118722D4E875AF423F452245B5F3D9456543FA940BFA1BA85C13DB2D216EA7AD5A8D447814C8C62B188B836F26185387515D241FE125F090E996292199D86C6C049529D99BCAA433D2E8E938267827DCED506CD0B137D7716F5F0CDD799B8076882BDA8F174CADE36829E4DFA8607393DF0C626B4576A5E234F14270D0E317E9EB6E7DD1F2D3C3635E2B3166EF0668DD97604C09560D182689D033A2213F4654DEC195D69864F94947D94B756E9F4723645CAC13D915198A517F0E93EE65C1F46567627128343D6AFC54076E802EEA1409F12C2C38B43BB296B861B675596BD6A9B66662465A596779DE132F9665DDB8097A894339180FDCB2E1A3E0A13BB51695B76E6EEB54D6C4397B4BFF73AA592D9A7A542581A7F904771AE7465BE973DCE62656231700807272', 'SNK', NULL),
(3, 'New License', 'email', NULL, 'Sent to customer when a new license is purchased.', NULL, NULL, '2025-01-20 07:50:32.007000', '2025-01-23 09:31:21.940111', '<p><span style=\"color: rgb(0, 0, 0);\">Dear <span class=\"dx-variable\" data-var-start-esc-char=\"{\" data-var-end-esc-char=\"}\" data-var-value=\"CustomerName\">﻿<span contenteditable=\"false\">{CustomerName}</span>﻿</span>,</span></p><p><span style=\"color: rgb(0, 0, 0);\">Thank you very much for purchasing <span class=\"dx-variable\" data-var-start-esc-char=\"{\" data-var-end-esc-char=\"}\" data-var-value=\"ProductName\">﻿<span contenteditable=\"false\">{ProductName}</span>﻿</span> license.<br>You can download the setup packages for 32 and 64-bit platforms from:</span></p><p><a href=\"{ProductDownload}\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 0, 0);\"><span class=\"dx-variable\" data-var-start-esc-char=\"{\" data-var-end-esc-char=\"}\" data-var-value=\"ProductDownload\">﻿<span contenteditable=\"false\">{ProductDownload}</span>﻿</span></a></p><p><span style=\"color: rgb(0, 0, 0);\">Your license <span class=\"dx-variable\" data-var-start-esc-char=\"{\" data-var-end-esc-char=\"}\" data-var-value=\"LicenseId\">﻿<span contenteditable=\"false\">{LicenseId}</span>﻿</span> Key:</span></p><p><strong style=\"color: rgb(0, 0, 0); font-size: 12pt;\"><span class=\"dx-variable\" data-var-start-esc-char=\"{\" data-var-end-esc-char=\"}\" data-var-value=\"UserKey\">﻿<span contenteditable=\"false\">{UserKey}</span>﻿</span></strong></p><h2><span style=\"color: rgb(0, 0, 0);\">What&#39;s New</span></h2><p><span style=\"color: rgb(0, 0, 0); font-family: Helvetica;\">For more detailed information about the new features, enhancements, and bug fixes introduced in this release, please refer to the release notes at: </span></p><p><a href=\"https://www.acme.com/releasenotes\" rel=\"noopener noreferrer\" target=\"_blank\">https://www.acme.com/releasenotes</a></p><p><span style=\"color: rgb(0, 0, 0);\">Should you have any questions about this release, feel free to contact our support team.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Thank you,<br>Kind Regards</span></p>', 'html', '{\"enable_send\":\"true\",\"email_subject\":\"{ProductName} License\",\"email_cc\":\"\",\"email_bcc\":\"\"}');
/*!40000 ALTER TABLE `Resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ScriptTag`
--

DROP TABLE IF EXISTS `ScriptTag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ScriptTag` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Version` longtext DEFAULT NULL,
  `Tag` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `SourceCode` longtext DEFAULT NULL,
  `Metadata` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `ScriptId` int(11) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_ScriptTag_ScriptId` (`ScriptId`),
  CONSTRAINT `FK_ScriptTag_Scripts_ScriptId` FOREIGN KEY (`ScriptId`) REFERENCES `Scripts` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ScriptTag`
--

LOCK TABLES `ScriptTag` WRITE;
/*!40000 ALTER TABLE `ScriptTag` DISABLE KEYS */;
/*!40000 ALTER TABLE `ScriptTag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Scripts`
--

DROP TABLE IF EXISTS `Scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Scripts` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` longtext DEFAULT NULL,
  `Category` longtext DEFAULT NULL,
  `Version` longtext DEFAULT NULL,
  `CreatedAt` datetime(6) DEFAULT NULL,
  `UpdatedAt` datetime(6) DEFAULT NULL,
  `Language` longtext DEFAULT NULL,
  `SourceCode` longtext DEFAULT NULL,
  `Metadata` longtext DEFAULT NULL,
  `Description` longtext DEFAULT NULL,
  `AuthorId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Scripts_AuthorId` (`AuthorId`),
  CONSTRAINT `FK_Scripts_AspNetUsers_AuthorId` FOREIGN KEY (`AuthorId`) REFERENCES `AspNetUsers` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Scripts`
--

LOCK TABLES `Scripts` WRITE;
/*!40000 ALTER TABLE `Scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Settings`
--

DROP TABLE IF EXISTS `Settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Settings` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Category` longtext DEFAULT NULL,
  `Group` longtext DEFAULT NULL,
  `Name` longtext DEFAULT NULL,
  `Value` longtext DEFAULT NULL,
  `Type` longtext DEFAULT NULL,
  `ReadOnly` tinyint(1) NOT NULL,
  `Description` longtext DEFAULT NULL,
  `UserId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `IX_Settings_UserId` (`UserId`),
  CONSTRAINT `FK_Settings_AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AspNetUsers` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Settings`
--

LOCK TABLES `Settings` WRITE;
/*!40000 ALTER TABLE `Settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `Settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `__EFMigrationsHistory`
--

DROP TABLE IF EXISTS `__EFMigrationsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__EFMigrationsHistory`
--

LOCK TABLES `__EFMigrationsHistory` WRITE;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;
INSERT INTO `__EFMigrationsHistory` VALUES ('20230506062747_InitialCreate','8.0.11'),('20231203102929_AddApiKey','8.0.11'),('20240303012534_AddedLicenseeAndTemplateUserKey','8.0.11'),('20240313135659_AddMetaColum','8.0.11'),('20240328144418_AddLicenseTrace','8.0.11'),('20241206143314_AddLicenseTraceClientId','8.0.11');
/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'licenses'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-20  9:00:12
