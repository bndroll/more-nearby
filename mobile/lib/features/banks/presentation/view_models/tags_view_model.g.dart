// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TagsViewModel on TagsViewModelBase, Store {
  Computed<List<Tag>>? _$tagsComputed;

  @override
  List<Tag> get tags => (_$tagsComputed ??=
          Computed<List<Tag>>(() => super.tags, name: 'TagsViewModelBase.tags'))
      .value;
  Computed<bool>? _$isLoadedComputed;

  @override
  bool get isLoaded =>
      (_$isLoadedComputed ??= Computed<bool>(() => super.isLoaded,
              name: 'TagsViewModelBase.isLoaded'))
          .value;
  Computed<List<String>>? _$selectedTagsIdsComputed;

  @override
  List<String> get selectedTagsIds => (_$selectedTagsIdsComputed ??=
          Computed<List<String>>(() => super.selectedTagsIds,
              name: 'TagsViewModelBase.selectedTagsIds'))
      .value;

  late final _$_stateAtom =
      Atom(name: 'TagsViewModelBase._state', context: context);

  @override
  _TagsViewModelState get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(_TagsViewModelState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$TagsViewModelBaseActionController =
      ActionController(name: 'TagsViewModelBase', context: context);

  @override
  dynamic _setState(_TagsViewModelState state) {
    final _$actionInfo = _$TagsViewModelBaseActionController.startAction(
        name: 'TagsViewModelBase._setState');
    try {
      return super._setState(state);
    } finally {
      _$TagsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tags: ${tags},
isLoaded: ${isLoaded},
selectedTagsIds: ${selectedTagsIds}
    ''';
  }
}
