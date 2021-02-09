import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OverviewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          hoverColor: Theme.of(context).cardColor.withOpacity(0.5),
          mouseCursor: SystemMouseCursors.click,
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(12),
            child:
                Center(child: Icon(Icons.fullscreen_exit_outlined, size: 20)),
          ),
        ),
      ),
    );
  }
}
