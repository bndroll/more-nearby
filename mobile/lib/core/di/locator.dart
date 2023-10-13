import 'package:get_it/get_it.dart';
import 'package:vtb_map/features/map/domain/services/location_service.dart';
import 'package:vtb_map/features/map/presentation/view_models/map_page_view_model.dart';

final locator = GetIt.instance;

setup() {
  locator.registerSingleton(LocationService(isBackgroundEnabled: true));
  locator.registerSingleton(MapPageViewModel());
}