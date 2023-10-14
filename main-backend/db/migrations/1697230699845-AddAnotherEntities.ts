import { MigrationInterface, QueryRunner } from "typeorm";

export class AddAnotherEntities1697230699845 implements MigrationInterface {
    name = 'AddAnotherEntities1697230699845'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "ticket_counter" ("id" uuid NOT NULL, "num" integer NOT NULL, "departmentQueueId" uuid NOT NULL, CONSTRAINT "PK_ec62806d405b1210e7ceac49d85" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "department_queue" ("id" uuid NOT NULL, "title" character varying NOT NULL, "tagId" uuid NOT NULL, "departmentId" uuid NOT NULL, "counterId" uuid NOT NULL, CONSTRAINT "PK_596ca4471489088eb9de0f06740" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "employee" ("id" uuid NOT NULL, "name" character varying NOT NULL, "picture" character varying NOT NULL, "post" character varying NOT NULL, "departmentId" uuid NOT NULL, "departmentQueueId" uuid NOT NULL, CONSTRAINT "UQ_e97a7f3c48c04b54ffc24e5fc71" UNIQUE ("name"), CONSTRAINT "PK_3c2bc72f03fd5abbbc5ac169498" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "department" ("id" uuid NOT NULL, "title" character varying NOT NULL, "lat" character varying NOT NULL, "lon" character varying NOT NULL, "address" text NOT NULL, "picture" character varying, "info" character varying, CONSTRAINT "PK_9a2213262c1593bffb581e382f5" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TYPE "public"."ticket_status_enum" AS ENUM('Pending', 'Open', 'Closed')`);
        await queryRunner.query(`CREATE TYPE "public"."ticket_additionallytype_enum" AS ENUM('Normal', 'Fast', 'Hard')`);
        await queryRunner.query(`CREATE TABLE "ticket" ("id" uuid NOT NULL, "title" character varying NOT NULL, "num" integer NOT NULL, "resultTime" integer, "request" character varying NOT NULL, "predictionTime" integer NOT NULL, "status" "public"."ticket_status_enum" NOT NULL, "additionallyType" "public"."ticket_additionallytype_enum" NOT NULL, "userId" uuid NOT NULL, "tagId" uuid NOT NULL, "departmentQueueId" uuid NOT NULL, "philanthropyId" uuid, "createdDate" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_d9a0835407701eb86f874474b7c" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "philanthropy_history" ADD "createdDate" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "tag" ADD "prefix" character varying NOT NULL`);
        await queryRunner.query(`ALTER TABLE "tag" ADD "type" character varying NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "tag" DROP COLUMN "type"`);
        await queryRunner.query(`ALTER TABLE "tag" DROP COLUMN "prefix"`);
        await queryRunner.query(`ALTER TABLE "philanthropy_history" DROP COLUMN "createdDate"`);
        await queryRunner.query(`DROP TABLE "ticket"`);
        await queryRunner.query(`DROP TYPE "public"."ticket_additionallytype_enum"`);
        await queryRunner.query(`DROP TYPE "public"."ticket_status_enum"`);
        await queryRunner.query(`DROP TABLE "department"`);
        await queryRunner.query(`DROP TABLE "employee"`);
        await queryRunner.query(`DROP TABLE "department_queue"`);
        await queryRunner.query(`DROP TABLE "ticket_counter"`);
    }

}
