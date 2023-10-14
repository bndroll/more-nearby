import { Column, Entity, PrimaryColumn } from 'typeorm';
import { CreateTicketHistoryItemEntityDto } from '../dto/create-ticket-history.dto';
import { generateString } from '@nestjs/typeorm';

@Entity()
export class TicketHistoryItem {
  @PrimaryColumn('uuid')
  id: string;

  @Column('uuid')
  historyId: string;

  @Column('integer')
  num: number;

  @Column('varchar')
  values: string;

  @Column('integer')
  target: number;

  static create(dto: CreateTicketHistoryItemEntityDto) {
    const instance = new TicketHistoryItem();
    instance.id = generateString();
    instance.historyId = dto.historyId;
    instance.num = dto.num;
    instance.values = dto.values;
    instance.target = dto.target;
    return instance;
  }
}
