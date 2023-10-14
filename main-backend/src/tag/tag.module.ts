import { Module } from '@nestjs/common';
import { TagService } from './tag.service';
import { TagController } from './tag.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Tag } from './entities/tag.entity';
import { TagRepository } from './repositories/tag.repository';

@Module({
  imports: [
    TypeOrmModule.forFeature([Tag]),
  ],
  controllers: [TagController],
  providers: [TagService, TagRepository],
  exports: [TagService, TagRepository]
})
export class TagModule {}
