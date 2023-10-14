import 'package:vtb_map/features/banks/entities/cash_machine.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../map/domain/entities/app_location.dart';

class CashMachineView extends PlacemarkMapObject {
  final String cashMachineId;
  final CashMachineType cashMachineType;
  final AppLocation cashMachineLocation;

  factory CashMachineView({
    required String departmentId,
    required CashMachineType cashMachineType,
    required AppLocation location,
    required void Function() onTap,
  }) => CashMachineView._(
      cashMachineType,
      departmentId,
      location,
      mapId: MapObjectId(departmentId.toString()),
      onTap: (_, point) {
        onTap();
      },
      opacity: 1,
      point:  Point(
          longitude: location.long,
          latitude: location.lat
      ),
      icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(cashMachineType.iconAsset),
              scale: 3
          )
      )
  );

  const CashMachineView._(
      this.cashMachineType,
      this.cashMachineId,
      this.cashMachineLocation,
      {required super.mapId, required super.point, super.onTap, super.icon, super.direction, super.opacity});
}
