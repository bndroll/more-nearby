import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateTicketDto } from './dto/create-ticket.dto';
import { TicketRepository } from './repository/ticket.repository';
import { UserErrorMessages } from '../user/user.constants';
import { UserRepository } from '../user/repositories/user.repository';
import { TagRepository } from '../tag/repositories/tag.repository';
import { TagErrorMessages } from '../tag/tag.constants';
import { DepartmentQueueRepository } from '../department-queue/repositories/department-queue.repository';
import { DepartmentQueueErrorMessages } from '../department-queue/department-queue.constants';
import { Ticket, TicketAdditionallyType } from './entities/ticket.entity';
import { DepartmentQueueService } from '../department-queue/department-queue.service';
import { TicketErrorMessages } from './ticket.constants';
import { CloseTicketDto, UpdateTicketAdditionalTypeDto, UpdateTicketPhilanthropyIdDto } from './dto/update-ticket.dto';

@Injectable()
export class TicketService {
  constructor(
    private readonly ticketRepository: TicketRepository,
    private readonly userRepository: UserRepository,
    private readonly tagRepository: TagRepository,
    private readonly departmentQueueRepository: DepartmentQueueRepository,
    private readonly departmentQueueService: DepartmentQueueService,
  ) {
  }

  async create(dto: CreateTicketDto) {
    const user = await this.userRepository.findById(dto.userId);
    if (!user) {
      throw new NotFoundException(UserErrorMessages.NotFound);
    }

    const tag = await this.tagRepository.findById(dto.tagId);
    if (!tag) {
      throw new NotFoundException(TagErrorMessages.NotFound);
    }

    const queue = await this.departmentQueueRepository.findById(dto.departmentQueueId);
    if (!queue) {
      throw new NotFoundException(DepartmentQueueErrorMessages.NotFound);
    }

    const openTicket = await this.ticketRepository.findOpenTicketByUserId(user.id);
    if (openTicket) {
      throw new BadRequestException(TicketErrorMessages.MoreThenLimit);
    }

    const ticketNum = await this.departmentQueueService.generateTicketNumber(queue.id);

    let predictionTime = tag.time;
    const lastTickets = await this.ticketRepository.getLastTicketsByUserId(user.id);
    if (lastTickets.length > 4) {
      const lastTicketFastCount = lastTickets.reduce((sum, item) => item.additionallyType === TicketAdditionallyType.Fast ? sum + 1 : sum, 0);
      const lastTicketHardCount = lastTickets.reduce((sum, item) => item.additionallyType === TicketAdditionallyType.Hard ? sum + 1 : sum, 0);
      if (lastTicketFastCount >= Math.floor(lastTickets.length / 2)) {
        predictionTime = Math.ceil(predictionTime - (predictionTime / 100 * 5));
      } else if (lastTicketHardCount >= Math.floor(lastTickets.length / 2)) {
        predictionTime = Math.ceil(predictionTime + (predictionTime / 100 * 15));
      }
    }

    const ticket = Ticket.create({
      title: ticketNum,
      num: parseInt(ticketNum.split('-')[1]),
      request: dto.request,
      status: dto.status,
      additionallyType: TicketAdditionallyType.Normal,
      predictionTime: predictionTime,
      visitDate: dto.visitDate,
      userId: user.id,
      tagId: tag.id,
      departmentQueueId: queue.id,
    });
    return await this.ticketRepository.save(ticket);
  }

  async findByUserId(userId: string) {
    return await this.ticketRepository.findByUserId(userId);
  }

  async findUserTicket(userId: string) {
    const ticket = await this.ticketRepository.findOpenTicketByUserId(userId);
    const openQueueTickets = await this.ticketRepository.findOpenQueueTickets(ticket.departmentQueueId);

    let position = 0;
    let waitingTime = 0;
    for (let i = 0; i < openQueueTickets.length; i++) {
      if (openQueueTickets[i].id === ticket.id) {
        position = i + 1;
        break;
      }
      waitingTime = waitingTime + openQueueTickets[i].predictionTime;
    }

    return {
      ticket: ticket,
      queue: {
        position: position,
        waitingTime: waitingTime,
      },
    };
  }

  async openTicket(id: string) {
    const ticket = await this.ticketRepository.findById(id);
    if (!ticket) {
      throw new NotFoundException(TicketErrorMessages.NotFound);
    }
    ticket.openTicket();
    return await this.ticketRepository.save(ticket);
  }

  async closeTicket(id: string, dto: CloseTicketDto) {
    const ticket = await this.ticketRepository.findById(id);
    if (!ticket) {
      throw new NotFoundException(TicketErrorMessages.NotFound);
    }
    ticket.closeTicket(dto.resultTime);
    return await this.ticketRepository.save(ticket);
  }

  async updateAdditionalType(id: string, dto: UpdateTicketAdditionalTypeDto) {
    const ticket = await this.ticketRepository.findById(id);
    if (!ticket) {
      throw new NotFoundException(TicketErrorMessages.NotFound);
    }
    const tag = await this.tagRepository.findById(ticket.tagId);

    let predictionTime = ticket.predictionTime;
    if (dto.additionalType === TicketAdditionallyType.Fast) {
      predictionTime = Math.ceil(predictionTime - (predictionTime / 100 * 5));
    } else if (dto.additionalType === TicketAdditionallyType.Hard) {
      predictionTime = Math.ceil(predictionTime + (predictionTime / 100 * 30));
    } else {
      predictionTime = tag.time;
    }

    ticket.updateAdditionallyType({
      additionalType: dto.additionalType,
      predictionTime: predictionTime,
    });
    return await this.ticketRepository.save(ticket);
  }

  async updatePhilanthropyId(id: string, dto: UpdateTicketPhilanthropyIdDto) {
    const ticket = await this.ticketRepository.findById(id);
    if (!ticket) {
      throw new NotFoundException(TicketErrorMessages.NotFound);
    }
    ticket.updatePhilanthropyId(dto.philanthropyId);
    return await this.ticketRepository.save(ticket);
  }

  async closeAllByUserId(userId: string) {
    const tickets = await this.ticketRepository.findByUserId(userId);
    for (const ticket of tickets) {
      ticket.closeTicket(ticket.predictionTime);
    }
    return await this.ticketRepository.save(tickets);
  }
}
