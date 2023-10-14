import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateTicketHistoryEntityDto, CreateTicketHistoryItemDto } from './dto/create-ticket-history.dto';
import { TicketHistory } from './entities/ticket-history.entity';
import { TicketHistoryRepository } from './repository/ticket-history.repository';
import { TicketHistoryItemRepository } from './repository/ticket-history-item.repository';
import { TicketHistoryItem } from './entities/ticket-history-item.entity';
import { DepartmentQueueRepository } from '../department-queue/repositories/department-queue.repository';
import { DepartmentQueueErrorMessages } from '../department-queue/department-queue.constants';
import { GenerateHistoryAnalyticDto } from './dto/generate-history-analytic.dto';
import { TicketRepository } from '../ticket/repository/ticket.repository';
import { TicketStatus } from '../ticket/entities/ticket.entity';

@Injectable()
export class TicketHistoryService {
  constructor(
    private readonly ticketHistoryRepository: TicketHistoryRepository,
    private readonly ticketHistoryItemRepository: TicketHistoryItemRepository,
    private readonly departmentQueueRepository: DepartmentQueueRepository,
    private readonly ticketRepository: TicketRepository,
  ) {
  }

  async createHistory(dto: CreateTicketHistoryEntityDto) {
    const history = TicketHistory.create({
      departmentQueueId: dto.departmentQueueId,
      date: dto.date,
    });
    return await this.ticketHistoryRepository.save(history);
  }

  async createHistoryItem(dto: CreateTicketHistoryItemDto) {
    const historyItem = TicketHistoryItem.create({
      historyId: dto.historyId,
      num: dto.num,
      values: JSON.stringify(dto.values),
      target: dto.target,
    });
    return await this.ticketHistoryItemRepository.save(historyItem);
  }

  async findActiveHistoryByQueueId(departmentQueueId: string) {
    return await this.ticketHistoryRepository.findActiveHistoryByQueueId(departmentQueueId);
  }

  async findActiveHistoriesByQueueIds(departmentQueueIds: string[]) {
    return await this.ticketHistoryRepository.findActiveHistoriesByQueueIds(departmentQueueIds);
  }

  async findItemsByHistoryId(historyId: string) {
    return (await this.ticketHistoryItemRepository.findByHistoryId(historyId))
      .map(item => ({ ...item, values: JSON.parse(item.values) as number[] }));
  }

  async findLastByQueueId(departmentQueueId: string) {
    const queue = await this.departmentQueueRepository.findById(departmentQueueId);
    if (!queue) {
      throw new NotFoundException(DepartmentQueueErrorMessages.NotFound);
    }

    return await this.ticketHistoryRepository.findLastByQueueId(queue.id);
  }

  async generateHistoryItemAnalytic(dto: GenerateHistoryAnalyticDto) {
    const tickets = await this.ticketRepository.findByQueueId(dto.departmentQueueId);
    const ticketCountByStatus = tickets.reduce((res, item) => {
      if (item.status === TicketStatus.Closed) {
        return { ...res, closed: res.closed + 1 };
      } else if (item.status === TicketStatus.Pending) {
        return { ...res, closed: res.pending + 1 };
      }
      return { ...res, closed: res.open + 1 };
    }, {
      closed: 0,
      pending: 0,
      open: 0,
    });
    const countByStatus = [
      ticketCountByStatus.closed,
      ticketCountByStatus.pending,
      ticketCountByStatus.open,
    ];

    let ticketHistoryItem = await this.ticketHistoryItemRepository.findByHistoryIdAndNum(dto.historyId, dto.num);
    const lastItemValues = ticketHistoryItem ? [0, 0, 0] : JSON.parse(ticketHistoryItem.values);
    const target = Math.round(
      (countByStatus[0] - lastItemValues[0]) +
      (countByStatus[1] * 0.3) +
      (countByStatus[2] * 1.7),
    );

    let averageTicketsByDayCount = 0;
    const lastHistoryIds = (await this.ticketHistoryRepository.findLastByQueueId(dto.departmentQueueId)).map(item => item.id);
    const lastHistoryItems = await this.ticketHistoryItemRepository.findLastByHistoryIds(lastHistoryIds);
    for (const item of lastHistoryItems) {
      const itemValues = JSON.parse(item.values) as number[];
      averageTicketsByDayCount += itemValues[0];
    }
    averageTicketsByDayCount = Math.round(averageTicketsByDayCount / lastHistoryIds.length);

    return {
      target: target >= averageTicketsByDayCount ? 100 : Math.round(target * 100 / averageTicketsByDayCount),
      countByStatus: countByStatus,
    };
  }

  async getOldTargetValue() {

  }

  async getFutureTargetValue() {

  }
}
