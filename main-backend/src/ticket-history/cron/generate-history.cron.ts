import { Injectable } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';
import { TicketHistoryService } from '../ticket-history.service';
import { DepartmentQueueRepository } from '../../department-queue/repositories/department-queue.repository';

@Injectable()
export class GenerateHistoryCron {
  constructor(
    private readonly ticketHistoryService: TicketHistoryService,
    private readonly departmentQueueRepository: DepartmentQueueRepository,
  ) {
  }

  @Cron('0 06 * * *', { timeZone: 'Europe/Moscow' })
  async generateHistory() {
    const queues = await this.departmentQueueRepository.find();
    for (const queue of queues) {
      await this.ticketHistoryService.createHistory({
        departmentQueueId: queue.id,
        date: new Date(),
      });
    }
  }

  @Cron('0 0 9-21 * * *', { timeZone: 'Europe/Moscow' })
  async generateHistoryItem() {
    const queues = await this.departmentQueueRepository.find();
    const queueIds = queues.map(item => item.id);

    const activeHistories = await this.ticketHistoryService.findActiveHistoriesByQueueIds(queueIds);
    for (const history of activeHistories) {
      const num = new Date().getUTCHours() + 3;

      const historyItemAnalytic = await this.ticketHistoryService.generateHistoryItemAnalytic({
        historyId: history.id,
        departmentQueueId: history.departmentQueueId,
        num: num,
      });

      await this.ticketHistoryService.createHistoryItem({
        historyId: history.id,
        num: num,
        values: historyItemAnalytic.countByStatus,
        target: historyItemAnalytic.target,
      });
    }
  }
}