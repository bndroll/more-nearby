import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobx/mobx.dart';
import 'package:vtb_map/core/di/locator.dart';
import 'package:vtb_map/core/utils/utility_types/request_status.dart';
import 'package:vtb_map/features/banks/domain/stores/tags_store.dart';
import 'package:vtb_map/features/banks/domain/use_cases/get_all_tags_use_case.dart';
import '../../entities/tag.dart';

part 'tags_view_model.g.dart';

class _TagsViewModelState {
  final RequestStatus getTagsStatus;
  final List<String> selectedTagsIds;

  const _TagsViewModelState({
    required this.getTagsStatus,
    required this.selectedTagsIds,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is _TagsViewModelState &&
          runtimeType == other.runtimeType &&
          getTagsStatus == other.getTagsStatus &&
          selectedTagsIds == other.selectedTagsIds);

  @override
  int get hashCode =>
      getTagsStatus.hashCode ^selectedTagsIds.hashCode;

  @override
  String toString() {
    return '_TagsViewModelState{ getTagsStatus: $getTagsStatus,selectedTagsIds: $selectedTagsIds,}';
  }

  _TagsViewModelState copyWith({
    RequestStatus? getTagsStatus,
    List<String>? selectedTagsIds,
  }) {
    return _TagsViewModelState(
      getTagsStatus: getTagsStatus ?? this.getTagsStatus,
      selectedTagsIds: selectedTagsIds ?? this.selectedTagsIds,
    );
  }
}

const _initialState = _TagsViewModelState(getTagsStatus: RequestStatus.never, selectedTagsIds: []);

class TagsViewModel = TagsViewModelBase with _$TagsViewModel;

abstract class TagsViewModelBase with Store{
  @observable
  _TagsViewModelState _state = _initialState;
  final _getTagsUseCase = GetAllTagsUseCase();

  @computed
  List<Tag> get tags => locator<TagStore>().tags;
  @computed
  bool get isLoaded => _state.getTagsStatus == RequestStatus.successful;
  @computed
  List<String> get selectedTagsIds => _state.selectedTagsIds;


  loadAllTags() async {
    _setState(_state.copyWith(getTagsStatus: RequestStatus.loading));
    (await _getTagsUseCase.execute(null))
        .match(
            (l) => _setState(_state.copyWith(getTagsStatus: RequestStatus.error)),
            (r) => _setState(_state.copyWith(getTagsStatus: RequestStatus.successful))
    );
  }

  selectTag(String tagId) {
    final isSecondary = _state.selectedTagsIds.where((stagId) => stagId == tagId).isNotEmpty;
    if(isSecondary) {
      _setState(_state.copyWith(selectedTagsIds: _state.selectedTagsIds
          .filter((t) => t != tagId)
          .toList())
      );
    }
    else {
      _setState(_state.copyWith(selectedTagsIds: [tagId, ...selectedTagsIds]));
    }
  }

  @action
  _setState(_TagsViewModelState state) => _state = state;
}