import { Module } from '@nestjs/common';
import { PhilanthropyService } from './philanthropy.service';
import { PhilanthropyController } from './philanthropy.controller';
import { PhilanthropyHistoryRepository } from './repositories/philanthropy-history.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PhilanthropyHistory } from './entities/philanthropy.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([PhilanthropyHistory]),
  ],
  controllers: [PhilanthropyController],
  providers: [PhilanthropyService, PhilanthropyHistoryRepository],
})
export class PhilanthropyModule {
}
