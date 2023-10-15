import { Body, Controller, Get, Param, Post, Query, UseGuards } from '@nestjs/common';
import { DepartmentService } from './department.service';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { FindByFilterDto } from './dto/find-by-filter.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Department')
@Controller('department')
export class DepartmentController {
  constructor(private readonly departmentService: DepartmentService) {}

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateDepartmentDto) {
    return await this.departmentService.create(dto);
  }

  @Get()
  async findAll(@Query() query: FindByFilterDto) {
    return await this.departmentService.findByFilter(query);
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.departmentService.findById(id);
  }
}
