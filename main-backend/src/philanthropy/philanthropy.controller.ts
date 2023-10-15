import { Body, Controller, Get, Post } from '@nestjs/common';
import { PhilanthropyService } from './philanthropy.service';
import { CreatePhilanthropyDto } from './dto/create-philanthropy.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Philanthropy')
@Controller('philanthropy')
export class PhilanthropyController {
  constructor(private readonly philanthropyService: PhilanthropyService) {}

  @Post()
  async create(@Body() dto: CreatePhilanthropyDto) {
    return await this.philanthropyService.create(dto);
  }

  @Get()
  async findAll() {
    return await this.philanthropyService.findAll();
  }
}
