import { IsNotEmpty, IsString } from 'class-validator';

export class CreateDepartmentQueueDto {
  @IsNotEmpty()
  @IsString()
  title: string;

  @IsNotEmpty()
  @IsString()
  tagId: string;

  @IsNotEmpty()
  @IsString()
  departmentId: string;
}

export class CreateDepartmentQueueEntityDto {
  title: string;
  tagId: string;
  departmentId: string;
}
