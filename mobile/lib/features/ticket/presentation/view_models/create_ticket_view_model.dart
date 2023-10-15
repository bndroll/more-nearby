import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/domain/stores/tags_store.dart';
import 'package:vtb_map/features/ticket/data/ticket_repository.dart';
import 'package:vtb_map/features/ticket/domain/store/create_ticket_store.dart';
import 'package:vtb_map/features/ticket/domain/use_cases/load_required_departments_use_case.dart';

import '../../../../core/utils/utility_types/failure.dart';
import '../../../banks/entities/tag.dart';
part 'create_ticket_view_model.g.dart';

class _CreateTicketViewModelState {
  final RequestStatus createTicketStatus;
  final List<String> selectedTagIds;
  final Failure? failure;

  const _CreateTicketViewModelState({
    required this.createTicketStatus,
    required this.selectedTagIds,
    this.failure,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _CreateTicketViewModelState &&
          runtimeType == other.runtimeType &&
          createTicketStatus == other.createTicketStatus &&
          selectedTagIds == other.selectedTagIds &&
          failure == other.failure);

  @override
  int get hashCode =>
      createTicketStatus.hashCode ^ selectedTagIds.hashCode ^ failure.hashCode;

  @override
  String toString() {
    return '_CreateTicketViewModelState{ createTicketStatus: $createTicketStatus, selectedTagIds: $selectedTagIds, failure: $failure,}';
  }

  _CreateTicketViewModelState copyWith({
    RequestStatus? createTicketStatus,
    List<String>? selectedTagIds,
    Failure? failure,
  }) {
    return _CreateTicketViewModelState(
      createTicketStatus: createTicketStatus ?? this.createTicketStatus,
      selectedTagIds: selectedTagIds ?? this.selectedTagIds,
      failure: failure ?? this.failure,
    );
  }
}

const _initialState = _CreateTicketViewModelState(createTicketStatus: RequestStatus.never, selectedTagIds: []);

class CreateTicketViewModel = CreateTicketViewModelBase with _$CreateTicketViewModel;

abstract class CreateTicketViewModelBase with Store{
  @observable
  _CreateTicketViewModelState _state = _initialState;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _loadRequiredDepartmentsUseCase = LoadRequiredDepartmentUseCase();
  final _createTicketStore = locator<CreateTicketStore>();

  @computed
  List<Tag> get tags => locator<TagStore>().tags;
  @computed
  List<String> get selectedTagsIds => _state.selectedTagIds;
  @computed
  bool get isCreated => _state.createTicketStatus == RequestStatus.successful;
  TextEditingController get nameController => _nameController;
  TextEditingController get dateController => _dateController;

  onTagTap(String tagId) {
    final isSecondary = _state.selectedTagIds.where((stagId) => stagId == tagId).isNotEmpty;
    if(isSecondary) {
      _setState(_state.copyWith(selectedTagIds: _state.selectedTagIds
          .filter((t) => t != tagId)
          .toList())
      );
    }
    else {
      _setState(_state.copyWith(selectedTagIds: [tagId, ...selectedTagsIds]));
    }
    _createTicketStore.updateStepper(selectedTagIds: _state.selectedTagIds);

  }

  goChooseDepartment() async {
    _setState(_state.copyWith(createTicketStatus: RequestStatus.loading));
    final res = await _loadRequiredDepartmentsUseCase.execute(_state.selectedTagIds);
    _setState(_state.copyWith(createTicketStatus: RequestStatus.successful));
  }

  @action
  _setState(_CreateTicketViewModelState state) {
    _state = state;
  }
}