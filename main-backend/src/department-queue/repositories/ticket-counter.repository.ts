import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { TicketCounter } from '../entities/ticket-counter.entity';

@Injectable()
export class TicketCounterRepository extends Repository<TicketCounter> {
  constructor(private dataSource: DataSource) {
    super(TicketCounter, dataSource.createEntityManager());
  }

  async findByDepartmentQueueId(departmentQueueId: string) {
    return await this.findOneBy({ departmentQueueId });
  }
}