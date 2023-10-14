import { MigrationInterface, QueryRunner } from "typeorm";

export class AddOpenDateToTicketEntity1697246748508 implements MigrationInterface {
    name = 'AddOpenDateToTicketEntity1697246748508'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "ticket" ADD "openDate" date`);
        await queryRunner.query(`ALTER TABLE "cash_machine" DROP COLUMN "balance"`);
        await queryRunner.query(`ALTER TABLE "cash_machine" ADD "balance" integer NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "cash_machine" DROP COLUMN "balance"`);
        await queryRunner.query(`ALTER TABLE "cash_machine" ADD "balance" bigint NOT NULL`);
        await queryRunner.query(`ALTER TABLE "ticket" DROP COLUMN "openDate"`);
    }

}
