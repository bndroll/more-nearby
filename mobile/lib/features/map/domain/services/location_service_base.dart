import 'package:location/location.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';

abstract class LocationServiceBase {
  Future<AppLocation> getCurrLocation();
  Future<Stream<LocationData>> getLocationChangeStream();
  Future<bool> checkPermissions({bool enableBackground = false});
  Future<bool> askPermissions({bool enableBackground = false});
}