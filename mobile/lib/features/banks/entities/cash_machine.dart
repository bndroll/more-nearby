import 'dart:convert';

import 'package:vtb_map/features/map/domain/entities/app_location.dart';

enum CashMachineType {
  vtb,
  partner
}

extension CashMachineTypeIcon on CashMachineType{
  String get iconAsset => switch(this) {
    CashMachineType.vtb => 'assets/icons/vtb_cm.png',
    CashMachineType.partner => 'assets/icons/pcm.png'
  };
}

CashMachineType fromString(String type)  {
  if(type == 'Own') return CashMachineType.vtb;
  return CashMachineType.partner;
}

class CashMachine {
  final String id;
  final AppLocation location;
  final String address;
  final CashMachineType type;
  final String info;
  final int balance;

//<editor-fold desc="Data Methods">
  const CashMachine({
    required this.id,
    required this.location,
    required this.address,
    required this.type,
    required this.info,
    required this.balance,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashMachine &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          location == other.location &&
          address == other.address &&
          type == other.type &&
          info == other.info &&
          balance == other.balance);

  @override
  int get hashCode =>
      id.hashCode ^
      location.hashCode ^
      address.hashCode ^
      type.hashCode ^
      info.hashCode ^
      balance.hashCode;

  @override
  String toString() {
    return 'CashMachine{' +
        ' id: $id,' +
        ' location: $location,' +
        ' address: $address,' +
        ' type: $type,' +
        ' info: $info,' +
        ' balance: $balance,' +
        '}';
  }

  CashMachine copyWith({
    String? id,
    AppLocation? location,
    String? address,
    CashMachineType? type,
    String? info,
    int? balance,
  }) {
    return CashMachine(
      id: id ?? this.id,
      location: location ?? this.location,
      address: address ?? this.address,
      type: type ?? this.type,
      info: info ?? this.info,
      balance: balance ?? this.balance,
    );
  }

  factory CashMachine.fromMap(Map<String, dynamic> map) {
    return CashMachine(
      id: map['id'] as String,
      location: AppLocation(long: double.parse(map['lon']), lat: double.parse(map['lat'])),
      address: map['address'] as String,
      type: fromString(map['type']),
      info: map['info'] as String,
      balance: map['balance'] as int,
    );
  }

  static List<CashMachine> listFromJson(String json) => List<CashMachine>.from(
  jsonDecode(json).map((x) => CashMachine.fromMap(x)));
}