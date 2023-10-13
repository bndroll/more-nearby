import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { PhilanthropyHistory } from '../entities/philanthropy.entity';

@Injectable()
export class PhilanthropyHistoryRepository extends Repository<PhilanthropyHistory> {
  constructor(private dataSource: DataSource) {
    super(PhilanthropyHistory, dataSource.createEntityManager());
  }
}