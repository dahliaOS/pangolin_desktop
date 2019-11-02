import 'package:flutter/widgets.dart';

/// This Inherited Widget will allow easy reference to all constants.
/// Constants which are used repeatedly in the code should be declared here and used through this Widget.
/// 
/// Use as: `Constants.of(context).constantStringExample`
/// 
/// Using this reduces memory consumption & is performant with complexity O(1).
class Constants extends InheritedWidget {
  static Constants of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(Constants);

  const Constants({Widget child, Key key})
      : super(key: key, child: child);
  final String constantStringExample = 'An example';

  @override
  bool updateShouldNotify(Constants old) => false;
}
