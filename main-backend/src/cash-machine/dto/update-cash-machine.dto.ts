import { PartialType } from '@nestjs/mapped-types';
import { CreateCashMachineDto } from './create-cash-machine.dto';

export class UpdateCashMachineDto extends PartialType(CreateCashMachineDto) {}
