import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateTagEntityDto } from '../dto/create-tag.dto';

@Entity()
export class Tag {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  title: string;

  @Column('varchar')
  prefix: string;

  @Column('varchar')
  type: string;

  @Column('integer')
  time: number;

  static create(dto: CreateTagEntityDto) {
    const instance = new Tag();
    instance.id = generateString();
    instance.title = dto.title;
    instance.prefix = dto.prefix;
    instance.type = dto.type;
    instance.time = dto.time;
    return instance;
  }
}
