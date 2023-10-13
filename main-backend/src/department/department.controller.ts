import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { DepartmentService } from './department.service';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { AdminGuard } from '../user/guards/admin.guard';

@Controller('department')
export class DepartmentController {
  constructor(private readonly departmentService: DepartmentService) {}

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateDepartmentDto) {
    return await this.departmentService.create(dto);
  }

  @Get()
  async findAll() {
    return await this.departmentService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.departmentService.findById(id);
  }
}
