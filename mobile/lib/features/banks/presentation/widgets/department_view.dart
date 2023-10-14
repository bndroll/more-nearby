import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../entities/department.dart';

class DepartmentView extends PlacemarkMapObject {
  final Department department;

  factory DepartmentView({
    required Department department,
    required void Function() onTap,
  }) => DepartmentView._(
      department,
      mapId: MapObjectId(department.id),
      onTap: (_, point) {
        onTap();
      },
      opacity: 1,
      point:  Point(
          longitude: department.point.long,
          latitude: department.point.lat
      ),
      icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(department.departmentWorkLoad.assetIcon),
              scale: 0.4
          )
      )
  );

  const DepartmentView._(
      this.department,
      {required super.mapId, required super.point, super.onTap, super.icon, super.direction, super.opacity});
}
