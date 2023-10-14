import { Injectable } from '@nestjs/common';
import { DataSource, In, Repository } from 'typeorm';
import { Department } from '../entities/department.entity';
import { FindDepartmentLoadItemDto } from '../dto/find-department-load.dto';
import { FindQueueAnalyticItemDto } from '../dto/find-queue-analytic.dto';
import { FindGraphData } from '../dto/graph.dto';

@Injectable()
export class DepartmentRepository extends Repository<Department> {
  constructor(private dataSource: DataSource) {
    super(Department, dataSource.createEntityManager());
  }

  async findById(id: string) {
    return await this.findOneBy({ id });
  }

  async findByDepartmentsIds(ids: string[]) {
    return await this.findBy({ id: In(ids) });
  }

  async findDepartmentLoad(num: number): Promise<FindDepartmentLoadItemDto[]> {
    return await this.query(`
      select d.id, avg(thi.target) from department d 
      join department_queue dq on dq."departmentId" = d.id 
      join ticket_history th on th."departmentQueueId" = dq.id 
      join ticket_history_item thi on thi."historyId" = th.id 
      where thi.num = $1
      group by d.id
    `, [num]);
  }

  async findDepartmentQueueAnalytic(id: string): Promise<FindQueueAnalyticItemDto[]> {
    return await this.query(`
      select dq.id, sum(t."predictionTime"), count(t.id) from department d 
      join department_queue dq on d.id = dq."departmentId" 
      join ticket t on t."departmentQueueId" = dq.id 
      where t.status = 'Open' and d.id = $1
      group by dq.id
    `, [id]);
  }

  async findGraphDataByNums(id: string): Promise<FindGraphData[]> {
    return await this.query(`
      select thi.num, avg(thi.target) from department d 
      join department_queue dq on d.id = dq."departmentId"
      join ticket_history th on th."departmentQueueId" = dq.id 
      join ticket_history_item thi on thi."historyId" = th.id 
      where d.id = $1
      group by thi.num
    `, [id]);
  }
}