// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TagStore on TagsStoreBase, Store {
  Computed<List<Tag>>? _$tagsComputed;

  @override
  List<Tag> get tags => (_$tagsComputed ??=
          Computed<List<Tag>>(() => super.tags, name: 'TagsStoreBase.tags'))
      .value;

  late final _$_tagsAtom = Atom(name: 'TagsStoreBase._tags', context: context);

  @override
  List<Tag> get _tags {
    _$_tagsAtom.reportRead();
    return super._tags;
  }

  @override
  set _tags(List<Tag> value) {
    _$_tagsAtom.reportWrite(value, super._tags, () {
      super._tags = value;
    });
  }

  late final _$TagsStoreBaseActionController =
      ActionController(name: 'TagsStoreBase', context: context);

  @override
  dynamic setTags(List<Tag> tags) {
    final _$actionInfo = _$TagsStoreBaseActionController.startAction(
        name: 'TagsStoreBase.setTags');
    try {
      return super.setTags(tags);
    } finally {
      _$TagsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tags: ${tags}
    ''';
  }
}
