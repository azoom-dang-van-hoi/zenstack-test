-- CreateTable
CREATE TABLE `organization` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NULL,
    `tel` VARCHAR(20) NULL,
    `fax` VARCHAR(20) NULL,
    `email` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organization_staff` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `organization_id` INTEGER NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `name` VARCHAR(100) NULL,
    `privilege` JSON NULL,
    `has_email_notif` TINYINT NOT NULL,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `staff_location_management` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `organization_staff_id` INTEGER NOT NULL,
    `location_id` INTEGER NOT NULL,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `parking` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `location_id` INTEGER NULL,
    `organization_id` INTEGER NOT NULL,
    `name` VARCHAR(60) NOT NULL,
    `zip` VARCHAR(10) NULL,
    `address` VARCHAR(255) NULL,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `location` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(60) NOT NULL,
    `zip` VARCHAR(10) NULL,
    `address` VARCHAR(255) NULL,
    `created_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_datetime` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `organization_staff` ADD CONSTRAINT `organization_staff_organization_id_fkey` FOREIGN KEY (`organization_id`) REFERENCES `organization`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `staff_location_management` ADD CONSTRAINT `staff_location_management_organization_staff_id_fkey` FOREIGN KEY (`organization_staff_id`) REFERENCES `organization_staff`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `staff_location_management` ADD CONSTRAINT `staff_location_management_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `location`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `parking` ADD CONSTRAINT `parking_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `location`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `parking` ADD CONSTRAINT `parking_organization_id_fkey` FOREIGN KEY (`organization_id`) REFERENCES `organization`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
