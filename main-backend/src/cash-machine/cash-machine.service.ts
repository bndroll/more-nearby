import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCashMachineDto } from './dto/create-cash-machine.dto';
import { CashMachineRepository } from './repositories/cash-machine.repository';
import { CashMachineHistoryRepository } from './repositories/cash-machine-history.repository';
import { CashMachine } from './entities/cash-machine.entity';
import { UserRepository } from '../user/repositories/user.repository';
import { CreateCashMachineHistoryDto } from './dto/create-cash-machine-history.dto';
import {
  CashMachineHistory,
  CashMachineHistoryOperation,
  CashMachineHistoryStatus,
} from './entities/cash-machine-history.entity';
import { UserErrorMessages } from '../user/user.constants';
import { CashMachineErrorMessages } from './cash-machine.constants';
import { UpdateBalanceForce } from './dto/update-cash-machine.dto';

@Injectable()
export class CashMachineService {
  constructor(
    private readonly cashMachineRepository: CashMachineRepository,
    private readonly cashMachineHistoryRepository: CashMachineHistoryRepository,
    private readonly userRepository: UserRepository,
  ) {
  }

  async create(dto: CreateCashMachineDto) {
    const machine = CashMachine.create({
      lon: dto.lon,
      lat: dto.lat,
      address: dto.address,
      type: dto.type,
      info: dto.info,
    });
    return await this.cashMachineRepository.save(machine);
  }

  async findAll() {
    return await this.cashMachineRepository.find();
  }

  async findHistoryByMachineId(machineId: string) {
    const machine = await this.cashMachineRepository.findById(machineId);
    if (!machine) {
      throw new NotFoundException(CashMachineErrorMessages.NotFound);
    }

    return await this.cashMachineHistoryRepository.findByMachineId(machineId);
  }

  async updateBalanceForce(dto: UpdateBalanceForce) {
    const machine = await this.cashMachineRepository.findById(dto.cashMachineId);
    if (!machine) {
      throw new NotFoundException(CashMachineErrorMessages.NotFound);
    }
    machine.updateBalance(dto.balance);
    return await this.cashMachineRepository.save(machine);
  }

  async updateBalance(dto: CreateCashMachineHistoryDto) {
    if (dto.sum === 0) {
      return;
    }

    const user = await this.userRepository.findById(dto.userId);
    if (!user) {
      throw new NotFoundException(UserErrorMessages.NotFound);
    }

    const machine = await this.cashMachineRepository.findById(dto.cashMachineId);
    if (!machine) {
      throw new NotFoundException(CashMachineErrorMessages.NotFound);
    }

    if (dto.operation === CashMachineHistoryOperation.Fill) {
      const historyItem = CashMachineHistory.create({
        userId: dto.userId,
        cashMachineId: dto.cashMachineId,
        operation: dto.operation,
        status: CashMachineHistoryStatus.Complete,
        sum: dto.sum,
      });
      machine.updateBalance(Math.abs(dto.sum));
      await this.cashMachineRepository.save(machine);
      return await this.cashMachineHistoryRepository.save(historyItem);
    }


    if (machine.balance >= dto.sum) {
      const historyItem = CashMachineHistory.create({
        userId: dto.userId,
        cashMachineId: dto.cashMachineId,
        operation: dto.operation,
        status: CashMachineHistoryStatus.Complete,
        sum: dto.sum,
      });
      machine.updateBalance(-1 * Math.abs(dto.sum));
      await this.cashMachineRepository.save(machine);
      return await this.cashMachineHistoryRepository.save(historyItem);
    }

    const historyItem = CashMachineHistory.create({
      userId: dto.userId,
      cashMachineId: dto.cashMachineId,
      operation: dto.operation,
      status: CashMachineHistoryStatus.Error,
      sum: dto.sum,
    });
    return await this.cashMachineHistoryRepository.save(historyItem);
  }
}
