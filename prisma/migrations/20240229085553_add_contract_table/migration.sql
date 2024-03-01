-- CreateTable
CREATE TABLE `parking_id` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `parkingId` INTEGER NOT NULL,
    `status` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_procedure` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `parking_contract_id` INTEGER NULL,
    `organization_id` INTEGER NULL,
    `status` TINYINT NOT NULL,
    `type` INTEGER NOT NULL,
    `content` JSON NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `parking_id` ADD CONSTRAINT `parking_id_parkingId_fkey` FOREIGN KEY (`parkingId`) REFERENCES `parking`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_procedure` ADD CONSTRAINT `user_procedure_parking_contract_id_fkey` FOREIGN KEY (`parking_contract_id`) REFERENCES `parking_id`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_procedure` ADD CONSTRAINT `user_procedure_organization_id_fkey` FOREIGN KEY (`organization_id`) REFERENCES `organization`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
