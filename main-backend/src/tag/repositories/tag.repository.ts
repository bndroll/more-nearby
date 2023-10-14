import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { Tag } from '../entities/tag.entity';

@Injectable()
export class TagRepository extends Repository<Tag> {
  constructor(private dataSource: DataSource) {
    super(Tag, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByTitle(title: string) {
    return await this.findOneBy({ title });
  }

  async findByType(types: string[]) {
    return await this.findBy({ type: In(types) });
  }
}