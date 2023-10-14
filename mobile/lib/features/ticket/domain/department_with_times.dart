import 'package:vtb_map/features/ticket/data/departments_extended.dart';

class DepartmentWithTimes {
  final DepartmentExtended departmentExtended;
  final String drivingTimeText;
  final double drivingTime;
  final String pedestrianTimeText;
  final double pedestrianTime;

  const DepartmentWithTimes({
    required this.departmentExtended,
    required this.drivingTimeText,
    required this.drivingTime,
    required this.pedestrianTimeText,
    required this.pedestrianTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DepartmentWithTimes &&
          runtimeType == other.runtimeType &&
          departmentExtended == other.departmentExtended &&
          drivingTimeText == other.drivingTimeText &&
          drivingTime == other.drivingTime &&
          pedestrianTimeText == other.pedestrianTimeText &&
          pedestrianTime == other.pedestrianTime);

  @override
  int get hashCode =>
      departmentExtended.hashCode ^
      drivingTimeText.hashCode ^
      drivingTime.hashCode ^
      pedestrianTimeText.hashCode ^
      pedestrianTime.hashCode;

  @override
  String toString() {
    return 'DepartmentWithTimes{ departmentExtended: $departmentExtended, drivingTimeText: $drivingTimeText, drivingTime: $drivingTime, pedestrianTimeText: $pedestrianTimeText, pedestrianTime: $pedestrianTime,}';
  }

  DepartmentWithTimes copyWith({
    DepartmentExtended? departmentExtended,
    String? drivingTimeText,
    double? drivingTime,
    String? pedestrianTimeText,
    double? pedestrianTime,
  }) {
    return DepartmentWithTimes(
      departmentExtended: departmentExtended ?? this.departmentExtended,
      drivingTimeText: drivingTimeText ?? this.drivingTimeText,
      drivingTime: drivingTime ?? this.drivingTime,
      pedestrianTimeText: pedestrianTimeText ?? this.pedestrianTimeText,
      pedestrianTime: pedestrianTime ?? this.pedestrianTime,
    );
  }
}