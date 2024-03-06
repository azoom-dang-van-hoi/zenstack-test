-- CreateTable
CREATE TABLE `notification` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `created_organization_id` INTEGER NULL,
    `content_type` INTEGER NOT NULL,
    `history_id` VARCHAR(191) NULL,
    `email` VARCHAR(255) NOT NULL,
    `contractor_id` INTEGER NULL,
    `content` VARCHAR(255) NOT NULL,
    `detail_title` VARCHAR(60) NULL,
    `detail_url` VARCHAR(255) NULL,
    `target` INTEGER NOT NULL,
    `read_datetime` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `notification` ADD CONSTRAINT `notification_contractor_id_fkey` FOREIGN KEY (`contractor_id`) REFERENCES `contractor`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
