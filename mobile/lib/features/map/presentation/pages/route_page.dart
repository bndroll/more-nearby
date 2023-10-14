import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_driving_route_use_case.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_pedestrian_route_use_case.dart';
import 'package:vtb_map/features/map/domain/utils/yandex_map_helper.dart';
import 'package:vtb_map/features/map/presentation/widgets/map_controls.dart';
import 'package:vtb_map/features/map/presentation/widgets/route_point_view.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key, required this.startPlacemark, required this.endPlacemark}) : super(key: key);

  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage>  with TickerProviderStateMixin{
  late List<MapObject> mapObjects = [
    widget.startPlacemark,
    widget.endPlacemark
  ];

  late final colors = [
    Theme.of(context).colorScheme.primary,
    Theme.of(context).colorScheme.secondary,
    Colors.blueAccent
  ];

  final Completer<YandexMapController> _yandexMapController = Completer();
  late final YandexMapHelper _yandexMapHelper;
  late final TabController _tabController = TabController(length: 2, vsync: this);

  DrivingResultWithSession? _drivingSession;
  BicycleResultWithSession? _pedestrianSession;
  (DrivingSessionResult?, BicycleSessionResult?) results = (null, null);
  bool _progress = true;

  @override
  void initState() {
    super.initState();
    _handleRoute();
    _tabController.addListener(_handleRoute);
  }

  _handleRoute() {
    if(_tabController.index == 0) {
      _onCarRoute().then((value) => _initDriving());
    }
    if(_tabController.index == 1) {
      _onPedestrianRoute().then((value) => _initPedestrian());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _close();
  }

  onCreateMap(YandexMapController controller) {
    _yandexMapController.complete(controller);
    _yandexMapHelper = YandexMapHelper(controller: controller);
    _yandexMapHelper.moveToCurrentLocation(AppLocation(lat: widget.startPlacemark.point.latitude, long: widget.startPlacemark.point.longitude));
  }

  Future<void> _onCarRoute() async {
    if(_drivingSession != null) return;
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
    if(_pedestrianSession != null) return;
    (await CreatePedestrianUseCase().execute(CreateRoutesArgs(
        end: AppLocation(long: widget.endPlacemark.point.longitude, lat: widget.endPlacemark.point.latitude),
        context: context
    ))).match(
            (l) => null,
            (r) => setState(() {
              _pedestrianSession = r;
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .background,
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondaryContainer,
                      borderRadius: const BorderRadius.all(
                          Radius.circular((10)))),
                  child: TabBar(
                    padding: const EdgeInsets.all(5),
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular((10))),
                        color: Colors.white),
                    unselectedLabelColor: Colors.black,
                    labelColor: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    tabs: const [
                      Tab(icon: Icon(Icons.drive_eta),),
                      Tab(icon: Icon(Icons.man),)
                    ],
                  ),
                ),
              ),
            )),
          body: Stack(
            children: [
              YandexMap(
                onMapCreated: onCreateMap,
                mapObjects: [
                  ...mapObjects,
                  widget.startPlacemark,
                  widget.endPlacemark
                ]
            ),
              FutureBuilder(
                  future: _yandexMapController.future,
                  builder: (_, snapshot) {
                    final controller = snapshot.data;
                    if(controller != null) return MapControl(mapController: controller);
                    return const SizedBox();
              })
            ]
          )
      ),
    );
  }


  Future<void> _close() async {
    await _drivingSession?.session.close();
    await _pedestrianSession?.session.close();
  }

  Future<void> _initDriving() async {
    await _handleDrivingResult(await _drivingSession!.result);
  }

  Future<void> _initPedestrian() async {
    await _handlePedestrianResult(await _pedestrianSession!.result);
  }

  Future<void> _handleDrivingResult(DrivingSessionResult result) async {
    setState(() {
      _progress = false;
    });
    if (result.error != null) {
      return;
    }
    setState(() {
      results = (result, results.$2);
      mapObjects = [];
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(
            PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: Polyline(points: route.geometry),
          strokeColor: colors[i],
          strokeWidth: 3,
        ));
      });
    });
  }

  Future<void> _handlePedestrianResult(BicycleSessionResult result) async {
    setState(() {
      results = (results.$1, result);
      mapObjects = [];
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(
            PolylineMapObject(
              mapId: MapObjectId('route_${i}_polyline'),
              polyline: Polyline(points: route.geometry),
              strokeColor: colors[i],
              strokeWidth: 3,
            ));
      });
    });
  }
}


