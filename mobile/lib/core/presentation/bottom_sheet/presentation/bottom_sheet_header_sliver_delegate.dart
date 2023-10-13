import 'package:flutter/material.dart';

import 'default_bottom_sheet_header.dart';

class BottomSheetHeaderSliverDelegate extends SliverPersistentHeaderDelegate {

  final double height;

  const BottomSheetHeaderSliverDelegate({
    required this.height,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      height: height,
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.srcIn,
        color: Theme.of(context).colorScheme.background
      ),
      child: const DefaultBottomSheetHeader(),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }


}