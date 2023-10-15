import { Controller, Get, UseGuards } from '@nestjs/common';
import { UserService } from './user.service';
import { JwtAuthGuard } from '../auth/guards/jwt.guard';
import { UserDecorator } from './decorators/user.decorator';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('User')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {
  }

  @Get('find/me')
  @UseGuards(JwtAuthGuard)
  async findMe(@UserDecorator() id: string) {
    return await this.userService.findById(id);
  }
}
