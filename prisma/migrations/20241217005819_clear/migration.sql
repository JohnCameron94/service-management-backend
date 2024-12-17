/*
  Warnings:

  - The primary key for the `device` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `device` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `firstname` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `lastname` on the `user` table. All the data in the column will be lost.
  - You are about to drop the `super_user` table. If the table is not empty, all the data it contains will be lost.
  - Made the column `uuid` on table `device` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `employee_uuid` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `device` DROP FOREIGN KEY `fk_device_user`;

-- DropForeignKey
ALTER TABLE `super_user` DROP FOREIGN KEY `super_user_user_uuid_fkey`;

-- DropIndex
DROP INDEX `device_uuid_key` ON `device`;

-- DropIndex
DROP INDEX `user_email_key` ON `user`;

-- AlterTable
ALTER TABLE `device` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    MODIFY `uuid` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`uuid`);

-- AlterTable
ALTER TABLE `user` DROP COLUMN `email`,
    DROP COLUMN `firstname`,
    DROP COLUMN `lastname`,
    ADD COLUMN `employee_uuid` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `super_user`;

-- CreateTable
CREATE TABLE `company` (
    `uuid` VARCHAR(191) NOT NULL,
    `name` TEXT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,
    `location` TEXT NULL,
    `phoneNumber` TEXT NULL,

    INDEX `company_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `client` (
    `uuid` VARCHAR(191) NOT NULL,
    `name` TEXT NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,
    `company_uuid` VARCHAR(191) NOT NULL,

    INDEX `client_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `employee` (
    `uuid` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `firstname` TEXT NULL,
    `lastname` TEXT NULL,
    `phoneNumber` VARCHAR(20) NULL,
    `idToken` VARCHAR(100) NULL,
    `authenticationUser` VARCHAR(100) NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,
    `company_uuid` VARCHAR(191) NOT NULL,
    `user_uuid` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `employee_email_key`(`email`),
    UNIQUE INDEX `employee_user_uuid_key`(`user_uuid`),
    INDEX `employee_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `qualification` (
    `uuid` VARCHAR(191) NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,
    `employee_uuid` VARCHAR(191) NOT NULL,

    INDEX `qualification_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permission` (
    `uuid` VARCHAR(191) NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,
    `user_uuid` VARCHAR(191) NOT NULL,

    INDEX `permission_uuid_idx`(`uuid`),
    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `client` ADD CONSTRAINT `fk_client_company` FOREIGN KEY (`company_uuid`) REFERENCES `company`(`uuid`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `employee` ADD CONSTRAINT `fk_employee_user` FOREIGN KEY (`user_uuid`) REFERENCES `user`(`uuid`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `employee` ADD CONSTRAINT `fk_employee_company` FOREIGN KEY (`company_uuid`) REFERENCES `company`(`uuid`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `qualification` ADD CONSTRAINT `fk_qualification_employee` FOREIGN KEY (`employee_uuid`) REFERENCES `employee`(`uuid`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `permission` ADD CONSTRAINT `fk_permission_user` FOREIGN KEY (`user_uuid`) REFERENCES `user`(`uuid`) ON DELETE NO ACTION ON UPDATE NO ACTION;
