import { IsEnum, IsNotEmpty, IsNumber, IsString } from 'class-validator';
import { TicketAdditionallyType } from '../entities/ticket.entity';

export class CloseTicketDto {
  @IsNotEmpty()
  @IsNumber()
  resultTime: number;
}

export class UpdateTicketAdditionalTypeDto {
  @IsNotEmpty()
  @IsEnum(TicketAdditionallyType)
  additionalType: TicketAdditionallyType;
}

export class UpdateTicketPhilanthropyIdDto {
  @IsNotEmpty()
  @IsString()
  philanthropyId: string;
}

export class UpdateTicketAdditionalTypeEntityDto {
  additionalType: TicketAdditionallyType;
  predictionTime: number;
}