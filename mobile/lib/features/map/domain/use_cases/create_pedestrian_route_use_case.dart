import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/core/utils/utility_types/use_case_base.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_driving_route_use_case.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../core/di/locator.dart';
import '../services/location_service.dart';



class CreatePedestrianUseCase implements UseCase<Future<BicycleResultWithSession>, CreateRoutesArgs> {

  final _locationService = locator<LocationService>();

  @override
  Future<BicycleResultWithSession> execute(CreateRoutesArgs args) async {
    final startLocation = args.start ?? (await _locationService.getCurrLocation());

    final points = [
      Point(latitude: startLocation.lat, longitude: startLocation.long),
      Point(latitude: args.end.lat, longitude: args.end.long)
    ];

    final pedestrianResWithSession = YandexBicycle.requestRoutes(
        points: points
            .map((point) => RequestPoint(point: point, requestPointType: RequestPointType.wayPoint))
            .toList(),
         bicycleVehicleType: BicycleVehicleType.bicycle
    );
    return pedestrianResWithSession;
  }
}