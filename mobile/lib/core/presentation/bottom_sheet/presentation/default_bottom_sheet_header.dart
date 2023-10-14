import 'package:flutter/material.dart';

class DefaultBottomSheetHeader extends StatelessWidget {
  const DefaultBottomSheetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        height: 5,
        width: 96,
      ),
    );
  }
}

