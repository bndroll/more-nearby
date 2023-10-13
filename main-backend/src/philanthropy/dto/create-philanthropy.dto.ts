import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreatePhilanthropyDto {
  @IsNotEmpty()
  @IsString()
  ticketId: string;

  @IsNotEmpty()
  @IsNumber()
  sum: number;
}

export class CreatePhilanthropyEntityDto {
  ticketId: string;
  sum: number;
}