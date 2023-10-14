import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CloseTicketDto {
  @IsNotEmpty()
  @IsNumber()
  resultTime: number;
}

export class UpdateTicketPredictionTimeDto {
  @IsNotEmpty()
  @IsNumber()
  predictionTime: number;
}

export class UpdateTicketPhilanthropyIdDto {
  @IsNotEmpty()
  @IsString()
  philanthropyId: string;
}
