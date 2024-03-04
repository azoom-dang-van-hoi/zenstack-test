-- AlterTable
ALTER TABLE `parking_contract` ADD COLUMN `contractor_id` INTEGER NULL;

-- AlterTable
ALTER TABLE `user_procedure` ADD COLUMN `contractor_id` INTEGER NULL;

-- CreateTable
CREATE TABLE `contractor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `contractor_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `parking_contract` ADD CONSTRAINT `parking_contract_contractor_id_fkey` FOREIGN KEY (`contractor_id`) REFERENCES `contractor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_procedure` ADD CONSTRAINT `user_procedure_contractor_id_fkey` FOREIGN KEY (`contractor_id`) REFERENCES `contractor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
