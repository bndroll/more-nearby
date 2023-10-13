import 'dart:async';
import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:location/location.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/presentation/bottom_sheet/domain/show_default_bottom_sheet.dart';
import 'package:vtb_map/core/routing/routes_path.dart';
import 'package:vtb_map/features/banks/presentation/widgets/department_view.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/services/location_service.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_driving_route_use_case.dart';
import 'package:vtb_map/features/map/domain/utils/yandex_map_helper.dart';
import 'package:vtb_map/features/map/presentation/pages/route_page.dart';
import 'package:vtb_map/features/map/presentation/view_models/map_page_view_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late YandexMapController _controller;
  final LocationService _locationService = locator<LocationService>();
  late StreamSubscription<LocationData> _streamSubscription;
  final GlobalKey mapKey = GlobalKey();
  final defaultPoint = const MoscowLocation();
  late AppLocation _useLocation = defaultPoint;
  final _viewModel = locator<MapPageViewModel>();

  late final YandexMapHelper _yMapHelper;

  Point? endPoint;

  onMapTap(Point? point) {
    setState(() {
      endPoint = point;
    });
  }

  onCursorTap() async {
    final location = await _locationService.getCurrLocation();
    _yMapHelper.moveToCurrentLocation(location);
  }

  @override
  void initState() {
    _viewModel.getDepartments();
    // _locationService.askPermissions(enableBackground: true);
    // _locationService
    //     .getLocationChangeStream()
    //     .then((value) => _streamSubscription = value.listen((event) {}));
    super.initState();
  }

  onTapCreateDrivingRoute() async {
    final pEnd = endPoint;
    if(pEnd == null) return;
    final startLocation = _useLocation;
    context.beamToNamed(routeSession, data: [
        PlacemarkMapObject(
            mapId: const MapObjectId('end_placemark'),
                                point: Point(longitude: startLocation.long, latitude: startLocation.lat),
                                icon: PlacemarkIcon.single(
                                    PlacemarkIconStyle(
                                        image: BitmapDescriptor.fromAssetImage('assets/icons/route_end.png'),
                                        scale: 0.3
                                    )
                                )
                            ),
      PlacemarkMapObject(
          mapId: const MapObjectId('end_placemark'),
          point: pEnd,
          icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/icons/route_end.png'),
                  scale: 0.3
              )
          )
      ),
    ]);
  }

  onMapCreated(YandexMapController controller) async {
    _controller = controller;
    _yMapHelper = YandexMapHelper(controller: _controller);
    await _controller.toggleUserLayer(visible: true, autoZoomEnabled: true);
    _yMapHelper.moveToCurrentLocation(defaultPoint);
    final isGranted = await _locationService.askPermissions(enableBackground: true);
    if(isGranted) {
      _useLocation = await _locationService.getCurrLocation();
      _yMapHelper.moveToCurrentLocation(_useLocation);
    }
   }

   _buildOnDepartmentTap(int departmentId, BuildContext context) => () {
    showDefaultBottomSheet(context, [
      const Center(child: Text('Инфа о ебучем банке'))
    ]);
   };

  Future<UserLocationView> onUserLocationAdded(UserLocationView view) async {
    return view.copyWith(
        pin: view.pin.copyWith(
            icon: PlacemarkIcon.single(
                PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/icons/user.png'))
            )
        ),
        arrow: view.arrow.copyWith(
            icon: PlacemarkIcon.single(
                PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/arrow.png'))
            )
        ),
        accuracyCircle: view.accuracyCircle.copyWith(
            fillColor: Colors.green.withOpacity(0.5)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Observer(
        builder: (_) => YandexMap(
            key: mapKey,
            mapObjects: [
              ..._viewModel.departments.map((d) => DepartmentView(
                  departmentId: d.id,
                  location: d.point,
                  onTap: _buildOnDepartmentTap(d.id, context)
              )),
             if(endPoint != null) PlacemarkMapObject(mapId: const MapObjectId('end_point'), point: endPoint!)
            ],
            mapMode: MapMode.driving,
            onMapTap: onMapTap,
            onMapCreated: onMapCreated,
            onUserLocationAdded: onUserLocationAdded ,
        ),
      ),
      floatingActionButton: Row(children: [
        IconButton(
          iconSize: 30,
          icon: const Icon(Icons.location_on),
          onPressed: onCursorTap,
        ),
        const SizedBox(width: 10),
        ElevatedButton(onPressed: onTapCreateDrivingRoute, child: const Text('Построить авто маршрут'))
      ]),
    );
  }
}
