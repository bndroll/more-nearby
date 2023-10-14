import 'package:vtb_map/features/map/domain/entities/app_location.dart';

class DepartmentExtended {
  final String id;
  final AppLocation location;
  final String label;
  final String address;
  final int minutesQueue;
  final int minutesService;
  final String info;

  const DepartmentExtended({
    required this.id,
    required this.location,
    required this.label,
    required this.address,
    required this.minutesQueue,
    required this.minutesService,
    required this.info,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DepartmentExtended &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          location == other.location &&
          label == other.label &&
          address == other.address &&
          minutesQueue == other.minutesQueue &&
          minutesService == other.minutesService &&
          info == other.info);

  @override
  int get hashCode =>
      id.hashCode ^
      location.hashCode ^
      label.hashCode ^
      address.hashCode ^
      minutesQueue.hashCode ^
      minutesService.hashCode ^
      info.hashCode;

  @override
  String toString() {
    return 'DepartmentExtended{ id: $id, location: $location, label: $label, address: $address, minutesQueue: $minutesQueue, minutesService: $minutesService, info: $info,}';
  }

  DepartmentExtended copyWith({
    String? id,
    AppLocation? location,
    String? label,
    String? address,
    int? minutesQueue,
    int? minutesService,
    String? info,
  }) {
    return DepartmentExtended(
      id: id ?? this.id,
      location: location ?? this.location,
      label: label ?? this.label,
      address: address ?? this.address,
      minutesQueue: minutesQueue ?? this.minutesQueue,
      minutesService: minutesService ?? this.minutesService,
      info: info ?? this.info,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      'label': label,
      'address': address,
      'minutesQueue': minutesQueue,
      'minutesService': minutesService,
      'info': info,
    };
  }

  factory DepartmentExtended.fromMap(Map<String, dynamic> map) {
    return DepartmentExtended(
      id: map['id'] as String,
      location: map['location'] as AppLocation,
      label: map['label'] as String,
      address: map['address'] as String,
      minutesQueue: map['minutesQueue'] as int,
      minutesService: map['minutesService'] as int,
      info: map['info'] as String,
    );
  }
}