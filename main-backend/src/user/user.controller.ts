import { Controller, Get, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { JwtAuthGuard } from '../auth/guards/jwt.guard';
import { UserDecorator } from './decorators/user.decorator';
import { ApiTags } from '@nestjs/swagger';
import { User } from './entities/user.entity';

@ApiTags('User')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {
  }

  @Get('find/me')
  @UseGuards(JwtAuthGuard)
  async findMe(@UserDecorator() id: string): Promise<User> {
    return await this.userService.findById(id);
  }
}
