import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateDepartmentQueueEntityDto } from '../dto/create-department-queue.dto';

@Entity()
export class DepartmentQueue {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  title: string;

  @Column('uuid')
  tagId: string;

  @Column('uuid')
  departmentId: string;

  @Column('uuid')
  counterId: string;

  static create(dto: CreateDepartmentQueueEntityDto) {
    const instance = new DepartmentQueue();
    instance.id = generateString();
    instance.title = dto.title;
    instance.tagId = dto.tagId;
    instance.departmentId = dto.departmentId;
    return instance;
  }

  updateCounterId(counterId: string) {
    this.counterId = counterId;
  }
}
