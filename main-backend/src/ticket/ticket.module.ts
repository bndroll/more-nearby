import { Module } from '@nestjs/common';
import { TicketService } from './ticket.service';
import { TicketController } from './ticket.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Ticket } from './entities/ticket.entity';
import { UserModule } from '../user/user.module';
import { TicketRepository } from './repository/ticket.repository';

@Module({
  imports: [
    TypeOrmModule.forFeature([Ticket]),
    UserModule
  ],
  controllers: [TicketController],
  providers: [TicketService, TicketRepository],
})
export class TicketModule {
}
