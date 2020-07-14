import 'dart:ui';

import 'package:Pangolin/settings/hiveManager.dart';
import 'package:flutter/material.dart';

class Blur extends StatefulWidget {
  Widget child;
  BorderRadius borderRadius;
  Blur({Key key, @required this.child, borderRadius}) : super(key: key);

  @override
  _BlurState createState() => _BlurState();
}

class _BlurState extends State<Blur> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius == null
          ? BorderRadius.circular(0)
          : widget.borderRadius,
      child: BackdropFilter(
        filter: HiveManager().get("enableBlur")
            ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)
            : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: widget.child,
      ),
    );
  }
}
