import 'package:get_it/get_it.dart';
import 'package:vtb_map/features/map/domain/services/location_service.dart';

final locator = GetIt.instance;

setup() {
  locator.registerSingleton(LocationService(isBackgroundEnabled: true));
}