import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Employee } from '../entities/employee.entity';

@Injectable()
export class EmployeeRepository extends Repository<Employee> {
  constructor(private dataSource: DataSource) {
    super(Employee, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByName(name: string) {
    return await this.findOneBy({ name });
  }

  async findByDepartmentId(departmentId: string) {
    return await this.findBy({ departmentId });
  }

  async findByDepartmentQueueId(departmentQueueId: string) {
    return await this.findBy({ departmentQueueId });
  }
}