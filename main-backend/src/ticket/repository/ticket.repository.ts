import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { Ticket, TicketStatus } from '../entities/ticket.entity';

@Injectable()
export class TicketRepository extends Repository<Ticket> {
  constructor(private dataSource: DataSource) {
    super(Ticket, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByUserId(userId: string) {
    return await this.findBy({ userId });
  }

  async getLastTicketsByUserId(userId: string) {
    return await this.find({
      where: { userId, status: TicketStatus.Closed },
      order: { createdDate: 'DESC' },
      take: 10,
    });
  }

  async findOpenTicketByUserId(userId: string) {
    return await this.findOneBy({
      userId,
      status: In([TicketStatus.Open, TicketStatus.Pending]),
    });
  }

  async findOpenQueueTickets(departmentQueueId: string) {
    return await this.find({
      where: { status: TicketStatus.Open, departmentQueueId },
      order: { openDate: 'ASC' },
    });
  }

  async findByQueueId(departmentQueueId: string) {
    return await this.findBy({ visitDate: new Date(), departmentQueueId });
  }
}