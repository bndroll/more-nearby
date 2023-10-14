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
  Computed<List<Department>>? _$departmentsComputed;

  @override
  List<Department> get departments => (_$departmentsComputed ??=
          Computed<List<Department>>(() => super.departments,
              name: 'MapPageViewModelBase.departments'))
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
departments: ${departments}
    ''';
  }
}
