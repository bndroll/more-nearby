import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/ticket/domain/department_with_times.dart';

part 'create_ticket_store.g.dart';

class _CreateTicketStepperViewModelState {
  final List<DepartmentWithTimes>? requiredDeps;
  final String? chosenDepId;
  final Duration? timeToSetInQueue;
  final int currStepIndex;

  const _CreateTicketStepperViewModelState({
    this.requiredDeps,
    this.chosenDepId,
    this.timeToSetInQueue,
    required this.currStepIndex,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _CreateTicketStepperViewModelState &&
          runtimeType == other.runtimeType &&
          requiredDeps == other.requiredDeps &&
          chosenDepId == other.chosenDepId &&
          timeToSetInQueue == other.timeToSetInQueue &&
          currStepIndex == other.currStepIndex);

  @override
  int get hashCode =>
      requiredDeps.hashCode ^
      chosenDepId.hashCode ^
      timeToSetInQueue.hashCode ^
      currStepIndex.hashCode;

  @override
  String toString() {
    return '_CreateTicketStepperViewModelState{ requiredDeps: $requiredDeps, chosenDepId: $chosenDepId, timeToSetInQueue: $timeToSetInQueue, currStepIndex: $currStepIndex,}';
  }

  _CreateTicketStepperViewModelState copyWith({
    List<DepartmentWithTimes>? requiredDeps,
    String? chosenDepId,
    Duration? timeToSetInQueue,
    int? currStepIndex,
  }) {
    return _CreateTicketStepperViewModelState(
      requiredDeps: requiredDeps ?? this.requiredDeps,
      chosenDepId: chosenDepId ?? this.chosenDepId,
      timeToSetInQueue: timeToSetInQueue ?? this.timeToSetInQueue,
      currStepIndex: currStepIndex ?? this.currStepIndex,
    );
  }

}

const _initialState = _CreateTicketStepperViewModelState(currStepIndex: 0);

class CreateTicketStore = CreateTicketStoreBase with _$CreateTicketStore;

abstract class CreateTicketStoreBase with Store {
  @observable
  var _state = _initialState;

  updateStepper({
    List<DepartmentWithTimes>? requiredDeps,
    String? chosenDepId,
    Duration? timeToSetInQueuee,
}) {
    _setState(_state.copyWith(requiredDeps: requiredDeps, chosenDepId: chosenDepId, timeToSetInQueue: timeToSetInQueuee));
  }

  setStepIndex(int stepIndex) => _setState(_state.copyWith(currStepIndex: stepIndex));

  @computed
  int get currStepIndex => _state.currStepIndex;
  @computed
  List<DepartmentWithTimes> get departments => _state.requiredDeps ?? [];
  @computed
  String get selectedDepartmentId => _state.chosenDepId ?? '0';


  @action
  _setState(_CreateTicketStepperViewModelState state) {
    _state = state;
  }
}