/*
  Warnings:

  - You are about to drop the `parking_id` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `parking_id` DROP FOREIGN KEY `parking_id_parkingId_fkey`;

-- DropForeignKey
ALTER TABLE `user_procedure` DROP FOREIGN KEY `user_procedure_parking_contract_id_fkey`;

-- DropTable
DROP TABLE `parking_id`;

-- CreateTable
CREATE TABLE `parking_contract` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `parking_id` INTEGER NOT NULL,
    `status` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `parking_contract` ADD CONSTRAINT `parking_contract_parking_id_fkey` FOREIGN KEY (`parking_id`) REFERENCES `parking`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_procedure` ADD CONSTRAINT `user_procedure_parking_contract_id_fkey` FOREIGN KEY (`parking_contract_id`) REFERENCES `parking_contract`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
