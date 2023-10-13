import { CashMachineType } from '../entities/cash-machine.entity';
import { IsEnum, IsNotEmpty, IsOptional, IsString } from 'class-validator';

export class CreateCashMachineDto {
  @IsNotEmpty()
  @IsString()
  lat: string;

  @IsNotEmpty()
  @IsString()
  lon: string;

  @IsNotEmpty()
  @IsString()
  address: string;

  @IsNotEmpty()
  @IsEnum(CashMachineType)
  type: CashMachineType;

  @IsOptional()
  @IsString()
  info?: string;
}

export class CreateCashMachineEntityDto {
  lat: string;
  lon: string;
  address: string;
  type: CashMachineType;
  info?: string;
}
