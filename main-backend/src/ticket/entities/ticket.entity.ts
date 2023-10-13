import { Column, CreateDateColumn, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateTicketEntityDto } from '../dto/create-ticket.dto';

export enum TicketStatus {
  Pending = 'Pending',
  Open = 'Open',
  Closed = 'Closed'
}

export enum TicketAdditionallyType {
  Normal = 'Normal',
  Fast = 'Fast',
  Hard = 'Hard'
}

@Entity()
export class Ticket {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  title: string;

  @Column('integer')
  num: number;

  @Column('integer', { nullable: true })
  resultTime: number | null;

  @Column('varchar')
  request: string;

  @Column('integer')
  predictionTime: number;

  @Column({ type: 'enum', enum: TicketStatus })
  status: TicketStatus;

  @Column({ type: 'enum', enum: TicketAdditionallyType })
  additionallyType: TicketAdditionallyType;

  @Column('uuid')
  userId: string;

  @Column('uuid')
  tagId: string;

  @Column('uuid')
  departmentQueueId: string;

  @Column('uuid', { nullable: true })
  philanthropyId: string | null;

  @CreateDateColumn()
  createdDate: Date;

  static create(dto: CreateTicketEntityDto) {
    const instance = new Ticket();
    instance.id = generateString();
    instance.title = dto.title;
    instance.num = dto.num;
    instance.request = dto.request;
    instance.predictionTime = dto.predictionTime;
    instance.status = dto.status;
    instance.additionallyType = dto.additionallyType;
    instance.userId = dto.userId;
    instance.tagId = dto.tagId;
    instance.departmentQueueId = dto.departmentQueueId;
    return instance;
  }

  updatePhilanthropyId(philanthropyId: string) {
    this.philanthropyId = philanthropyId;
  }

  openTicket() {
    this.status = TicketStatus.Open;
  }

  closeTicket(resultTime: number) {
    this.resultTime = resultTime;
    this.status = TicketStatus.Closed;
  }

  updatePredictionTime(time: number) {
    this.predictionTime = time;
  }
}
