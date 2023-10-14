import { MigrationInterface, QueryRunner } from "typeorm";

export class AddFieldToEntities1697238518781 implements MigrationInterface {
    name = 'AddFieldToEntities1697238518781'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "ticket" ADD "visitDate" date NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "ticket" DROP COLUMN "visitDate"`);
    }

}
