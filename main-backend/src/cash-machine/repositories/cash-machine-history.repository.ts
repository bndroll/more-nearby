import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { CashMachineHistory } from '../entities/cash-machine-history.entity';

@Injectable()
export class CashMachineHistoryRepository extends Repository<CashMachineHistory> {
  constructor(private dataSource: DataSource) {
    super(CashMachineHistory, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByMachineId(machineId: string) {
    return await this.findBy({ cashMachineId: machineId });
  }
}