import { forwardRef, Module } from '@nestjs/common';
import { DepartmentQueueService } from './department-queue.service';
import { DepartmentQueueController } from './department-queue.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DepartmentQueue } from './entities/department-queue.entity';
import { DepartmentQueueRepository } from './repositories/department-queue.repository';
import { TicketCounter } from './entities/ticket-counter.entity';
import { TicketCounterRepository } from './repositories/ticket-counter.repository';
import { TicketCounterService } from './ticket-counter.service';
import { TagModule } from '../tag/tag.module';
import { TicketCounterCron } from './cron/clear-counter.cron';
import { TicketHistoryModule } from '../ticket-history/ticket-history.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([DepartmentQueue, TicketCounter]),
    TagModule,
    forwardRef(() => TicketHistoryModule)
  ],
  controllers: [DepartmentQueueController],
  providers: [
    DepartmentQueueService,
    TicketCounterService,
    DepartmentQueueRepository,
    TicketCounterRepository,
    TicketCounterCron
  ],
  exports: [DepartmentQueueService, DepartmentQueueRepository]
})
export class DepartmentQueueModule {
}
