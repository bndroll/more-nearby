import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateTagDto {
  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  prefix: string;

  @IsNotEmpty()
  @IsString()
  type: string;

  @IsNotEmpty()
  @IsNumber()
  time: number;
}

export class CreateTagEntityDto {
  title: string;
  prefix: string;
  type: string;
  time: number;
}
