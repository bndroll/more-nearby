import { Injectable } from '@nestjs/common';
import { CreateTicketCounterEntityDto } from './dto/create-ticket-counter.dto';
import { TicketCounter } from './entities/ticket-counter.entity';
import { TicketCounterRepository } from './repositories/ticket-counter.repository';

@Injectable()
export class TicketCounterService {
  constructor(
    private readonly ticketCounterRepository: TicketCounterRepository,
  ) {
  }

  async create(dto: CreateTicketCounterEntityDto) {
    const ticketCounter = TicketCounter.create({
      departmentQueueId: dto.departmentQueueId,
    });
    return await this.ticketCounterRepository.save(ticketCounter);
  }

  async findByDepartmentQueueId(departmentQueueId: string) {
    return await this.ticketCounterRepository.findByDepartmentQueueId(departmentQueueId);
  }
}
