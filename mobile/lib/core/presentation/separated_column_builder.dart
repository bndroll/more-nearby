import 'package:flutter/material.dart';

class SeparatedListBuilder extends StatelessWidget {
  const SeparatedListBuilder({Key? key, required this.itemCount, required this.itemBuilder, required this.separatorBuilder}) : super(key: key);

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;

  List<Widget> _buildChildren(BuildContext context) {
    return [for(var i = 0; i < itemCount * 2 - 1; i++)
      if(i.isEven) itemBuilder(context, (i / 2).round())
      else separatorBuilder(context, (i / 2).floor() + 1)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildChildren(context),
    );
  }
}