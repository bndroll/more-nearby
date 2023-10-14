import 'package:flutter/material.dart';

class TagView extends StatelessWidget {
  const TagView({Key? key, required this.tagTitle, required this.isSelected}) : super(key: key);

  final String tagTitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tagTitle,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
              fontSize: 14,
              // fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w400,
              height: 0.14,
            ),
          ),
        ],
      ),
    );
  }
}
