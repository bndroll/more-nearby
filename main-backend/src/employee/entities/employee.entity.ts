import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateEmployeeEntityDto } from '../dto/create-employee.dto';

@Entity()
export class Employee {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar', { unique: true })
  name: string;

  @Column('varchar')
  picture: string;

  @Column('varchar')
  post: string;

  @Column('uuid')
  departmentId: string;

  @Column('uuid')
  departmentQueueId: string;

  static create(dto: CreateEmployeeEntityDto) {
    const instance = new Employee();
    instance.id = generateString();
    instance.name = dto.name;
    instance.picture = dto.picture;
    instance.post = dto.post;
    instance.departmentId = dto.departmentId;
    instance.departmentQueueId = dto.departmentQueueId;
    return instance;
  }
}
