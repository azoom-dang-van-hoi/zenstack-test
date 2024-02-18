LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES ('60156518-6efc-4ea2-bf3e-8ebc14d3dc67','ca5f98a64d95b995812801feb7c35b2ff81c4b39eda94067604d39e0c5c69c5a','2024-02-09 08:09:47.732','20240209080947_init_database',NULL,NULL,'2024-02-09 08:09:47.558',1),('a3a84180-719c-4725-8b81-91983830d72b','ad1079f5ab0dbd4eca7d012cf1d0016f1093dab2ab756f84226285d9872603f3','2024-02-16 14:50:59.236','20240216145059_add_column_created_datetime',NULL,NULL,'2024-02-16 14:50:59.189',1),('d31fb0ae-f5be-4d51-bf7f-3cee743bf0ea','8476c8cf475e3f748f9094a070cb48c874956813cab39c6ef83f2f33ebb8ddd6','2024-02-16 06:19:04.306','20240216061904_add_table_region',NULL,NULL,'2024-02-16 06:19:04.083',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,'ORG-1','HN','399949494','9393383883','org-1@azoom.jp','2024-02-16 14:50:59.180','2024-02-16 14:50:59.180'),(2,'ORG-2','GN','30303030','30303003',NULL,'2024-02-16 14:50:59.180','2024-02-16 14:50:59.180');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organization_staff`
--

LOCK TABLES `organization_staff` WRITE;
/*!40000 ALTER TABLE `organization_staff` DISABLE KEYS */;
INSERT INTO `organization_staff` VALUES (1,1,'org-11@gmail.com','Org staff 1',NULL,1,'2024-02-09 08:12:53.617','2024-02-09 08:12:53.617'),(2,1,'org-12@gmail.com','Org-12',NULL,1,'2024-02-09 08:13:27.919','2024-02-09 08:13:27.919'),(3,2,'org-21@gmail.com','Org 21',NULL,1,'2024-02-18 16:34:53.407','2024-02-18 16:34:53.407');
/*!40000 ALTER TABLE `organization_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organization_staff_region`
--

LOCK TABLES `organization_staff_region` WRITE;
/*!40000 ALTER TABLE `organization_staff_region` DISABLE KEYS */;
INSERT INTO `organization_staff_region` VALUES (1,1,1,'2024-02-16 16:25:32.522','2024-02-16 16:25:32.522'),(2,3,2,'2024-02-18 16:35:05.358','2024-02-18 16:35:05.358');
/*!40000 ALTER TABLE `organization_staff_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `parking`
--

LOCK TABLES `parking` WRITE;
/*!40000 ALTER TABLE `parking` DISABLE KEYS */;
INSERT INTO `parking` VALUES (1,1,'P1','1234567','HN','2024-02-09 08:11:36.987','2024-02-09 08:11:36.987',1),(2,1,'P2','1234567','BN','2024-02-09 08:15:19.624','2024-02-09 08:15:19.624',NULL),(3,1,'Parking 1',NULL,NULL,'2024-02-18 16:19:15.316','2024-02-18 16:19:15.316',NULL),(4,1,'Parking 1',NULL,'123456789','2024-02-18 16:25:46.646','2024-02-18 16:25:46.646',NULL),(5,1,'Parking 1',NULL,'123456','2024-02-18 16:32:38.849','2024-02-18 16:32:38.849',NULL);
/*!40000 ALTER TABLE `parking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1,1,'KIU','098777','2024-02-16 16:24:03.129','2024-02-16 16:24:03.129'),(2,2,'Jhu','09876','2024-02-18 16:34:16.821','2024-02-18 16:34:16.821');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;