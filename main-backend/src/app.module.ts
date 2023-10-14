import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PostgresConfig } from './config/postgres.config';
import { ScheduleModule } from '@nestjs/schedule';
import { UserModule } from './user/user.module';
import { CashMachineModule } from './cash-machine/cash-machine.module';
import { FaqModule } from './faq/faq.module';
import { PhilanthropyModule } from './philanthropy/philanthropy.module';
import { TagModule } from './tag/tag.module';
import { DepartmentModule } from './department/department.module';
import { EmployeeModule } from './employee/employee.module';
import { DepartmentQueueModule } from './department-queue/department-queue.module';
import { TicketModule } from './ticket/ticket.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: `.${process.env.NODE_ENV.trim()}.env`,
      isGlobal: true,
      load: [PostgresConfig],
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        ...configService.getOrThrow('postgres'),
      }),
      inject: [ConfigService],
    }),
    ScheduleModule.forRoot(),
    AuthModule,
    UserModule,
    CashMachineModule,
    FaqModule,
    PhilanthropyModule,
    TagModule,
    DepartmentModule,
    EmployeeModule,
    DepartmentQueueModule,
    TicketModule
  ],
})
export class AppModule {}
