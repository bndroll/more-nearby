import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { FaqService } from './faq.service';
import { CreateFaqDto } from './dto/create-faq.dto';
import { AdminGuard } from '../user/guards/admin.guard';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Faq')
@Controller('faq')
export class FaqController {
  constructor(private readonly faqService: FaqService) {
  }

  @Post()
  @UseGuards(AdminGuard)
  async create(@Body() dto: CreateFaqDto) {
    return await this.faqService.create(dto);
  }

  @Get()
  async findAll() {
    return await this.faqService.findAll();
  }
}
