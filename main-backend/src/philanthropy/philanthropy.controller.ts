import { Body, Controller, Post } from '@nestjs/common';
import { PhilanthropyService } from './philanthropy.service';
import { CreatePhilanthropyDto } from './dto/create-philanthropy.dto';

@Controller('philanthropy')
export class PhilanthropyController {
  constructor(private readonly philanthropyService: PhilanthropyService) {}

  @Post()
  async create(@Body() dto: CreatePhilanthropyDto) {
    return await this.philanthropyService.create(dto);
  }
}
