import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../entities/app_location.dart';

class YandexMapHelper {
  final YandexMapController controller;

  const YandexMapHelper({
    required this.controller,
  });

  Future<void> moveToCurrentLocation(
      AppLocation appLatLong,
      ) async {
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 15,
        ),
      ),
    );
  }

}