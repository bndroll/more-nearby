import { DataSource } from 'typeorm';
import { ConfigService } from '@nestjs/config';
import { config } from 'dotenv';

config();
export default new DataSource({
  type: 'postgres',
  host: '127.0.0.1',
  port: 5432,
  username: 'secret_user',
  password: 'secret_pass',
  database: 'nearby',
  entities: [`${__dirname}/../src/**/*.entity{.ts,.js}`],
  synchronize: false,
  migrations: [`${__dirname}/migrations/*{.ts,.js}`],
  migrationsTableName: 'migrations',
});

