import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { TicketHistoryItem } from '../entities/ticket-history-item.entity';

@Injectable()
export class TicketHistoryItemRepository extends Repository<TicketHistoryItem> {
  constructor(private dataSource: DataSource) {
    super(TicketHistoryItem, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByHistoryId(historyId: string) {
    return await this.find({
      where: { historyId },
      order: { num: 'desc' },
    });
  }

  async findLastByHistoryIds(historyIds: string[]) {
    return await this.findBy({ historyId: In(historyIds), num: 21 });
  }

  async findByHistoryIdAndNum(historyId: string, num: number) {
    return await this.findOneBy({ historyId, num });
  }
}