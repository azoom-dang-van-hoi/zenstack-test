INSERT INTO `organization` VALUES (1,'ORG-1','HN','399949494','9393383883','org-1@azoom.jp','2024-02-16 14:50:59.180','2024-02-16 14:50:59.180'),(2,'ORG-2','GN','30303030','30303003',NULL,'2024-02-16 14:50:59.180','2024-02-16 14:50:59.180');

INSERT INTO `organization_staff` VALUES (1,1,'org-11@gmail.com','Org staff 1',NULL,1,'2024-02-09 08:12:53.617','2024-02-09 08:12:53.617'),(2,1,'org-12@gmail.com','Org-12',NULL,1,'2024-02-09 08:13:27.919','2024-02-09 08:13:27.919'),(3,2,'org-21@gmail.com','Org 21',NULL,1,'2024-02-18 16:34:53.407','2024-02-18 16:34:53.407');

INSERT INTO `region` VALUES (1,1,'KIU','098777','2024-02-16 16:24:03.129','2024-02-16 16:24:03.129'),(2,2,'Jhu','09876','2024-02-18 16:34:16.821','2024-02-18 16:34:16.821');

INSERT INTO `organization_staff_region` VALUES (1,1,1,'2024-02-16 16:25:32.522','2024-02-16 16:25:32.522'),(2,3,2,'2024-02-18 16:35:05.358','2024-02-18 16:35:05.358');

INSERT INTO `parking` VALUES (1,1,'P1','1234567','HN','2024-02-09 08:11:36.987','2024-02-09 08:11:36.987',1),(2,1,'P2','1234567','BN','2024-02-09 08:15:19.624','2024-02-09 08:15:19.624',NULL),(3,1,'Parking 1',NULL,NULL,'2024-02-18 16:19:15.316','2024-02-18 16:19:15.316',NULL),(4,1,'Parking 1',NULL,'123456789','2024-02-18 16:25:46.646','2024-02-18 16:25:46.646',NULL),(5,1,'Parking 1',NULL,'123456','2024-02-18 16:32:38.849','2024-02-18 16:32:38.849',NULL);
INSERT INTO `zenstack-test`.`parking` (`organization_id`, `name`, `zip`, `address`) VALUES ('2', 'Parking 2', '1234567', 'HN');

INSERT INTO `zenstack-test`.`parking_contract` (`parking_id`, `status`) 
VALUES ('1', '1'), ('2', '1'), ('3', '1'), ('4', '1'), ('5', '1'), ('6', '1');

INSERT INTO `zenstack-test`.`user_procedure` (`parking_contract_id`, `status`, `type`) VALUES ('1', '1', '2');
INSERT INTO `zenstack-test`.`user_procedure` (`organization_id`, `status`, `type`) VALUES ('1', '1', '1');
INSERT INTO `zenstack-test`.`user_procedure` (`organization_id`, `status`, `type`) VALUES ('2', '1', '1');
INSERT INTO `zenstack-test`.`user_procedure` (`parking_contract_id`, `status`, `type`) VALUES ('6', '1', '2');
INSERT INTO `zenstack-test`.`user_procedure` (`parking_contract_id`, `status`, `type`) VALUES ('2', '1', '3');

INSERT INTO `zenstack-test`.`contractor` (`name`, `email`) 
VALUES ('Contractor 1', 'contractor-1@gmail.com'), ('Contractor 2', 'contractor-2@gmail.com');

UPDATE `zenstack-test`.`parking_contract` SET `contractor_id` = '1' WHERE (`id` = '1');
UPDATE `zenstack-test`.`parking_contract` SET `contractor_id` = '1' WHERE (`id` = '2');
UPDATE `zenstack-test`.`parking_contract` SET `contractor_id` = '2' WHERE (`id` = '3');
UPDATE `zenstack-test`.`parking_contract` SET `contractor_id` = '2' WHERE (`id` = '4');
UPDATE `zenstack-test`.`parking_contract` SET `contractor_id` = '1' WHERE (`id` = '5');
UPDATE `zenstack-test`.`parking_contract` SET `contractor_id` = '2' WHERE (`id` = '6');

UPDATE `zenstack-test`.`user_procedure` SET `contractor_id` = '1' WHERE (`id` = '3');
UPDATE `zenstack-test`.`user_procedure` SET `contractor_id` = '2' WHERE (`id` = '4');
