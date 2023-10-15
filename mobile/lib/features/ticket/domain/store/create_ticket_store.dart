import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/ticket/data/ticket_dto.dart';
import 'package:vtb_map/features/ticket/domain/department_with_times.dart';

part 'create_ticket_store.g.dart';

class _CreateTicketStepperViewModelState {
  final List<DepartmentWithTimes>? requiredDeps;
  final String? chosenDepId;
  final Duration? timeToSetInQueue;
  final int currStepIndex;
  final TicketDto? ticket;
  final List<String> selectedTagIds;

//<editor-fold desc="Data Methods">
  const _CreateTicketStepperViewModelState({
    this.requiredDeps,
    this.chosenDepId,
    this.timeToSetInQueue,
    required this.currStepIndex,
    this.ticket,
    required this.selectedTagIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _CreateTicketStepperViewModelState &&
          runtimeType == other.runtimeType &&
          requiredDeps == other.requiredDeps &&
          chosenDepId == other.chosenDepId &&
          timeToSetInQueue == other.timeToSetInQueue &&
          currStepIndex == other.currStepIndex &&
          ticket == other.ticket &&
          selectedTagIds == other.selectedTagIds);

  @override
  int get hashCode =>
      requiredDeps.hashCode ^
      chosenDepId.hashCode ^
      timeToSetInQueue.hashCode ^
      currStepIndex.hashCode ^
      ticket.hashCode ^
      selectedTagIds.hashCode;

  @override
  String toString() {
    return '_CreateTicketStepperViewModelState{ requiredDeps: $requiredDeps, chosenDepId: $chosenDepId, timeToSetInQueue: $timeToSetInQueue, currStepIndex: $currStepIndex, ticket: $ticket, selectedTagIds: $selectedTagIds,}';
  }

  _CreateTicketStepperViewModelState copyWith({
    List<DepartmentWithTimes>? requiredDeps,
    String? chosenDepId,
    Duration? timeToSetInQueue,
    int? currStepIndex,
    TicketDto? ticket,
    List<String>? selectedTagIds,
  }) {
    return _CreateTicketStepperViewModelState(
      requiredDeps: requiredDeps ?? this.requiredDeps,
      chosenDepId: chosenDepId ?? this.chosenDepId,
      timeToSetInQueue: timeToSetInQueue ?? this.timeToSetInQueue,
      currStepIndex: currStepIndex ?? this.currStepIndex,
      ticket: ticket ?? this.ticket,
      selectedTagIds: selectedTagIds ?? this.selectedTagIds,
    );
  }

}

const _initialState = _CreateTicketStepperViewModelState(currStepIndex: 0, ticket: null, selectedTagIds: []);

class CreateTicketStore = CreateTicketStoreBase with _$CreateTicketStore;

abstract class CreateTicketStoreBase with Store {
  @observable
  var _state = _initialState;

  updateStepper({
    List<DepartmentWithTimes>? requiredDeps,
    String? chosenDepId,
    Duration? timeToSetInQueuee,
    TicketDto? ticketDto,
    selectedTagIds
}) {
    _setState(_state.copyWith(
        requiredDeps: requiredDeps, chosenDepId: chosenDepId, timeToSetInQueue: timeToSetInQueuee, ticket: ticketDto, selectedTagIds: selectedTagIds));
  }

  setStepIndex(int stepIndex) => _setState(_state.copyWith(currStepIndex: stepIndex));

  @computed
  int get currStepIndex => _state.currStepIndex;
  @computed
  List<DepartmentWithTimes> get departments => _state.requiredDeps ?? [];
  @computed
  String get selectedDepartmentId => _state.chosenDepId ?? '0';
  @computed
  TicketDto? get ticket => _state.ticket;
  @computed
  List<String> get selectedTagsIds => _state.selectedTagIds;

  @action
  _setState(_CreateTicketStepperViewModelState state) {
    _state = state;
  }
}