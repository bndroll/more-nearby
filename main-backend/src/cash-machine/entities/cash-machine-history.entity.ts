import { Column, CreateDateColumn, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateCashMachineHistoryEntityDto } from '../dto/create-cash-machine-history.dto';

export enum CashMachineHistoryOperation {
  Fill = 'Fill',
  Take = 'Take'
}

export enum CashMachineHistoryStatus {
  Complete = 'Complete',
  Error = 'Error'
}

@Entity()
export class CashMachineHistory {
  @PrimaryColumn('uuid')
  id: string;

  @Column('uuid')
  userId: string;

  @Column('uuid')
  cashMachineId: string;

  @Column('bigint')
  sum: number;

  @Column({ type: 'enum', enum: CashMachineHistoryOperation })
  operation: CashMachineHistoryOperation;

  @Column({ type: 'enum', enum: CashMachineHistoryStatus })
  status: CashMachineHistoryStatus;

  @CreateDateColumn()
  createdDate: Date;

  static create(dto: CreateCashMachineHistoryEntityDto) {
    const instance = new CashMachineHistory();
    instance.id = generateString();
    instance.userId = dto.userId;
    instance.cashMachineId = dto.cashMachineId;
    instance.sum = dto.sum;
    instance.operation = dto.operation;
    instance.status = dto.status;
    return instance;
  }
}