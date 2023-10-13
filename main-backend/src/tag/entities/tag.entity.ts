import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateTagEntityDto } from '../dto/create-tag.dto';

@Entity()
export class Tag {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  title: string;

  @Column('integer')
  time: number;

  static create(dto: CreateTagEntityDto) {
    const instance = new Tag();
    instance.id = generateString();
    instance.title = dto.title;
    instance.time = dto.time;
    return instance;
  }
}
