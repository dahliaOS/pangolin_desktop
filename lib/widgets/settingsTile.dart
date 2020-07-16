import 'package:Pangolin/settings/hiveManager.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final List<Widget> children;
  const SettingsTile({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.7976931348623157e+308,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color:
            HiveManager().get("darkMode") ? Colors.grey[900] : Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.children,
          ),
        ),
      ),
    );
  }
}
