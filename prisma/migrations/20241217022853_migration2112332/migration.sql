-- DropIndex
DROP INDEX `fk_device_user_idx` ON `device`;

-- CreateTable
CREATE TABLE `Action` (
    `uuid` VARCHAR(191) NOT NULL,
    `type` INTEGER NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,

    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Resource` (
    `uuid` VARCHAR(191) NOT NULL,
    `type` INTEGER NOT NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `modifiedAt` TIMESTAMP(0) NOT NULL,
    `changeTag` BIGINT NOT NULL DEFAULT 0,

    PRIMARY KEY (`uuid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
