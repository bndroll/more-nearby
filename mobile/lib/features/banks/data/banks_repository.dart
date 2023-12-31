import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/features/banks/entities/cash_machine.dart';
import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/banks/entities/tag.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:http/http.dart' as http;

//51.528032, 45.979318
class BanksRepository {

  final _baseUrl = const String.fromEnvironment("API");

  Future<Either<Failure, List<Department>>> getDepartments() async {
    final res = await http.get(Uri.parse('$_baseUrl/api/department'));
    if(res.statusCode == 500) return const Left(Failure(message: 'Ошибка сервера'));
    if(res.statusCode >= 400) return const Left(Failure(message: ''));
    return Right(Department.listFromJson(res.body));
  }

  Future<Either<Failure, List<Tag>>> getTags() async {
    final res = await http.get(Uri.parse('$_baseUrl/api/tag'));
    if(res.statusCode == 500) return const Left(Failure(message: 'Ошибка сервера'));
    if(res.statusCode >= 400) return const Left(Failure(message: ''));
    return Right(Tag.listFromJson(res.body));
  }

  Future<Either<Failure, List<CashMachine>>> getCashMachines() async {
    final res = await http.get(Uri.parse('$_baseUrl/api/cash-machine'));
    if(res.statusCode == 500) return const Left(Failure(message: 'Ошибка сервера'));
    if(res.statusCode >= 400) return const Left(Failure(message: ''));
    return Right(CashMachine.listFromJson(res.body));
  }
}
