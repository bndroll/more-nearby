import { Body, Controller, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { TicketService } from './ticket.service';
import { CreateTicketDto } from './dto/create-ticket.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { CloseTicketDto, UpdateTicketAdditionalTypeDto, UpdateTicketPhilanthropyIdDto } from './dto/update-ticket.dto';

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

  @Patch(':id/open')
  async openTicket(@Param('id') id: string) {
    return this.ticketService.openTicket(id);
  }

  @Patch(':id/close')
  @UseGuards(AdminGuard)
  async closeTicket(@Param('id') id: string, @Body() dto: CloseTicketDto) {
    return this.ticketService.closeTicket(id, dto);
  }

  @Patch(':id/additional')
  @UseGuards(AdminGuard)
  async updateAdditionalType(@Param('id') id: string, @Body() dto: UpdateTicketAdditionalTypeDto) {
    return this.ticketService.updateAdditionalType(id, dto);
  }

  @Patch(':id/philanthropy')
  async updatePhilanthropyId(@Param('id') id: string, @Body() dto: UpdateTicketPhilanthropyIdDto) {
    return this.ticketService.updatePhilanthropyId(id, dto);
  }
}
