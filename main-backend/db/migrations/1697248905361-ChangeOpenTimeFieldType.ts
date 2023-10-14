import { MigrationInterface, QueryRunner } from "typeorm";

export class ChangeOpenTimeFieldType1697248905361 implements MigrationInterface {
    name = 'ChangeOpenTimeFieldType1697248905361'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "cash_machine" ALTER COLUMN "balance" SET DEFAULT '0'`);
        await queryRunner.query(`ALTER TABLE "ticket" DROP COLUMN "openDate"`);
        await queryRunner.query(`ALTER TABLE "ticket" ADD "openDate" TIMESTAMP`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "ticket" DROP COLUMN "openDate"`);
        await queryRunner.query(`ALTER TABLE "ticket" ADD "openDate" date`);
        await queryRunner.query(`ALTER TABLE "cash_machine" ALTER COLUMN "balance" DROP DEFAULT`);
    }

}
