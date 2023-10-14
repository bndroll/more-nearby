import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { Department } from './entities/department.entity';
import { DepartmentRepository } from './repositories/department.repository';
import { FindByFilterDto } from './dto/find-by-filter.dto';
import { TagRepository } from '../tag/repositories/tag.repository';
import { DepartmentQueueRepository } from '../department-queue/repositories/department-queue.repository';
import { DepartmentErrorMessages } from './department.constants';

@Injectable()
export class DepartmentService {
  constructor(
    private readonly departmentRepository: DepartmentRepository,
    private readonly departmentQueueRepository: DepartmentQueueRepository,
    private readonly tagRepository: TagRepository,
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
      throw new NotFoundException(DepartmentErrorMessages.NotFound);
    }

    const departmentQueues = await this.departmentQueueRepository.findByDepartmentId(department.id);

    return {
      department,
      queues: departmentQueues,
    };
  }

  async findByFilter(query: FindByFilterDto) {
    if (!query.services) {
      return await this.departmentRepository.find();
    }

    const types = query.services.split(',');
    const tagIds = (await this.tagRepository.findByType(types)).map(item => item.id);
    const departmentIds = (await this.departmentQueueRepository.findByTagIds(tagIds)).map(item => item.departmentId);
    const uniqueDepartmentIds = Array.from(new Set(departmentIds));
    return await this.departmentRepository.findByDepartmentsIds(uniqueDepartmentIds);
  }
}
