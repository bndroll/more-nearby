import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateEmployeeDto } from './dto/create-employee.dto';
import { EmployeeRepository } from './repotitories/employee.repository';
import { EmployeeErrorMessages } from './employee.constants';
import { Employee } from './entities/employee.entity';

@Injectable()
export class EmployeeService {
  constructor(
    private readonly employeeRepository: EmployeeRepository,
  ) {
  }

  async create(dto: CreateEmployeeDto) {
    const oldEmployee = await this.employeeRepository.findByName(dto.name);
    if (oldEmployee) {
      throw new BadRequestException(EmployeeErrorMessages.AlreadyExist);
    }

    const employee = Employee.create({
      name: dto.name,
      post: dto.post,
      picture: dto.picture,
      departmentId: dto.departmentId,
      departmentQueueId: dto.departmentQueueId,
    });
    return await this.employeeRepository.save(employee);
  }

  async findById(id: string) {
    const employee = await this.employeeRepository.findById(id);
    if (!employee) {
      throw new NotFoundException(EmployeeErrorMessages.NotFound);
    }

    return employee;
  }

  async findByDepartmentId(departmentId: string) {
    return await this.employeeRepository.findByDepartmentId(departmentId);
  }

  async findByQueueId(queueId: string) {
    return await this.employeeRepository.findByDepartmentQueueId(queueId);
  }
}
