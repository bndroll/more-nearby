// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ticket_stepper_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTicketStepperViewModel
    on CreateTicketStepperViewModelBase, Store {
  Computed<int>? _$currStepIndexComputed;

  @override
  int get currStepIndex =>
      (_$currStepIndexComputed ??= Computed<int>(() => super.currStepIndex,
              name: 'CreateTicketStepperViewModelBase.currStepIndex'))
          .value;

  late final _$_stateAtom =
      Atom(name: 'CreateTicketStepperViewModelBase._state', context: context);

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

  late final _$CreateTicketStepperViewModelBaseActionController =
      ActionController(
          name: 'CreateTicketStepperViewModelBase', context: context);

  @override
  dynamic _setState(_CreateTicketStepperViewModelState state) {
    final _$actionInfo = _$CreateTicketStepperViewModelBaseActionController
        .startAction(name: 'CreateTicketStepperViewModelBase._setState');
    try {
      return super._setState(state);
    } finally {
      _$CreateTicketStepperViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currStepIndex: ${currStepIndex}
    ''';
  }
}
