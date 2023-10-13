import { Module } from '@nestjs/common';
import { CashMachineService } from './cash-machine.service';
import { CashMachineController } from './cash-machine.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CashMachine } from './entities/cash-machine.entity';
import { CashMachineHistory } from './entities/cash-machine-history.entity';
import { CashMachineRepository } from './repositories/cash-machine.repository';
import { CashMachineHistoryRepository } from './repositories/cash-machine-history.repository';
import { UserModule } from '../user/user.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([CashMachine, CashMachineHistory]),
    UserModule,
  ],
  controllers: [CashMachineController],
  providers: [CashMachineService, CashMachineRepository, CashMachineHistoryRepository],
})
export class CashMachineModule {
}
