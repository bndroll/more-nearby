import { Module } from '@nestjs/common';
import { TicketService } from './ticket.service';
import { TicketController } from './ticket.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Ticket } from './entities/ticket.entity';
import { UserModule } from '../user/user.module';
import { TicketRepository } from './repository/ticket.repository';
import { TagModule } from '../tag/tag.module';
import { DepartmentQueueModule } from '../department-queue/department-queue.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Ticket]),
    UserModule,
    TagModule,
    DepartmentQueueModule
  ],
  controllers: [TicketController],
  providers: [TicketService, TicketRepository],
  exports: [TicketService, TicketRepository],
})
export class TicketModule {
}
