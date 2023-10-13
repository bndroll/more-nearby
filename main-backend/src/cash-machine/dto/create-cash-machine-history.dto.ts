import { IsEnum, IsNotEmpty, IsNumber, IsOptional, IsPositive, IsString } from 'class-validator';
import { CashMachineHistoryOperation, CashMachineHistoryStatus } from '../entities/cash-machine-history.entity';

export class CreateCashMachineHistoryDto {
  @IsNotEmpty()
  @IsString()
  userId: string;

  @IsNotEmpty()
  @IsString()
  cashMachineId: string;

  @IsOptional()
  @IsNumber()
  sum: number;

  @IsNotEmpty()
  @IsEnum(CashMachineHistoryOperation)
  operation: CashMachineHistoryOperation;

  @IsNotEmpty()
  @IsEnum(CashMachineHistoryStatus)
  status: CashMachineHistoryStatus;
}

export class CreateCashMachineHistoryEntityDto {
  userId: string;
  cashMachineId: string;
  sum: number;
  operation: CashMachineHistoryOperation;
  status: CashMachineHistoryStatus;
}
