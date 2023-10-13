import { TicketAdditionallyType, TicketStatus } from '../entities/ticket.entity';

export class CreateTicketDto {
  request: string;
  status: TicketStatus.Pending | TicketStatus.Open;
  userId: string;
  tagId: string;
  departmentQueueId: string;
}

export class CreateTicketEntityDto {
  title: string;
  num: number;
  request: string;
  predictionTime: number;
  status: TicketStatus;
  additionallyType: TicketAdditionallyType;
  userId: string;
  tagId: string;
  departmentQueueId: string;
}
