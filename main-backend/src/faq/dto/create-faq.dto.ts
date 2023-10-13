import { IsNotEmpty, IsString } from 'class-validator';

export class CreateFaqDto {
  @IsNotEmpty()
  @IsString()
  request: string;

  @IsNotEmpty()
  @IsString()
  response: string;
}

export class CreateFaqEntityDto {
  request: string;
  response: string;
}