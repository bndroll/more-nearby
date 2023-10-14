export class CreateTicketHistoryEntityDto {
  departmentQueueId: string;
  date: Date;
}

export class CreateTicketHistoryItemDto {
  historyId: string;
  num: number;
  values: number[];
  target: number;
}

export class CreateTicketHistoryItemEntityDto {
  historyId: string;
  num: number;
  values: string;
  target: number;
}