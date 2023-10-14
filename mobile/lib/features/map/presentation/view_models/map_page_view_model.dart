import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/data/banks_repository.dart';
import '../../../banks/entities/cash_machine.dart';
import '../../../banks/entities/department.dart';
import '../../domain/entities/app_location.dart';

part 'map_page_view_model.g.dart';

class FilterParams {
  final bool isCashMachine;
  final List<String> tags;

  const FilterParams({
    required this.isCashMachine,
    required this.tags,
  });
}

final class _MapViewModelState {
  final RequestStatus userLocStatus;
  final RequestStatus filteringStatus;
  final RequestStatus departmentsStatus;
  final List<Department> departments;
  final List<CashMachine> cashMachines;
  final FilterParams filterParams;

//<editor-fold desc="Data Methods">
  const _MapViewModelState({
    required this.userLocStatus,
    required this.filteringStatus,
    required this.departmentsStatus,
    required this.departments,
    required this.cashMachines,
    required this.filterParams,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _MapViewModelState &&
          runtimeType == other.runtimeType &&
          userLocStatus == other.userLocStatus &&
          filteringStatus == other.filteringStatus &&
          departmentsStatus == other.departmentsStatus &&
          departments == other.departments &&
          cashMachines == other.cashMachines &&
          filterParams == other.filterParams);

  @override
  int get hashCode =>
      userLocStatus.hashCode ^
      filteringStatus.hashCode ^
      departmentsStatus.hashCode ^
      departments.hashCode ^
      cashMachines.hashCode ^
      filterParams.hashCode;

  @override
  String toString() {
    return '_MapViewModelState{ userLocStatus: $userLocStatus, filteringStatus: $filteringStatus, departmentsStatus: $departmentsStatus, departments: $departments, cashMachines: $cashMachines, filterParams: $filterParams,}';
  }

  _MapViewModelState copyWith({
    RequestStatus? userLocStatus,
    RequestStatus? filteringStatus,
    RequestStatus? departmentsStatus,
    List<Department>? departments,
    List<CashMachine>? cashMachines,
    FilterParams? filterParams,
  }) {
    return _MapViewModelState(
      userLocStatus: userLocStatus ?? this.userLocStatus,
      filteringStatus: filteringStatus ?? this.filteringStatus,
      departmentsStatus: departmentsStatus ?? this.departmentsStatus,
      departments: departments ?? this.departments,
      cashMachines: cashMachines ?? this.cashMachines,
      filterParams: filterParams ?? this.filterParams,
    );
  }

}

const _initialState = _MapViewModelState(
    userLocStatus: RequestStatus.never,
    departmentsStatus: RequestStatus.never,
    cashMachines: [],
    departments: [],
    filteringStatus: RequestStatus.never,
    filterParams: FilterParams(isCashMachine: false, tags: [])
);

class MapPageViewModel = MapPageViewModelBase with _$MapPageViewModel;

//Банки через репозиторий,
//Поиск через useCase
abstract class MapPageViewModelBase with Store {
  @observable
  var _state = _initialState;
  final _banksRepository = BanksRepository();

  @computed
  bool get isDepartmentsLoaded => _state.departmentsStatus == RequestStatus.successful;
  @computed
  bool get isCashMachinesLoaded => _state.cashMachines.isNotEmpty;
  @computed
  List<Department> get departments => _state.departments;
  @computed
  bool get isShowCashMachines => _state.filterParams.isCashMachine;
  @computed
  List<CashMachine> get cashMachines => _state.cashMachines;

  getDepartments() async {
    if(isDepartmentsLoaded) return;
    _setState(_state.copyWith(departmentsStatus: RequestStatus.loading));
    final departments = (await _banksRepository.getDepartments()).match(
            (l) => _setState(_state.copyWith(departmentsStatus: RequestStatus.error)),
            (r) => _setState(_state.copyWith(departmentsStatus: RequestStatus.successful, departments: r))
    );
  }

  getCashMachines() async {
    if(isCashMachinesLoaded) return;
    (await _banksRepository.getCashMachines()).match(
            (l) => null,
            (r) => _setState(_state.copyWith(cashMachines: r))
    );
  }

  toggleFilter(int index) {
    _setState(_state.copyWith(filterParams: FilterParams(isCashMachine: index == 1, tags: [])));
  }


  @action
  _setState(_MapViewModelState state) => _state = state;

}
