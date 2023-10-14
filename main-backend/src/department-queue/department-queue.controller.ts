import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { DepartmentQueueService } from './department-queue.service';
import { CreateDepartmentQueueDto } from './dto/create-department-queue.dto';
import { AdminGuard } from '../user/guards/admin.guard';

@Controller('department-queue')
export class DepartmentQueueController {
  constructor(private readonly departmentQueueService: DepartmentQueueService) {
  }

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateDepartmentQueueDto) {
    return this.departmentQueueService.create(dto);
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return this.departmentQueueService.findById(id);
  }

  @Get('find/by-department/:id')
  async findByDepartmentId(@Param('id') departmentId: string) {
    return this.departmentQueueService.findByDepartmentId(departmentId);
  }
}
