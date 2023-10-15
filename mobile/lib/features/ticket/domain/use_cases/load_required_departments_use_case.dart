import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/core/utils/utility_types/use_case_base.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_driving_route_use_case.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_pedestrian_route_use_case.dart';
import 'package:vtb_map/features/ticket/data/departments_extended.dart';
import 'package:vtb_map/features/ticket/data/ticket_repository.dart';
import 'package:vtb_map/features/ticket/domain/department_with_times.dart';
import 'package:vtb_map/features/ticket/domain/store/create_ticket_store.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../core/di/locator.dart';
import '../../../map/domain/use_cases/get_current_user_location_use_case.dart';

class LoadRequiredDepartmentUseCase
    implements UseCase<Future<Either<Failure, List<DepartmentWithTimes>>>, List<String>> {
  final _ticketRepository = TicketRepository();
  final _createTicketStore = locator<CreateTicketStore>();
  final _getUserLocation = locator<GetCurrentUserLocationUseCase>();

  @override
  Future<Either<Failure, List<DepartmentWithTimes>>> execute(List<String> args) async {
    final position = (await _getUserLocation.execute(null))
            .getOrElse((l) => ValueNotifier(const MoscowLocation()))
            .value ??
        const MoscowLocation();
    final List<DepartmentExtended> departmentsExtended =
        (await _ticketRepository.getDepartmentsByTags(args, position))
            .match((l) => [], (r) => r);

    final dDriving = await Future.wait(departmentsExtended.map((d) async =>
        (await CreateDrivingRouteUseCase()
                .execute(CreateRoutesArgs(start: position, end: d.location)))
            .result));
    final dPedestrian = await Future.wait(departmentsExtended.map((d) async =>
        (await CreatePedestrianUseCase()
                .execute(CreateRoutesArgs(start: position, end: d.location)))
            .result));

    final departmentsWithTimes =
        departmentsExtended.mapWithIndex((dExtended, index) {
      final shortestTimeDrivingRoute = dDriving[index]
          .routes
          ?.reduce((accum, currRoute) =>
              (accum.metadata.weight.timeWithTraffic.value ?? double.infinity) >
                      (currRoute.metadata.weight.timeWithTraffic.value ??
                          double.infinity)
                  ? currRoute
                  : accum)
          .metadata
          .weight
          .timeWithTraffic;
      final shortestTimePedestrianRoute = dPedestrian[index]
          .routes
          ?.reduce((accum, currRoute) =>
              (accum.weight.time.value ?? double.infinity) >
                      (currRoute.weight.time.value ?? double.infinity)
                  ? currRoute
                  : accum)
          .weight
          .time;
      return DepartmentWithTimes(
          departmentExtended: dExtended,
          drivingTimeText: shortestTimeDrivingRoute?.text ?? '',
          drivingTime: shortestTimeDrivingRoute?.value ?? 0,
          pedestrianTimeText: shortestTimePedestrianRoute?.text ?? '',
          pedestrianTime: shortestTimePedestrianRoute?.value ?? 0);
    }).toList();
    _createTicketStore.updateStepper(requiredDeps: departmentsWithTimes);
    _createTicketStore.setStepIndex(_createTicketStore.currStepIndex + 1);
    return Right(departmentsWithTimes);
  }
}
