import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
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
}