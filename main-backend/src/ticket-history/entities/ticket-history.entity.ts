import { Column, Entity, PrimaryColumn } from 'typeorm';
import { CreateTicketHistoryEntityDto } from '../dto/create-ticket-history.dto';
import { generateString } from '@nestjs/typeorm';

@Entity()
export class TicketHistory {
  @PrimaryColumn('uuid')
  id: string;

  @Column('uuid')
  departmentQueueId: string;

  @Column('date')
  date: Date;

  static create(dto: CreateTicketHistoryEntityDto) {
    const instance = new TicketHistory();
    instance.id = generateString();
    instance.departmentQueueId = dto.departmentQueueId;
    instance.date = dto.date;
    return instance;
  }
}
