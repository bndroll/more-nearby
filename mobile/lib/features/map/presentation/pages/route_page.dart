import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_driving_route_use_case.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_pedestrian_route_use_case.dart';
import 'package:vtb_map/features/map/domain/utils/yandex_map_helper.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

// class RoutePage extends StatefulWidget {
//   // final Future<DrivingSessionResult> result;
//   // final DrivingSession session;
//   final PlacemarkMapObject startPlacemark;
//   final PlacemarkMapObject endPlacemark;
//
//   const RoutePage(
//     this.startPlacemark,
//     this.endPlacemark, {super.key},
//   );
//
//   @override
//   RoutePage createState() => _RoutePage();
// }
//
// class _RoutePage extends State<RoutePage> {
//
// }
class RoutePage extends StatefulWidget {
  const RoutePage({Key? key, required this.startPlacemark, required this.endPlacemark}) : super(key: key);

  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage>  with TickerProviderStateMixin{
  late final List<MapObject> mapObjects = [
    widget.startPlacemark,
    widget.endPlacemark
  ];

  late final YandexMapController _yandexMapController;
  late final YandexMapHelper _yandexMapHelper;
  late final TabController _tabController = TabController(length: 2, vsync: this);

  DrivingResultWithSession? _drivingSession;
  final List<DrivingSessionResult> results = [];
  bool _progress = true;

  @override
  void initState() {
    super.initState();
    _handleRoute();
    _tabController.addListener(_handleRoute);
  }

  _handleRoute() {
    if(_tabController.index == 0) {
      _onCarRoute()
          .then((value) => _init());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _close();
  }

  onCreateMap(YandexMapController controller) {
    _yandexMapController = controller;
    _yandexMapHelper = YandexMapHelper(controller: controller);
    _yandexMapHelper.moveToCurrentLocation(AppLocation(lat: widget.startPlacemark.point.latitude, long: widget.startPlacemark.point.longitude));
  }

  Future<void> _onCarRoute() async {
    (await CreateDrivingRouteUseCase().execute(CreateRoutesArgs(
        end: AppLocation(long: widget.endPlacemark.point.longitude, lat: widget.endPlacemark.point.latitude),
        context: context
    )))
        .match(
            (l) => null,
            (r) => setState(() {
          _drivingSession = r;
        })
    );
  }

  Future<void> _onPedestrianRoute() async {
    (await CreatePedestrianUseCase().execute(CreateRoutesArgs(
        end: AppLocation(long: widget.endPlacemark.point.longitude, lat: widget.endPlacemark.point.latitude),
        context: context
    ))).match(
            (l) => null,
            (r) => null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom:  TabBar(
          controller: _tabController,
            tabs: const [
          Tab(
            icon: Icon(Icons.drive_eta),
          ),
          Tab(
            icon: Icon(Icons.man),
          )
        ]),
      ),
        body: YandexMap(
            onMapCreated: onCreateMap,
            mapObjects: mapObjects
        )
    );
  }


  Future<void> _close() async {
    await _drivingSession?.session.close();
  }

  Future<void> _init() async {
    await _handleResult(await _drivingSession!.result);
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      return;
    }

    setState(() {
      results.add(result);
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: Polyline(points: route.geometry),
          strokeColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }
}


