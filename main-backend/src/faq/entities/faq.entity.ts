import { Column, Entity, PrimaryColumn } from 'typeorm';
import { generateString } from '@nestjs/typeorm';
import { CreateFaqEntityDto } from '../dto/create-faq.dto';

@Entity()
export class Faq {
  @PrimaryColumn('uuid')
  id: string;

  @Column('varchar')
  request: string;

  @Column('varchar')
  response: string;

  static create(dto: CreateFaqEntityDto) {
    const instance = new Faq();
    instance.id = generateString();
    instance.request = dto.request;
    instance.response = dto.response;
    return instance;
  }

  updateRequest(request: string) {
    this.request = request;
  }

  updateResponse(response: string) {
    this.response = response;
  }
}
