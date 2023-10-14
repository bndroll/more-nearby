import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { DepartmentQueue } from '../entities/department-queue.entity';
import { CreateDepartmentQueueDto } from '../dto/create-department-queue.dto';
import { FindWithTagTitleDto } from '../dto/find-with-tag-title.dto';

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

  async findWithTagTitleByDepartmentId(departmentId: string): Promise<FindWithTagTitleDto[]> {
    return await this.query(`
      select dq.*, t.title as "tagTitle" from department_queue dq 
      join tag t on dq."tagId" = t.id  
      where dq."departmentId" = $1
    `, [departmentId]);
  }
}