import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/entities/app_location.dart';

class RoutePointView extends PlacemarkMapObject {

  final String id;
  final AppLocation location;
  final bool isEndMark;

  factory RoutePointView({
    required String id,
    required AppLocation location,
    required bool isEndMark
    // required void Function(PlacemarkMapObject) onDragEnded
  }) => RoutePointView._(
    id,
    location,
    isEndMark,
    mapId: MapObjectId(id),
    isDraggable: true,
    point: Point(longitude: location.long, latitude: location.lat),
    icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(isEndMark ? 'assets/icons/bank_placemark.png' : 'assets/icons/route_start.png')
        )
    )
  );

  const RoutePointView._(
      this.id,
      this.location,
      this.isEndMark,
      // this.onDragEnded,
      {
        required super.mapId,
        required super.point,
        super.isDraggable,
        super.icon,
        super.onDragEnd,
      });

}