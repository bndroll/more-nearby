import { Body, Controller, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { CashMachineService } from './cash-machine.service';
import { CreateCashMachineDto } from './dto/create-cash-machine.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { CreateCashMachineHistoryDto } from './dto/create-cash-machine-history.dto';
import { UpdateBalanceForce } from './dto/update-cash-machine.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Cash Machine')
@Controller('cash-machine')
export class CashMachineController {
  constructor(private readonly cashMachineService: CashMachineService) {
  }

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateCashMachineDto) {
    return await this.cashMachineService.create(dto);
  }

  @Get()
  async findAll() {
    return await this.cashMachineService.findAll();
  }

  @Get(':id')
  @UseGuards(AdminGuard)
  async findHistoryByMachine(@Param('id') machineId: string) {
    return await this.cashMachineService.findHistoryByMachineId(machineId);
  }

  @Patch(':id/force')
  async updateBalanceForce(@Body() dto: UpdateBalanceForce) {
    return await this.cashMachineService.updateBalanceForce(dto);
  }

  @Patch(':id')
  async updateBalance(@Body() dto: CreateCashMachineHistoryDto) {
    return await this.cashMachineService.updateBalance(dto);
  }
}
