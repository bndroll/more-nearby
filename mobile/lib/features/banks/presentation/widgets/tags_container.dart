import 'package:flutter/material.dart';
import 'package:vtb_map/features/banks/presentation/widgets/tag_view.dart';

import '../../entities/tag.dart';

class TagsContainer extends StatelessWidget {
  const TagsContainer({
    Key? key,
    this.isLoading = false,
    required this.tags,
    required this.selectedTagsIds,
    this.onTagTap
  }) : super(key: key);

  factory TagsContainer.loading() => const TagsContainer(tags: [], selectedTagsIds: [], isLoading: true);

  final bool isLoading;
  final List<Tag> tags;
  final List<String> selectedTagsIds;
  final void Function(String tagId)? onTagTap;

  @override
  Widget build(BuildContext context) {
    if(isLoading) return const Center(child: CircularProgressIndicator());
    return  Wrap(
      spacing: 4,
      runSpacing: 4,
      children: tags
          .map((tag) => InkWell(
            onTap: onTagTap != null ? (() => onTagTap!(tag.id)) : null,
            child: TagView(
              tagTitle: tag.title,
              isSelected: selectedTagsIds.where((sTagId) => sTagId == tag.id).isNotEmpty),
          )
          )
          .toList(),
    );
  }
}
