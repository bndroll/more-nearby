import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { Department } from './entities/department.entity';
import { DepartmentRepository } from './repositories/department.repository';

@Injectable()
export class DepartmentService {
  constructor(
    private readonly departmentRepository: DepartmentRepository,
  ) {
  }

  async create(dto: CreateDepartmentDto) {
    const department = Department.create({
      title: dto.title,
      lat: dto.lat,
      lon: dto.lon,
      info: dto.info,
      address: dto.address,
    });
    return await this.departmentRepository.save(department);
  }

  async findAll() {
    return await this.departmentRepository.find();
  }

  async findById(id: string) {
    const department = await this.departmentRepository.findById(id);
    if (!department) {
      throw new NotFoundException();
    }

    return department;
  }
}
