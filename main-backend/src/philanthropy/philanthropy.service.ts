import { Injectable } from '@nestjs/common';
import { CreatePhilanthropyDto } from './dto/create-philanthropy.dto';
import { PhilanthropyHistoryRepository } from './repositories/philanthropy-history.repository';
import { PhilanthropyHistory } from './entities/philanthropy.entity';

@Injectable()
export class PhilanthropyService {
  constructor(private readonly philanthropyHistoryRepository: PhilanthropyHistoryRepository) {
  }

  async create(dto: CreatePhilanthropyDto) {
    const philanthropy = PhilanthropyHistory.create({
      ticketId: dto.ticketId,
      sum: dto.sum,
    });
    return await this.philanthropyHistoryRepository.save(philanthropy);
  }
}
