// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ticket_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTicketViewModel on CreateTicketViewModelBase, Store {
  Computed<List<Tag>>? _$tagsComputed;

  @override
  List<Tag> get tags =>
      (_$tagsComputed ??= Computed<List<Tag>>(() => super.tags,
              name: 'CreateTicketViewModelBase.tags'))
          .value;
  Computed<List<String>>? _$selectedTagsIdsComputed;

  @override
  List<String> get selectedTagsIds => (_$selectedTagsIdsComputed ??=
          Computed<List<String>>(() => super.selectedTagsIds,
              name: 'CreateTicketViewModelBase.selectedTagsIds'))
      .value;
  Computed<bool>? _$isCreatedComputed;

  @override
  bool get isCreated =>
      (_$isCreatedComputed ??= Computed<bool>(() => super.isCreated,
              name: 'CreateTicketViewModelBase.isCreated'))
          .value;

  late final _$_stateAtom =
      Atom(name: 'CreateTicketViewModelBase._state', context: context);

  @override
  _CreateTicketViewModelState get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(_CreateTicketViewModelState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$CreateTicketViewModelBaseActionController =
      ActionController(name: 'CreateTicketViewModelBase', context: context);

  @override
  dynamic _setState(_CreateTicketViewModelState state) {
    final _$actionInfo = _$CreateTicketViewModelBaseActionController
        .startAction(name: 'CreateTicketViewModelBase._setState');
    try {
      return super._setState(state);
    } finally {
      _$CreateTicketViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tags: ${tags},
selectedTagsIds: ${selectedTagsIds},
isCreated: ${isCreated}
    ''';
  }
}
