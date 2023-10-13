import 'package:vtb_map/features/map/domain/entities/app_location.dart';

class Department {
  final int id;
  final AppLocation point;

  const Department({
    required this.id,
    required this.point,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Department &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          point == other.point);

  @override
  int get hashCode => id.hashCode ^ point.hashCode;

  @override
  String toString() {
    return 'Department{ id: $id, point: $point,}';
  }

  Department copyWith({
    int? id,
    AppLocation? point,
  }) {
    return Department(
      id: id ?? this.id,
      point: point ?? this.point,
    );
  }
}