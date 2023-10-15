import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDepartmentDto } from './dto/create-department.dto';
import { Department } from './entities/department.entity';
import { DepartmentRepository } from './repositories/department.repository';
import { FindByFilterDto } from './dto/find-by-filter.dto';
import { TagRepository } from '../tag/repositories/tag.repository';
import { DepartmentQueueRepository } from '../department-queue/repositories/department-queue.repository';
import { DepartmentErrorMessages } from './department.constants';
import { FindDepartmentsWithLoadResponseDto } from './dto/find-department-load.dto';
import { GraphItem } from './dto/graph.dto';

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

  async findById(id: string) {
    const department = await this.departmentRepository.findById(id);
    if (!department) {
      throw new NotFoundException(DepartmentErrorMessages.NotFound);
    }

    const queuesAnalytic = await this.departmentRepository.findDepartmentQueueAnalytic(id);
    const departmentQueues = (await this.departmentQueueRepository.findWithTagTitleByDepartmentId(department.id))
      .map(item => {
        const analytic = queuesAnalytic.find(el => el.id === item.id);
        return {
          ...item,
          analytic: {
            queueCount: analytic ? parseInt(analytic.count) : 0,
            waitingTime: analytic ? parseInt(analytic.sum) : 0,
          },
        };
      });

    const graphDataByNum = await this.departmentRepository.findGraphDataByNums(department.id);
    const graph: GraphItem[] = new Array(13)
      .fill(0)
      .map((item, i) => {
          const num = i + 9;
          const graphData = graphDataByNum.find(el => el.num === num);
          return {
            num: num,
            value: graphData ? Math.round(graphData.avg) : 35 + Math.round(Math.random() * 30),
          };
        },
      );

    return {
      ...department,
      graph,
      queues: departmentQueues,
    };
  }

  async findByFilter(query: FindByFilterDto): Promise<FindDepartmentsWithLoadResponseDto[]> {
    let departments: Department[];
    if (!query.services) {
      departments = await this.departmentRepository.find();
    } else {
      const types = query.services.split(',');
      const tagIds = (await this.tagRepository.findByType(types)).map(item => item.id);
      const departmentIds = (await this.departmentQueueRepository.findByTagIds(tagIds)).map(item => item.departmentId);
      const uniqueDepartmentIds = Array.from(new Set(departmentIds));
      departments = await this.departmentRepository.findByDepartmentsIds(uniqueDepartmentIds);
    }

    let currentNum = new Date().getUTCHours() + 3;
    if (currentNum > 21 || currentNum < 9) {
      currentNum = 21;
    }
    const departmentLoad = await this.departmentRepository.findDepartmentLoad(currentNum);
    return departments.map(item => ({
      ...item,
      target: Math.round(departmentLoad.find(dl => dl.id === item.id).avg),
    }));
  }
}
