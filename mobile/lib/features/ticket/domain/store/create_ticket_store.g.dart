// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ticket_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTicketStore on CreateTicketStoreBase, Store {
  Computed<int>? _$currStepIndexComputed;

  @override
  int get currStepIndex =>
      (_$currStepIndexComputed ??= Computed<int>(() => super.currStepIndex,
              name: 'CreateTicketStoreBase.currStepIndex'))
          .value;

  late final _$_stateAtom =
      Atom(name: 'CreateTicketStoreBase._state', context: context);

  @override
  _CreateTicketStepperViewModelState get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(_CreateTicketStepperViewModelState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$CreateTicketStoreBaseActionController =
      ActionController(name: 'CreateTicketStoreBase', context: context);

  @override
  dynamic _setState(_CreateTicketStepperViewModelState state) {
    final _$actionInfo = _$CreateTicketStoreBaseActionController.startAction(
        name: 'CreateTicketStoreBase._setState');
    try {
      return super._setState(state);
    } finally {
      _$CreateTicketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currStepIndex: ${currStepIndex}
    ''';
  }
}
