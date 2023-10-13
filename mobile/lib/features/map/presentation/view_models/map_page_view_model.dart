import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import '../../domain/entities/app_location.dart';

part 'map_page_view_model.g.dart';

final class _MapViewModelState {
  final RequestStatus userLocStatus;
  final RequestStatus banksStatus;
  final List<AppLocation> points;

//<editor-fold desc="Data Methods">
  const _MapViewModelState({
    required this.userLocStatus,
    required this.banksStatus,
    required this.points,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _MapViewModelState &&
          runtimeType == other.runtimeType &&
          userLocStatus == other.userLocStatus &&
          banksStatus == other.banksStatus &&
          points == other.points);

  @override
  int get hashCode =>
      userLocStatus.hashCode ^ banksStatus.hashCode ^ points.hashCode;

  @override
  String toString() {
    return '_MapViewModelState{ userLocStatus: $userLocStatus, banksStatus: $banksStatus, points: $points,}';
  }

  _MapViewModelState copyWith({
    RequestStatus? userLocStatus,
    RequestStatus? banksStatus,
    List<AppLocation>? points,
  }) {
    return _MapViewModelState(
      userLocStatus: userLocStatus ?? this.userLocStatus,
      banksStatus: banksStatus ?? this.banksStatus,
      points: points ?? this.points,
    );
  }

}

const _initialState = _MapViewModelState(
    userLocStatus: RequestStatus.never,
    banksStatus: RequestStatus.never,
    points: []
);

class MapPageViewModel = MapPageViewModelBase with _$MapPageViewModel;

//Банки через репозиторий,
//Поиск через useCase
abstract class MapPageViewModelBase with Store {
  @observable
  var _state = _initialState;

  @action
  _setState(_MapViewModelState state) => _state = state;

}
