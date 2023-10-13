import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';
import { ConfigService } from '@nestjs/config';
import { AdminGuardHeader } from '../user.constants';

@Injectable()
export class AdminGuard implements CanActivate {
  constructor(private readonly configService: ConfigService) {
  }

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const adminToken = this.configService.get('ADMIN_TOKEN');
    if (!adminToken) {
      return false;
    }

    const request = context.switchToHttp().getRequest();
    const data = this.extractDataFromHeader(request);
    if (!data) {
      return false;
    }

    return adminToken === data;
  }

  private extractDataFromHeader(request: Request): string | undefined {
    return request.header(AdminGuardHeader);
  }
}
