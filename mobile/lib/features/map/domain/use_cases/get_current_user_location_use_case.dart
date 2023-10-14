import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/utils/utility_types/failure.dart';
import 'package:vtb_map/core/utils/utility_types/use_case_base.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/services/location_service.dart';

class GetCurrentUserLocationUseCase implements UseCase<Future<Either<Failure, ValueNotifier<AppLocation?>>>, dynamic> {

  final _locationService = locator<LocationService>();
  final ValueNotifier<AppLocation?> _appLocationNotifier = ValueNotifier(null);
  StreamSubscription? _locationEventsSub;

  @override
  Future<Either<Failure, ValueNotifier<AppLocation?>>> execute(args) async {
    final isMayGetLocation = await _locationService.checkPermissions();
    if(!isMayGetLocation) return const Left(Failure(message: 'Необходимы разрешения на геолокацию'));
    if(_appLocationNotifier.value == null) {
      final initialLocation = await _locationService.getCurrLocation();
      _appLocationNotifier.value = initialLocation;
    }
    if(_locationEventsSub == null) {
      _locationService.getLocationChangeStream().then((locationStream) {
        _locationEventsSub = locationStream.listen((event) {
          _appLocationNotifier.value = AppLocation(lat: event.latitude ?? 0, long: event.longitude ?? 0);
        });
      });
    }
    return Right(_appLocationNotifier);
  }

}
