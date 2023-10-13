import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateTicketCounterEntityDto } from '../dto/create-ticket-counter.dto';

@Entity()
export class TicketCounter {
  @PrimaryColumn('uuid')
  id: string;

  @Column('integer')
  num: number;

  @Column('uuid')
  departmentQueueId: string;

  static create(dto: CreateTicketCounterEntityDto) {
    const instance = new TicketCounter();
    instance.id = generateString();
    instance.num = 0;
    instance.departmentQueueId = dto.departmentQueueId;
    return instance;
  }

  updateNum() {
    this.num = this.num + 1;
  }

  clearNum() {
    this.num = 0;
  }
}
