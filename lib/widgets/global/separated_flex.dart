import 'package:flutter/material.dart';

class SeparatedFlex extends StatelessWidget {
  const SeparatedFlex({
    required this.children,
    required this.separator,
    this.axis = Axis.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    super.key,
  });
  final List<Widget> children;
  final Widget separator;
  final Axis axis;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    final separatedChildren = children.isNotEmpty
        ? List<Widget>.generate(children.length * 2 - 1, (index) {
            if (index.isEven) {
              return children[index ~/ 2];
            } else {
              return separator;
            }
          })
        : <Widget>[];

    return Flex(
      direction: axis,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: separatedChildren,
    );
  }
}
