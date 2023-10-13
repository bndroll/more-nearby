import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/data/banks_repository.dart';
import '../../../banks/entities/department.dart';
import '../../domain/entities/app_location.dart';

part 'map_page_view_model.g.dart';

final class _MapViewModelState {
  final RequestStatus userLocStatus;
  final RequestStatus departmentsStatus;
  final List<AppLocation> points;
  final List<Department> departments;

  const _MapViewModelState({
    required this.userLocStatus,
    required this.departmentsStatus,
    required this.points,
    required this.departments,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _MapViewModelState &&
          runtimeType == other.runtimeType &&
          userLocStatus == other.userLocStatus &&
          departmentsStatus == other.departmentsStatus &&
          points == other.points &&
          departments == other.departments);

  @override
  int get hashCode =>
      userLocStatus.hashCode ^
      departmentsStatus.hashCode ^
      points.hashCode ^
      departments.hashCode;

  @override
  String toString() {
    return '_MapViewModelState{ userLocStatus: $userLocStatus, banksStatus: $departmentsStatus, points: $points, departments: $departments,}';
  }

  _MapViewModelState copyWith({
    RequestStatus? userLocStatus,
    RequestStatus? departmentsStatus,
    List<AppLocation>? points,
    List<Department>? departments,
  }) {
    return _MapViewModelState(
      userLocStatus: userLocStatus ?? this.userLocStatus,
      departmentsStatus: departmentsStatus ?? this.departmentsStatus,
      points: points ?? this.points,
      departments: departments ?? this.departments,
    );
  }
}

const _initialState = _MapViewModelState(
    userLocStatus: RequestStatus.never,
    departmentsStatus: RequestStatus.never,
    points: [],
    departments: []
);

class MapPageViewModel = MapPageViewModelBase with _$MapPageViewModel;

//Банки через репозиторий,
//Поиск через useCase
abstract class MapPageViewModelBase with Store {
  @observable
  var _state = _initialState;
  final _banksRepository = const BanksRepository();

  @computed
  bool get isDepartmentsLoaded => _state.departmentsStatus == RequestStatus.successful;
  @computed
  List<Department> get departments => _state.departments;

  getDepartments() async {
    if(isDepartmentsLoaded) return;
    _setState(_state.copyWith(departmentsStatus: RequestStatus.loading));
    final departments = (await _banksRepository.getDepartments());
    _setState(_state.copyWith(departmentsStatus: RequestStatus.successful, departments: departments));
  }

  @action
  _setState(_MapViewModelState state) => _state = state;

}
