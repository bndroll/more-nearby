import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../presentation/bottom_sheet_header_sliver_delegate.dart';

void showDefaultBottomSheet(
  BuildContext context,
  List<Widget> children, {
  double minHeight = 0,
  double maxHeight = 0.8,
  double initHeight = 0.8,
  useRootNavigator = true,
  List<double> anchors = const [0, 0.8],
      bool isDismissible = true,
      bool isModal = true,
      GlobalKey? bottomSheetKey,
}) =>
    showFlexibleBottomSheet(
      context: context,
      minHeight: minHeight,
      maxHeight: maxHeight,
      isDismissible: isDismissible,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))
      ),
      useRootNavigator: useRootNavigator,
      bottomSheetColor: Theme.of(context).colorScheme.background,
      initHeight: initHeight,
      anchors: anchors,
      isModal: isModal,

      builder:
          (_, ScrollController scrollController, double bottomSheetOffset) {
            return CustomScrollView(
              key: bottomSheetKey,
              shrinkWrap: true,
              controller: scrollController,
              slivers: [
                const SliverPersistentHeader(
                    pinned: true,
                    delegate: BottomSheetHeaderSliverDelegate(height: 25)
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [...children],
                  ),
                )
              ],
            );
          }
    );
