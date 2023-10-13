import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DepartmentView extends PlacemarkMapObject {
  final String departmentId;
  final AppLocation departmentLocation;

  factory DepartmentView({
    required String departmentId,
    required AppLocation location,
    required void Function() onTap,
  }) => DepartmentView._(
      departmentId,
      location,
      mapId: MapObjectId(departmentId.toString()),
      onTap: (_, point) {
        onTap();
      },
      point:  Point(
          longitude: location.long,
          latitude: location.lat
      ),
      icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/icons/bank_icon.png'),
              scale: 0.3
          )
      )
  );

  const DepartmentView._(
      this.departmentId,
      this.departmentLocation,
      {required super.mapId, required super.point, super.onTap, super.icon, super.direction, super.text});
}
