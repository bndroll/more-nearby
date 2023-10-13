import { MigrationInterface, QueryRunner } from "typeorm";

export class InitializeStartEntities1697212581049 implements MigrationInterface {
    name = 'InitializeStartEntities1697212581049'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TYPE "public"."cash_machine_history_operation_enum" AS ENUM('Fill', 'Take')`);
        await queryRunner.query(`CREATE TYPE "public"."cash_machine_history_status_enum" AS ENUM('Complete', 'Error')`);
        await queryRunner.query(`CREATE TABLE "cash_machine_history" ("id" uuid NOT NULL, "userId" uuid NOT NULL, "cashMachineId" uuid NOT NULL, "sum" bigint NOT NULL, "operation" "public"."cash_machine_history_operation_enum" NOT NULL, "status" "public"."cash_machine_history_status_enum" NOT NULL, "createdDate" TIMESTAMP NOT NULL DEFAULT now(), CONSTRAINT "PK_4fe47cd581a872589b6af22585e" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "philanthropy_history" ("id" uuid NOT NULL, "ticketId" uuid NOT NULL, "sum" bigint NOT NULL, CONSTRAINT "PK_dff8eccc25c428549433ff404e3" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TYPE "public"."cash_machine_type_enum" AS ENUM('Own', 'Partner')`);
        await queryRunner.query(`CREATE TABLE "cash_machine" ("id" uuid NOT NULL, "lat" character varying NOT NULL, "lon" character varying NOT NULL, "address" text NOT NULL, "type" "public"."cash_machine_type_enum" NOT NULL, "info" character varying, "balance" bigint NOT NULL, CONSTRAINT "PK_bbc4cc5394f9970874e7db12541" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "faq" ("id" uuid NOT NULL, "request" character varying NOT NULL, "response" character varying NOT NULL, CONSTRAINT "PK_d6f5a52b1a96dd8d0591f9fbc47" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "tag" ("id" uuid NOT NULL, "title" character varying NOT NULL, "time" integer NOT NULL, CONSTRAINT "PK_8e4052373c579afc1471f526760" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "user" ("id" uuid NOT NULL, "name" character varying NOT NULL, "phone" character varying NOT NULL, "password" character varying NOT NULL, CONSTRAINT "PK_cace4a159ff9f2512dd42373760" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "user"`);
        await queryRunner.query(`DROP TABLE "tag"`);
        await queryRunner.query(`DROP TABLE "faq"`);
        await queryRunner.query(`DROP TABLE "cash_machine"`);
        await queryRunner.query(`DROP TYPE "public"."cash_machine_type_enum"`);
        await queryRunner.query(`DROP TABLE "philanthropy_history"`);
        await queryRunner.query(`DROP TABLE "cash_machine_history"`);
        await queryRunner.query(`DROP TYPE "public"."cash_machine_history_status_enum"`);
        await queryRunner.query(`DROP TYPE "public"."cash_machine_history_operation_enum"`);
    }

}
