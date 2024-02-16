/*
  Warnings:

  - You are about to drop the column `location_id` on the `parking` table. All the data in the column will be lost.
  - You are about to drop the `location` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `staff_location_management` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `parking` DROP FOREIGN KEY `parking_location_id_fkey`;

-- DropForeignKey
ALTER TABLE `staff_location_management` DROP FOREIGN KEY `staff_location_management_location_id_fkey`;

-- DropForeignKey
ALTER TABLE `staff_location_management` DROP FOREIGN KEY `staff_location_management_organization_staff_id_fkey`;

-- AlterTable
ALTER TABLE `parking` DROP COLUMN `location_id`,
    ADD COLUMN `region_id` INTEGER NULL;

-- DropTable
DROP TABLE `location`;

-- DropTable
DROP TABLE `staff_location_management`;

-- CreateTable
CREATE TABLE `organization_staff_region` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `organization_staff_id` INTEGER NOT NULL,
    `region_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `region` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `organization_id` INTEGER NOT NULL,
    `name` VARCHAR(60) NOT NULL,
    `zip` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `organization_staff_region` ADD CONSTRAINT `organization_staff_region_organization_staff_id_fkey` FOREIGN KEY (`organization_staff_id`) REFERENCES `organization_staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `organization_staff_region` ADD CONSTRAINT `organization_staff_region_region_id_fkey` FOREIGN KEY (`region_id`) REFERENCES `region`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `parking` ADD CONSTRAINT `parking_region_id_fkey` FOREIGN KEY (`region_id`) REFERENCES `region`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `region` ADD CONSTRAINT `region_organization_id_fkey` FOREIGN KEY (`organization_id`) REFERENCES `organization`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
