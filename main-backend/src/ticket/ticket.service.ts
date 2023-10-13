import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateTicketDto } from './dto/create-ticket.dto';
import { TicketRepository } from './repository/ticket.repository';
import { UserErrorMessages } from '../user/user.constants';
import { UserRepository } from '../user/repositories/user.repository';

@Injectable()
export class TicketService {
  constructor(
    private readonly ticketRepository: TicketRepository,
    private readonly userRepository: UserRepository,
  ) {
  }

  async create(dto: CreateTicketDto) {
    const user = await this.userRepository.findById(dto.userId);
    if (!user) {
      throw new NotFoundException(UserErrorMessages.NotFound);
    }

    return 'This action adds a new ticket';
  }

  async findByUserId(userId: string) {
    return await this.ticketRepository.findByUserId(userId);
  }

  findAll() {
    return `This action returns all ticket`;
  }

  findOne(id: number) {
    return `This action returns a #${id} ticket`;
  }

  // update(id: number, updateTicketDto: UpdateTicketDto) {
  //   return `This action updates a #${id} ticket`;
  // }

  remove(id: number) {
    return `This action removes a #${id} ticket`;
  }
}
