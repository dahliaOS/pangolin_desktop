import 'package:flutter/material.dart';

class ApplicationButton extends StatelessWidget {
  final Image? icon;
  final String? name;
  ApplicationButton({@required this.icon, @required this.name});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 32,
        height: 32,
        child: Tooltip(
          message: "$name",
          child: icon,
        ));
  }
}
