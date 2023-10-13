import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateDepartmentEntityDto } from '../dto/create-department.dto';

@Entity()
export class Department {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  title: string;

  @Column('varchar')
  lat: string;

  @Column('varchar')
  lon: string;

  @Column('text')
  address: string;

  @Column('varchar', { nullable: true })
  picture: string | null;

  @Column('varchar', { nullable: true })
  info: string | null;

  static create(dto: CreateDepartmentEntityDto) {
    const instance = new Department();
    instance.id = generateString();
    instance.title = dto.title;
    instance.lat = dto.lat;
    instance.lon = dto.lon;
    instance.address = dto.address;
    instance.picture = dto.picture;
    instance.info = dto.info;
    return instance;
  }

  updateInfo(info: string) {
    this.info = info;
  }

  updatePicture(picture: string) {
    this.picture = picture;
  }
}
