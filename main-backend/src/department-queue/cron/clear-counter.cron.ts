import { Injectable } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';
import { TicketCounterRepository } from '../repositories/ticket-counter.repository';

@Injectable()
export class TicketCounterCron {
  constructor(
    private readonly ticketCounterRepository: TicketCounterRepository,
  ) {
  }

  @Cron('0 04 * * *', { timeZone: 'Europe/Moscow' })
  async clearCounters() {
    const counters = await this.ticketCounterRepository.find();
    for (const counter of counters) {
      counter.clearNum();
      await this.ticketCounterRepository.save(counter);
    }
  }
}