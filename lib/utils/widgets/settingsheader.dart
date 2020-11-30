import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  final String heading;

  const SettingsHeader({@required this.heading});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 5),
          child: Text(this.heading,
              style: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
