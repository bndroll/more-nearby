import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { TagService } from './tag.service';
import { CreateTagDto } from './dto/create-tag.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Tag')
@Controller('tag')
export class TagController {
  constructor(private readonly tagService: TagService) {
  }

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateTagDto) {
    return await this.tagService.create(dto);
  }

  @Get()
  async findAll() {
    return await this.tagService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.tagService.findById(id);
  }
}
