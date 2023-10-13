import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreatePhilanthropyEntityDto } from '../dto/create-philanthropy.dto';

@Entity()
export class PhilanthropyHistory {
  @PrimaryColumn('uuid')
  id: string;

  @Column('uuid')
  ticketId: string;

  @Column('bigint')
  sum: number;

  static create(dto: CreatePhilanthropyEntityDto) {
    const instance = new PhilanthropyHistory();
    instance.id = generateString();
    instance.ticketId = dto.ticketId;
    instance.sum = dto.sum;
    return instance;
  }
}
