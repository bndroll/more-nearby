// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_page_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MapPageViewModel on MapPageViewModelBase, Store {
  Computed<bool>? _$isDepartmentsLoadedComputed;

  @override
  bool get isDepartmentsLoaded => (_$isDepartmentsLoadedComputed ??=
          Computed<bool>(() => super.isDepartmentsLoaded,
              name: 'MapPageViewModelBase.isDepartmentsLoaded'))
      .value;
  Computed<bool>? _$isCashMachinesLoadedComputed;

  @override
  bool get isCashMachinesLoaded => (_$isCashMachinesLoadedComputed ??=
          Computed<bool>(() => super.isCashMachinesLoaded,
              name: 'MapPageViewModelBase.isCashMachinesLoaded'))
      .value;
  Computed<List<Department>>? _$departmentsComputed;

  @override
  List<Department> get departments => (_$departmentsComputed ??=
          Computed<List<Department>>(() => super.departments,
              name: 'MapPageViewModelBase.departments'))
      .value;
  Computed<bool>? _$isShowCashMachinesComputed;

  @override
  bool get isShowCashMachines => (_$isShowCashMachinesComputed ??=
          Computed<bool>(() => super.isShowCashMachines,
              name: 'MapPageViewModelBase.isShowCashMachines'))
      .value;
  Computed<List<CashMachine>>? _$cashMachinesComputed;

  @override
  List<CashMachine> get cashMachines => (_$cashMachinesComputed ??=
          Computed<List<CashMachine>>(() => super.cashMachines,
              name: 'MapPageViewModelBase.cashMachines'))
      .value;

  late final _$_stateAtom =
      Atom(name: 'MapPageViewModelBase._state', context: context);

  @override
  _MapViewModelState get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(_MapViewModelState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$MapPageViewModelBaseActionController =
      ActionController(name: 'MapPageViewModelBase', context: context);

  @override
  dynamic _setState(_MapViewModelState state) {
    final _$actionInfo = _$MapPageViewModelBaseActionController.startAction(
        name: 'MapPageViewModelBase._setState');
    try {
      return super._setState(state);
    } finally {
      _$MapPageViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDepartmentsLoaded: ${isDepartmentsLoaded},
isCashMachinesLoaded: ${isCashMachinesLoaded},
departments: ${departments},
isShowCashMachines: ${isShowCashMachines},
cashMachines: ${cashMachines}
    ''';
  }
}
