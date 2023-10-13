import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { DepartmentQueue } from '../entities/department-queue.entity';
import { CreateDepartmentQueueDto } from '../dto/create-department-queue.dto';

@Injectable()
export class DepartmentQueueRepository extends Repository<DepartmentQueue> {
  constructor(private dataSource: DataSource) {
    super(DepartmentQueue, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findUnique(dto: CreateDepartmentQueueDto) {
    return await this.findOneBy({ departmentId: dto.departmentId, tagId: dto.tagId });
  }

  async findByDepartmentId(departmentId: string) {
    return await this.findBy({ departmentId });
  }

  async findByTagIds(tagIds: string[]) {
    return await this.findBy({ tagId: In(tagIds) });
  }
}