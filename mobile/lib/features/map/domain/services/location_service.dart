import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';
import 'package:vtb_map/features/map/domain/services/location_service_base.dart';

class LocationService implements LocationServiceBase {

  final bool isBackgroundEnabled;
  final _initialLocation = const MoscowLocation();
  final Location _location;

  LocationService({
    required this.isBackgroundEnabled,
  }): _location = Location()..enableBackgroundMode(enable: isBackgroundEnabled).then((value) => debugPrint('----IS BACKGROUNF LOCATION ENABLED $value ----'));



  @override
  Future<bool> askPermissions({bool enableBackground = false}) async {
    final permResult = await _location.requestPermission();
    final serviceResult = await _location.requestService();
    return serviceResult && permResult == PermissionStatus.granted;
  }

  @override
  Future<bool> checkPermissions({bool enableBackground = false}) async {
    final locPerStatus = await _location.hasPermission();
    if(locPerStatus == PermissionStatus.denied || locPerStatus ==  PermissionStatus.deniedForever) return false;
    return await _location.serviceEnabled();
  }

  @override
  Future<AppLocation> getCurrLocation() async {
    final isPossible = await checkPermissions();
    if(!isPossible) return _initialLocation;
    final lData = await _location.getLocation();
    return AppLocation(lat: lData.latitude ?? 0, long: lData.longitude ?? 0);
  }

  @override
  Future<Stream<LocationData>> getLocationChangeStream() async {
    return _location.onLocationChanged;

  }
}