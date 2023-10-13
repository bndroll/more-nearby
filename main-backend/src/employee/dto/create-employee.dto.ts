import { IsNotEmpty, IsString } from 'class-validator';

export class CreateEmployeeDto {
  @IsNotEmpty()
  @IsString()
  name: string;

  @IsNotEmpty()
  @IsString()
  picture: string;

  @IsNotEmpty()
  @IsString()
  post: string;

  @IsNotEmpty()
  @IsString()
  departmentId: string;

  @IsNotEmpty()
  @IsString()
  departmentQueueId: string;
}

export class CreateEmployeeEntityDto {
  name: string;
  picture: string;
  post: string;
  departmentId: string;
  departmentQueueId: string;
}