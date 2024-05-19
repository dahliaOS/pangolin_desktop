// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:zenit_ui/zenit_ui.dart';

class ZenitSliderOld extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  final Color? activeColor;
  // TODO: implement divisions
  final double? height;
  final int? divisions;
  final String? label;
  final Color? trackColor;
  final MouseCursor? mouseCursor;

  const ZenitSliderOld({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.height,
    this.divisions,
    this.label,
    this.trackColor,
    this.mouseCursor,
  });

  @override
  _ZenitSliderOldState createState() => _ZenitSliderOldState();
}

class _ZenitSliderOldState extends State<ZenitSliderOld> {
  @override
  Widget build(BuildContext context) {
    // Implement the build method for your stateful widget
    return Container(); // Example implementation
  }
}

extension CreateZenitThemeSurfaceColor on ThemeData {
  Color get surfaceColor {
    // Define how to get the surface color here
    return const Color.fromARGB(
        255, 175, 50, 0); // Return a default color value
  }
}

extension CreateZenitThemeSurface on ThemeData {
  Color get createZenitTheme {
    return surfaceColor;
  }
}

extension CreateZenitThemeForegroundColor on ThemeData {
  Color get foregroundColor {
    // Define how to get the foregroundColor color here
    return const Color.fromARGB(
        255, 255, 72, 0); // Return a default color value
  }
}

extension CreateZenitThemeForeground on ThemeData {
  Color get createZenitTheme {
    return foregroundColor;
  }
}

//155, 0, 0, 0
