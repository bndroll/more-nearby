import { Column, Entity, PrimaryColumn } from 'typeorm';
import { CreateUserEntityDto } from '../dto/create-user.dto';
import { generateString } from '@nestjs/typeorm';

@Entity()
export class User {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  name: string;

  @Column('varchar')
  phone: string;

  @Column('varchar')
  password: string;

  static create(dto: CreateUserEntityDto) {
    const instance = new User();
    instance.id = generateString();
    instance.name = dto.name;
    instance.phone = dto.phone;
    instance.password = dto.password;
    return instance;
  }

  updateName(name: string) {
    this.name = name;
  }
}
