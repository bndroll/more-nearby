import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/core/utils/utility_types/use_case_base.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/services/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreateRoutesArgs {
  final AppLocation? start;
  final AppLocation end;
  final BuildContext context;

  const CreateRoutesArgs({
    this.start,
    required this.end,
    required this.context,
  });
}

class CreateDrivingRouteUseCase implements UseCase<Future<Either<Failure, DrivingResultWithSession>>, CreateRoutesArgs> {

  final _locationService = locator<LocationService>();

  @override
  Future<Either<Failure, DrivingResultWithSession>> execute(CreateRoutesArgs args) async {
    final startLocation = args.start ?? (await _locationService.getCurrLocation());

    final points = [
      Point(latitude: startLocation.lat, longitude: startLocation.long),
      Point(latitude: args.end.lat, longitude: args.end.long)
    ];

    final drivingResWithSession = YandexDriving.requestRoutes(
        points: points
            .map((point) => RequestPoint(point: point, requestPointType: RequestPointType.wayPoint))
            .toList(),
        drivingOptions: const DrivingOptions(
          routesCount: 3,
        )
    );
    return Right(drivingResWithSession);
  }

}