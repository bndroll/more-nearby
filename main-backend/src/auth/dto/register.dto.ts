import { IsNotEmpty, IsPhoneNumber, IsString, MinLength } from 'class-validator';

export class RegisterDto {
  @IsNotEmpty()
  @IsString()
  @MinLength(3)
  name: string;

  @IsNotEmpty()
  @IsPhoneNumber('RU')
  phone: string;

  @IsNotEmpty()
  @IsString()
  @MinLength(5)
  password: string;
}
