import 'dart:convert';
import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/features/banks/data/banks_repository.dart';
import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/ticket/data/create_ticket_dto.dart';
import 'package:vtb_map/features/ticket/data/departments_extended.dart';
import 'package:http/http.dart' as http;
import 'package:vtb_map/features/ticket/data/ticket_dto.dart';

class TicketRepository {

  final _baseUrl = const String.fromEnvironment("API");
  final _userId = String.fromEnvironment('');

  Future<Either<Failure, List<DepartmentExtended>>> getDepartmentsByTags(List<String> tagIds, AppLocation location) async {
    return (await BanksRepository().getDepartments())
        .match(
            (l) => Left(l),
            (r) => Right(r.map((department) => DepartmentExtended(
                id: department.id,
                location: department.point,
                label: department.title,
                address: department.address,
                minutesQueue: Random().nextInt(120),
                minutesService: Random().nextInt(120),
                info: department.info
            )).toList())
    );
  }

  Future<Either<Failure, TicketDto>> createTicket(CreateTicketDto createTicketDto) async {
      final res = await http.post(Uri.parse('$_baseUrl/api/ticket'), body: createTicketDto.toMap());
      if(res.statusCode == 500) return const Left(Failure(message: 'Ошибка сервера'));
      if(res.statusCode >= 400) return const Left(Failure(message: ''));
      return Right(TicketDto.fromMap(jsonDecode(res.body)));
  }


}