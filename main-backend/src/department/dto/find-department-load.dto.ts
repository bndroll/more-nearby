export class FindDepartmentLoadItemDto {
  id: string;
  avg: number;
}

export class FindDepartmentsWithLoadResponseDto {
  id: string;
  title: string;
  lat: string;
  lon: string;
  address: string;
  picture: string | null;
  info: string | null;
  target: number;
}