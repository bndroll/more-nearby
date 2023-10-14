import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:vtb_map/core/routing/routes_path.dart';
import 'package:vtb_map/features/map/presentation/pages/map_page.dart';
import 'package:vtb_map/features/map/presentation/pages/route_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

final beamerDelegate = BeamerDelegate(
    initialPath: map,
    locationBuilder: RoutesLocationBuilder(
        routes: {
            map: (_, state, __) => const MapPage(),
            routeSession: (_, state, data) {
                final placemarks = data as List<PlacemarkMapObject>;
                return RoutePage(startPlacemark: placemarks[0], endPlacemark:placemarks[1]);
            }
        })
);