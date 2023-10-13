import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CashMachine } from '../entities/cash-machine.entity';

@Injectable()
export class CashMachineRepository extends Repository<CashMachine> {
  constructor(private dataSource: DataSource) {
    super(CashMachine, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }
}