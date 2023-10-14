import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vtb_map/features/banks/presentation/view_models/tags_view_model.dart';
import 'package:vtb_map/features/banks/presentation/widgets/tags_container.dart';

class FilterDepartmentsPage extends StatefulWidget {
  const FilterDepartmentsPage({Key? key}) : super(key: key);

  @override
  State<FilterDepartmentsPage> createState() => _FilterDepartmentsPageState();
}

class _FilterDepartmentsPageState extends State<FilterDepartmentsPage> {

  final _tagsViewModel = TagsViewModel();

  @override
  void initState() {
    _tagsViewModel.loadAllTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) => TagsContainer(
        tags: _tagsViewModel.tags,
        isLoading: !_tagsViewModel.isLoaded,
        onTagTap: _tagsViewModel.selectTag,
        selectedTagsIds: _tagsViewModel.selectedTagsIds
    ));
  }
}
