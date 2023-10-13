import { Body, Controller, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { TicketService } from './ticket.service';
import { CreateTicketDto } from './dto/create-ticket.dto';
import { JwtAuthGuard } from '../auth/guards/jwt.guard';

@Controller('ticket')
export class TicketController {
  constructor(private readonly ticketService: TicketService) {
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  async create(@Body() dto: CreateTicketDto) {
    return await this.ticketService.create(dto);
  }

  @Get('find/by-user-id/:id')
  async findByUserId(@Param('id') userId: string) {
    return this.ticketService.findByUserId(userId);
  }

  @Get()
  findAll() {
    return this.ticketService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.ticketService.findOne(+id);
  }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updateTicketDto: UpdateTicketDto) {
  //   return this.ticketService.update(+id, updateTicketDto);
  // }
}
