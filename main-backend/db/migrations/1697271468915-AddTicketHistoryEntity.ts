import { MigrationInterface, QueryRunner } from "typeorm";

export class AddTicketHistoryEntity1697271468915 implements MigrationInterface {
    name = 'AddTicketHistoryEntity1697271468915'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "ticket_history_item" ("id" uuid NOT NULL, "historyId" uuid NOT NULL, "num" integer NOT NULL, "values" character varying NOT NULL, "target" integer NOT NULL, CONSTRAINT "PK_d27ea21c7f062a9b8e8572fd6c3" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "ticket_history" ("id" uuid NOT NULL, "departmentQueueId" uuid NOT NULL, "date" date NOT NULL, CONSTRAINT "PK_6d0f4bc32cc3581d6a016bca30a" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "ticket_history"`);
        await queryRunner.query(`DROP TABLE "ticket_history_item"`);
    }

}
