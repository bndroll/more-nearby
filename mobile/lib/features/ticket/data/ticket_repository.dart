import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/features/banks/data/banks_repository.dart';
import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/ticket/data/departments_extended.dart';

import '../../banks/entities/tag.dart';

class TicketRepository {
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


}