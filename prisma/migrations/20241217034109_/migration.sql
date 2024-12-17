/*
  Warnings:

  - You are about to drop the column `authenticationUser` on the `employee` table. All the data in the column will be lost.
  - You are about to drop the column `idToken` on the `employee` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `employee` DROP COLUMN `authenticationUser`,
    DROP COLUMN `idToken`;
