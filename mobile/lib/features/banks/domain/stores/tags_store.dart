import 'package:mobx/mobx.dart';
import '../../entities/tag.dart';

part 'tags_store.g.dart';

class TagStore = TagsStoreBase with _$TagStore;

abstract class TagsStoreBase with Store {
  @observable
  List<Tag> _tags = [];

  @computed
  List<Tag> get tags => _tags;

  @action
  setTags(List<Tag> tags) => _tags = tags;
}