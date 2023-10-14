import 'dart:convert';

import 'package:vtb_map/features/map/domain/entities/app_location.dart';

enum DepartmentWorkload{
  danger,
  warning,
  good
}

extension DepartmentWorkloadIcon on DepartmentWorkload {
  String get assetIcon => switch(this) {
    DepartmentWorkload.danger => 'assets/icons/department_danger.png',
    DepartmentWorkload.warning => 'assets/icons/department_warning.png',
    DepartmentWorkload.good => 'assets/icons/department_good.png'
  };
}

class Department {
  final String id;
  final AppLocation point;
  final String address;
  final String? picture;
  final String title;
  final String info;
  final int target;

  const Department({
    required this.id,
    required this.point,
    required this.address,
    required this.picture,
    required this.title,
    required this.info,
    required this.target
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Department &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          point == other.point &&
          address == other.address &&
          picture == other.picture &&
          title == other.title &&
          info == other.info);

  @override
  int get hashCode =>
      id.hashCode ^
      point.hashCode ^
      address.hashCode ^
      picture.hashCode ^
      title.hashCode ^
      info.hashCode;

  @override
  String toString() {
    return 'Department{ id: $id, point: $point, address: $address, picture: $picture, title: $title, info: $info,}';
  }

  DepartmentWorkload get departmentWorkLoad {
    if(target <= 25) return DepartmentWorkload.good;
    if(target <= 75) return DepartmentWorkload.warning;
    return DepartmentWorkload.danger;
  }

  Department copyWith({
    String? id,
    AppLocation? point,
    String? address,
    String? picture,
    String? title,
    String? info,
    int? target
  }) {
    return Department(
      id: id ?? this.id,
      point: point ?? this.point,
      address: address ?? this.address,
      picture: picture ?? this.picture,
      title: title ?? this.title,
      info: info ?? this.info,
      target: target ?? this.target
    );
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'],
      point: AppLocation(lat: double.parse(map['lat']), long: double.parse(map['lon'])),
      address: map['address'] as String,
      picture: map['picture'],
      title: map['title'] as String,
      info: map['info'] as String,
      target: map['target'] as int
    );
  }



  static List<Department> listFromJson(String json) => List<Department>.from(
      jsonDecode(json).map((x) => Department.fromMap(x))
  );
}