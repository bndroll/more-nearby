import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/entities/department.dart';

part 'create_ticket_stepper_view_model.g.dart';

class _CreateTicketStepperViewModelState {
  final List<Department>? requiredDeps;
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
    List<Department>? requiredDeps,
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

class CreateTicketStepperViewModel = CreateTicketStepperViewModelBase with _$CreateTicketStepperViewModel;

abstract class CreateTicketStepperViewModelBase with Store {
  @observable
  var _state = _initialState;

  updateStepper({
    List<Department>? requiredDeps,
    String? chosenDepId,
    Duration? timeToSetInQueuee,
}) {
    _setState(_state.copyWith(requiredDeps: requiredDeps, chosenDepId: chosenDepId, timeToSetInQueue: timeToSetInQueuee));
  }

  @computed
  int get currStepIndex => _state.currStepIndex;

  @action
  _setState(_CreateTicketStepperViewModelState state) {
    _state = state;
  }
}