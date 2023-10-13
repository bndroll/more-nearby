import { Body, Controller, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { CashMachineService } from './cash-machine.service';
import { CreateCashMachineDto } from './dto/create-cash-machine.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { JwtAuthGuard } from '../auth/guards/jwt.guard';
import { UserDecorator } from '../user/decorators/user.decorator';
import { CreateCashMachineHistoryDto } from './dto/create-cash-machine-history.dto';

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

  @Patch(':id')
  async updateBalance(@Body() dto: CreateCashMachineHistoryDto) {
    return await this.cashMachineService.updateBalance(dto);
  }
}
