import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { TicketHistory } from '../entities/ticket-history.entity';

@Injectable()
export class TicketHistoryRepository extends Repository<TicketHistory> {
  constructor(private dataSource: DataSource) {
    super(TicketHistory, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findLastByQueueId(departmentQueueId: string) {
    return await this.find({
      where: { departmentQueueId },
      order: { date: 'desc' },
      take: 10,
    });
  }

  async findActiveHistoryByQueueId(departmentQueueId: string) {
    return await this.findOneBy({
      departmentQueueId,
      date: new Date(),
    });
  }

  async findActiveHistoriesByQueueIds(departmentQueueIds: string[]) {
    return await this.findBy({
      departmentQueueId: In(departmentQueueIds),
      date: new Date(),
    });
  }
}