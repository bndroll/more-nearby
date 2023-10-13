import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/entities/app_location.dart';

class RoutePointView extends PlacemarkMapObject {

  final String id;
  final AppLocation location;
  // final void Function(PlacemarkMapObject) onDragEnded;

  factory RoutePointView({
    required String id,
    required AppLocation location,
    // required void Function(PlacemarkMapObject) onDragEnded
  }) => RoutePointView._(
    id,
    location,
    // onDragEnded,
    // onDragEnd: onDragEnded,
    mapId: MapObjectId(id),
    isDraggable: true,
    point: Point(longitude: location.long, latitude: location.lat),
    icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/icons/route_end.png')
        )
    )
  );

  const RoutePointView._(
      this.id,
      this.location,
      // this.onDragEnded,
      {
        required super.mapId,
        required super.point,
        super.isDraggable,
        super.icon,
        super.onDragEnd,
      });

}