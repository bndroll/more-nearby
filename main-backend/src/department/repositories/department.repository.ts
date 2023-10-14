import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { Department } from '../entities/department.entity';

@Injectable()
export class DepartmentRepository extends Repository<Department> {
  constructor(private dataSource: DataSource) {
    super(Department, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByDepartmentsIds(ids: string[]) {
    return await this.findBy({ id: In(ids) });
  }
}