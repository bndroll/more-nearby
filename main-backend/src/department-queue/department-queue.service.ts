import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDepartmentQueueDto } from './dto/create-department-queue.dto';
import { DepartmentQueueRepository } from './repositories/department-queue.repository';
import { DepartmentQueueErrorMessages } from './department-queue.constants';
import { DepartmentQueue } from './entities/department-queue.entity';
import { TicketCounterService } from './ticket-counter.service';
import { TicketCounterRepository } from './repositories/ticket-counter.repository';
import { TagRepository } from '../tag/repositories/tag.repository';

@Injectable()
export class DepartmentQueueService {
  constructor(
    private readonly departmentQueueRepository: DepartmentQueueRepository,
    private readonly ticketCounterService: TicketCounterService,
    private readonly ticketCounterRepository: TicketCounterRepository,
    private readonly tagRepository: TagRepository,
  ) {
  }

  async create(dto: CreateDepartmentQueueDto) {
    const queue = DepartmentQueue.create({
      title: dto.title,
      tagId: dto.tagId,
      departmentId: dto.departmentId,
    });
    const counter = await this.ticketCounterService.create({
      departmentQueueId: queue.id,
    });

    queue.updateCounterId(counter.id);
    return await this.departmentQueueRepository.save(queue);
  }

  async findById(id: string) {
    const departmentQueue = await this.departmentQueueRepository.findById(id);
    if (!departmentQueue) {
      throw new NotFoundException(DepartmentQueueErrorMessages.NotFound);
    }

    return departmentQueue;
  }

  async findByDepartmentId(departmentId: string) {
    return await this.departmentQueueRepository.findByDepartmentId(departmentId);
  }

  async generateTicketNumber(departmentQueueId: string) {
    const ticketCounter = await this.ticketCounterService.findByDepartmentQueueId(departmentQueueId);
    const departmentQueue = await this.departmentQueueRepository.findById(departmentQueueId);
    if (!departmentQueue) {
      throw new NotFoundException(DepartmentQueueErrorMessages.NotFound);
    }

    const num = ticketCounter.num;
    ticketCounter.updateNum();
    await this.ticketCounterRepository.save(ticketCounter);

    const tag = await this.tagRepository.findById(departmentQueue.tagId);
    return `${tag.prefix}-${num}`;
  }
}
