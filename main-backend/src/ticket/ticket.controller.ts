import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { TicketService } from './ticket.service';
import { CreateTicketDto } from './dto/create-ticket.dto';
import { AdminGuard } from '../user/guards/admin.guard';

@Controller('ticket')
export class TicketController {
  constructor(private readonly ticketService: TicketService) {
  }

  @Post()
  async create(@Body() dto: CreateTicketDto) {
    return await this.ticketService.create(dto);
  }

  @Get('find/by-user/:id')
  @UseGuards(AdminGuard)
  async findByUserId(@Param('id') userId: string) {
    return this.ticketService.findByUserId(userId);
  }

  @Get('/find/active-by-user/:id')
  async findUserTicket(@Param('id') userId: string) {
    return this.ticketService.findUserTicket(userId);
  }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updateTicketDto: UpdateTicketDto) {
  //   return this.ticketService.update(+id, updateTicketDto);
  // }
}
