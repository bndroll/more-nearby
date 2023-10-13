import { BadRequestException, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { RegisterDto } from './dto/register.dto';
import { LoginDto, LoginResponseDto } from './dto/login.dto';
import { compare, genSalt, hash } from 'bcryptjs';
import { UserRepository } from '../user/repositories/user.repository';
import { User } from '../user/entities/user.entity';
import { AuthConstants } from './auth.constants';
import { JwtValidationDto } from './dto/jwt-validation.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly userRepository: UserRepository,
    private readonly jwtService: JwtService,
  ) {
  }

  async register(dto: RegisterDto) {
    const oldUser = await this.userRepository.findByPhone(dto.phone);
    if (oldUser) {
      throw new BadRequestException(AuthConstants.AlreadyRegistered);
    }

    const salt = await genSalt(10);
    const user = User.create({
      name: dto.name,
      phone: dto.phone,
      password: await hash(dto.password, salt),
    });
    return await this.userRepository.save(user);
  }

  async login(dto: LoginDto): Promise<LoginResponseDto> {
    const payload = await this.validateUser({
      phone: dto.phone,
      password: dto.password,
    });
    return {
      access_token: await this.jwtService.signAsync(payload),
    };
  }

  async validateUser(dto: LoginDto): Promise<JwtValidationDto> {
    const user = await this.userRepository.findByPhone(dto.phone);
    if (!user) {
      throw new UnauthorizedException(AuthConstants.NotFound);
    }

    const isCorrectPassword = await compare(dto.password, user.password);
    if (!isCorrectPassword) {
      throw new UnauthorizedException(AuthConstants.ValidationFailed);
    }

    return {
      id: user.id,
      phone: user.phone,
    };
  }
}
