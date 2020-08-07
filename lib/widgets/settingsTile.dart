import 'package:Pangolin/settings/hiveManager.dart';
import 'package:Pangolin/themes/customization_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTile extends StatelessWidget {
  final List<Widget> children;
  const SettingsTile({Key key, @required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomizationNotifier>(
      builder: (context, notifier, child) => SizedBox(
        width: 1.7976931348623157e+308,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: notifier.darkTheme ? Colors.grey[900] : Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: this.children,
            ),
          ),
        ),
      ),
    );
  }
}
