import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { EmployeeService } from './employee.service';
import { CreateEmployeeDto } from './dto/create-employee.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Employee')
@Controller('employee')
export class EmployeeController {
  constructor(private readonly employeeService: EmployeeService) {
  }

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateEmployeeDto) {
    return await this.employeeService.create(dto);
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.employeeService.findById(id);
  }

  @Get('find/by-department-id/:id')
  async findByDepartmentId(@Param('id') departmentId: string) {
    return await this.employeeService.findByDepartmentId(departmentId);
  }

  @Get('find/by-queue-id/:id')
  async findByQueueId(@Param('id') queueId: string) {
    return await this.employeeService.findByQueueId(queueId);
  }
}
