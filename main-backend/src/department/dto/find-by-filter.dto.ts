import { IsOptional } from 'class-validator';

export class FindByFilterDto {
  @IsOptional()
  services?: string;
}