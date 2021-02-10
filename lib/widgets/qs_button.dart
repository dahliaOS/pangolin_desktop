import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class QuickSettingsButton extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final IconData? icon;
  final Color? color;

  const QuickSettingsButton({this.title, this.onTap, this.icon, this.color});
  @override
  Widget build(BuildContext context) {
    final _data = context.watch<PreferenceProvider>();
    return Column(
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            child: CircleAvatar(
              backgroundColor: color ?? Color(_data.accentColor),
              child: Icon(
                icon ?? Icons.error,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          title ?? "error",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
