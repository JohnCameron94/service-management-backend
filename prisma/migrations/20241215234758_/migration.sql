/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `User`;

-- CreateTable
CREATE TABLE `user` (
    `uuid` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `firstname` TEXT NULL,
    `lastname` TEXT NULL,
    `idToken` VARCHAR(100) NULL,
    `authenticationUser` VARCHAR(100) NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,

    UNIQUE INDEX `user_email_key`(`email`),
    INDEX `user_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `device` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `uuid` VARCHAR(36) NULL,
    `name` TEXT NULL,
    `type` INTEGER NOT NULL DEFAULT 0,
    `pushToken` TEXT NULL,
    `voipToken` TEXT NULL,
    `production` BOOLEAN NOT NULL DEFAULT true,
    `appVersion` VARCHAR(24) NULL DEFAULT '0',
    `appBuild` INTEGER NULL DEFAULT 0,
    `siwaIdentityToken` TEXT NULL,
    `siwaAuthorizationCode` TEXT NULL,
    `siwaAccessToken` TEXT NULL,
    `siwaRefreshToken` TEXT NULL,
    `siwaTokenExpiry` DATETIME(3) NULL,
    `lastViewedAt` DATETIME(3) NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,
    `user_uuid` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `device_uuid_key`(`uuid`),
    INDEX `fk_device_user_idx`(`user_uuid`),
    INDEX `device_uuid_idx`(`uuid`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `super_user` (
    `uuid` VARCHAR(191) NOT NULL,
    `user_uuid` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `super_user_user_uuid_key`(`user_uuid`),
    INDEX `super_user_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `device` ADD CONSTRAINT `fk_device_user` FOREIGN KEY (`user_uuid`) REFERENCES `user`(`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `super_user` ADD CONSTRAINT `super_user_user_uuid_fkey` FOREIGN KEY (`user_uuid`) REFERENCES `user`(`uuid`) ON DELETE RESTRICT ON UPDATE CASCADE;
