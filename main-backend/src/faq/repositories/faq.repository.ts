import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Faq } from '../entities/faq.entity';

@Injectable()
export class FaqRepository extends Repository<Faq> {
  constructor(private dataSource: DataSource) {
    super(Faq, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByRequest(request: string) {
    return await this.findOneBy({ request });
  }
}