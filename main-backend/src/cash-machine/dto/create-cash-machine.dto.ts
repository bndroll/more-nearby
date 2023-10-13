import { CashMachineType } from '../entities/cash-machine.entity';
import { IsEnum, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class CreateCashMachineDto {
  @IsNotEmpty()
  @IsString()
  geo: string;

  @IsNotEmpty()
  @IsEnum(CashMachineType)
  type: CashMachineType;

  @IsOptional()
  @IsString()
  info?: string;
}

export class CreateCashMachineEntityDto {
  geo: string;
  type: CashMachineType;
  info?: string;
}
