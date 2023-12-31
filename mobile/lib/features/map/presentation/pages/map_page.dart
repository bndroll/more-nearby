import 'dart:async';
import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:location/location.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/presentation/bottom_sheet/domain/show_default_bottom_sheet.dart';
import 'package:vtb_map/core/presentation/bottom_sheet/presentation/default_bottom_sheet_header.dart';
import 'package:vtb_map/core/routing/routes_path.dart';
import 'package:vtb_map/features/banks/presentation/pages/cash_machine_info_page.dart';
import 'package:vtb_map/features/banks/presentation/pages/departments_events_modal_page.dart';
import 'package:vtb_map/features/banks/presentation/pages/filter_departments_page.dart';
import 'package:vtb_map/features/banks/presentation/widgets/cash_machine_view.dart';
import 'package:vtb_map/features/banks/presentation/widgets/department_view.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/services/location_service.dart';
import 'package:vtb_map/features/map/domain/use_cases/create_driving_route_use_case.dart';
import 'package:vtb_map/features/map/domain/use_cases/get_current_user_location_use_case.dart';
import 'package:vtb_map/features/map/domain/utils/yandex_map_helper.dart';
import 'package:vtb_map/features/banks/presentation/pages/department_info_page.dart';
import 'package:vtb_map/features/map/presentation/pages/route_page.dart';
import 'package:vtb_map/features/map/presentation/view_models/map_page_view_model.dart';
import 'package:vtb_map/features/map/presentation/widgets/map_controls.dart';
import 'package:vtb_map/features/map/presentation/widgets/route_point_view.dart';
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

class _MapPageState extends State<MapPage> with WidgetsBindingObserver, TickerProviderStateMixin {
  final Completer<YandexMapController> _controller = Completer();
  final LocationService _locationService = locator<LocationService>();
  late StreamSubscription<LocationData> _streamSubscription;
  final GlobalKey mapKey = GlobalKey();
  final defaultPoint = const MoscowLocation();
  late AppLocation _useLocation = defaultPoint;
  final _viewModel = locator<MapPageViewModel>();
  final GlobalKey _bsKey = GlobalKey();
  late final YandexMapHelper _yMapHelper;
  late final wContext = context;
  Point? endPoint;
  late final TabController _tabController = TabController(length: 2, vsync: this);

  onCursorTap() async {
    (await locator<GetCurrentUserLocationUseCase>().execute(null))
        .match(
            (l) => null,
            (r) => _yMapHelper.moveToCurrentLocation(r.value ?? const MoscowLocation())
    );
  }

  @override
  void initState() {
    _tabController.addListener(_handleTab);
    _viewModel.getDepartments();
    _viewModel.getCashMachines();
    super.initState();
  }

  _handleTab() {
    final index = _tabController.index;
    _viewModel.toggleFilter(index);
  }

  onTapCreateDrivingRoute() async {
    final pEnd = endPoint;
    if (pEnd == null) return;
    final startLocation = _useLocation;
    context.beamToNamed(routeSession, data: [
      RoutePointView(id: 'start_placemark', location: startLocation, isEndMark: false),
      RoutePointView(
          id: 'end_point',
          isEndMark: true,
          location: AppLocation(long: pEnd.longitude, lat: pEnd.latitude))
    ]);
  }

  onMapCreated(YandexMapController controller) async {
    _controller.complete(controller);
    _yMapHelper = YandexMapHelper(controller: controller);
    await controller.toggleUserLayer(visible: true, autoZoomEnabled: true);
    _yMapHelper.moveToCurrentLocation(defaultPoint);
    final isGranted =
    await _locationService.askPermissions(enableBackground: true);
    if (isGranted) {
      _useLocation = await _locationService.getCurrLocation();
      _yMapHelper.moveToCurrentLocation(_useLocation);
    }
  }

  _buildOnDepartmentTap(String departmentId, BuildContext context) =>
          () {
        showDefaultBottomSheet(
            context, [
          DepartmentInfoPage(
              department: _viewModel.departments.firstWhere((element) =>
              element.id == departmentId))
        ]);
      };
  _buildOnCashMachineTap(String cashMachineId, BuildContext context) => () {
    showDefaultBottomSheet(
        context, [
      CashMachineInfoPage(
          cashMachine: _viewModel.cashMachines.firstWhere((element) =>
          element.id == cashMachineId))
    ]);
  };

  Future<UserLocationView> onUserLocationAdded(UserLocationView view) async {
    return view.copyWith(
        pin: view.pin.copyWith(
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image:
                BitmapDescriptor.fromAssetImage('assets/icons/user.png')))),
        arrow: view.arrow.copyWith(
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image:
                BitmapDescriptor.fromAssetImage('lib/assets/arrow.png')))),
        accuracyCircle: view.accuracyCircle.copyWith(isVisible: false));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: _tabController,
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
                      Tab(text: 'Отделения'),
                      Tab(text: 'Банкоматы')
                    ],
                  ),
                ),
              ),
            )),
        bottomSheet: const DepartmentEventModalPage(),
        body: Stack(
          children: [
            Observer(
              builder: (_) =>
                  YandexMap(
                    key: mapKey,
                    mapObjects: [
                      if(_viewModel.isShowCashMachines) ..._viewModel.cashMachines.map((m) => CashMachineView(
                          departmentId: m.id,
                          cashMachineType: m.type,
                          location: m.location,
                          onTap: _buildOnCashMachineTap(m.id, context)
                      )),
                      if(!_viewModel.isShowCashMachines) ..._viewModel.departments.map((d) =>
                          DepartmentView(onTap: _buildOnDepartmentTap(d.id, context), department: d)),
                      if (endPoint != null)
                        RoutePointView(
                          id: 'end_point',
                          isEndMark: true,
                          location: AppLocation(
                              lat: endPoint?.latitude ?? 0,
                              long: endPoint?.longitude ?? 0),
                        )
                    ],
                    mapMode: MapMode.driving,
                    // onMapTap: onMapTap,
                    onMapCreated: onMapCreated,
                    onUserLocationAdded: onUserLocationAdded,
                  ),
            ),
            FutureBuilder(
              future: _controller.future,
                builder: (_, snapshot) {
                  final yController = snapshot.data;
                  if(yController != null) return MapControl(mapController: yController);
                  return const SizedBox();
                }
            )
          ],
        )
    );
  }
}


