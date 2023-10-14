import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateTagDto } from './dto/create-tag.dto';
import { TagRepository } from './repositories/tag.repository';
import { Tag } from './entities/tag.entity';

@Injectable()
export class TagService {
  constructor(
    private readonly tagRepository: TagRepository,
  ) {
  }

  async create(dto: CreateTagDto) {
    const oldTag = await this.tagRepository.findByTitle(dto.title);
    if (oldTag) {
      throw new BadRequestException();
    }

    const tag = Tag.create({
      title: dto.title,
      prefix: dto.prefix,
      type: dto.type,
      time: dto.time,
    });
    return await this.tagRepository.save(tag);
  }

  async findAll() {
    return await this.tagRepository.find();
  }

  async findById(id: string) {
    return await this.tagRepository.findById(id);
  }
}
