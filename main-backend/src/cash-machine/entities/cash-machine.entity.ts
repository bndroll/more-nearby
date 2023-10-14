import { Column, Entity, PrimaryColumn } from 'typeorm';
import { CreateCashMachineEntityDto } from '../dto/create-cash-machine.dto';
import { generateString } from '@nestjs/typeorm';

export enum CashMachineType {
  Own = 'Own',
  Partner = 'Partner'
}

@Entity()
export class CashMachine {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  lat: string;

  @Column('varchar')
  lon: string;

  @Column('text')
  address: string;

  @Column({ type: 'enum', enum: CashMachineType })
  type: CashMachineType;

  @Column('varchar', { nullable: true })
  info: string | null;

  @Column('bigint')
  balance: number;

  static create(dto: CreateCashMachineEntityDto) {
    const instance = new CashMachine();
    instance.id = generateString();
    instance.lat = dto.lat;
    instance.lon = dto.lon;
    instance.address = dto.address;
    instance.type = dto.type;
    instance.info = dto.info;
    instance.balance = 0;
    return instance;
  }

  updateInfo(info: string) {
    this.info = info;
  }

  updateBalance(sum: number) {
    this.balance = this.balance + sum;
  }
}
