import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';

class PangolinWindowSurface extends StatelessWidget {
  const PangolinWindowSurface();

  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      useAccentBG: true,
      useBlur: true,
      useSystemOpacity: true,
    );
  }
}
