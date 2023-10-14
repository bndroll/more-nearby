import 'package:flutter/material.dart';
import 'package:vtb_map/features/map/domain/utils/yandex_map_helper.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../core/di/locator.dart';
import '../../domain/entities/app_location.dart';
import '../../domain/use_cases/get_current_user_location_use_case.dart';

class MapControl extends StatefulWidget {
  const MapControl({Key? key, required this.mapController}) : super(key: key);

  final YandexMapController mapController;

  @override
  State<MapControl> createState() => _MapControlState();
}

class _MapControlState extends State<MapControl> {

  late final YandexMapHelper _yMapHelper = YandexMapHelper(controller: widget.mapController);

  _onZoomIn() {
    widget.mapController.moveCamera(CameraUpdate.zoomIn(), animation: const MapAnimation(
        type: MapAnimationType.linear, duration: 0.3),);
  }

  _onZoomOut() {
    widget.mapController.moveCamera(CameraUpdate.zoomOut(),
        animation: const MapAnimation(
            type: MapAnimationType.linear, duration: 0.3));
  }

  onCursorTap() async {
    (await locator<GetCurrentUserLocationUseCase>().execute(null))
        .match(
            (l) => null,
            (r) => _yMapHelper.moveToCurrentLocation(r.value ?? const MoscowLocation())
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: onCursorTap,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius
                          .circular(16)),
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary
                  ),
                  height: 40,
                  width: 40,
                  child: const Center(child: Icon(Icons.location_on,
                      color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _onZoomIn,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        16)),
                    color: Colors.white,

                  ),
                  height: 40,
                  width: 40,
                  child: const Center(child: Icon(Icons.add)),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: _onZoomOut,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(
                          16))
                  ),
                  height: 40,
                  width: 40,
                  child: const Center(child: Icon(Icons.remove)),
                ),
              ),
            ]),
      ),
    );
  }
}
