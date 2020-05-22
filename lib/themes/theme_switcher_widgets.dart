import 'package:flutter/material.dart';

class BrightnessSwitcherDialog extends StatelessWidget {
  const BrightnessSwitcherDialog({Key key, this.onSelectedTheme})
      : super(key: key);

  final ValueChanged<Brightness> onSelectedTheme;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select Theme'),
      children: <Widget>[
        RadioListTile<Brightness>(
          value: Brightness.light,
          groupValue: Theme.of(context).brightness,
          onChanged: (Brightness value) {
            onSelectedTheme(Brightness.light);
          },
          title: const Text('Light'),
        ),
        RadioListTile<Brightness>(
          value: Brightness.dark,
          groupValue: Theme.of(context).brightness,
          onChanged: (Brightness value) {
            onSelectedTheme(Brightness.dark);
          },
          title: const Text('Spooky  👻'),
        ),
      ],
    );
  }
}
