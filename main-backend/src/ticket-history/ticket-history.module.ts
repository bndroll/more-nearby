import { forwardRef, Module } from '@nestjs/common';
import { TicketHistoryService } from './ticket-history.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TicketHistory } from './entities/ticket-history.entity';
import { TicketHistoryItem } from './entities/ticket-history-item.entity';
import { TicketHistoryRepository } from './repository/ticket-history.repository';
import { TicketHistoryItemRepository } from './repository/ticket-history-item.repository';
import { DepartmentQueueModule } from '../department-queue/department-queue.module';
import { GenerateHistoryCron } from './cron/generate-history.cron';
import { TicketModule } from '../ticket/ticket.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([TicketHistory, TicketHistoryItem]),
    forwardRef(() => DepartmentQueueModule),
    TicketModule
  ],
  providers: [TicketHistoryService, TicketHistoryRepository, TicketHistoryItemRepository, GenerateHistoryCron],
  exports: [TicketHistoryService, TicketHistoryRepository, TicketHistoryItemRepository],
})
export class TicketHistoryModule {
}
