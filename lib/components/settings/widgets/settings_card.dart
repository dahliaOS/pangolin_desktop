import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {

  const SettingsCard({super.key, this.children});
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: Theme.of(context).cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListTileTheme.merge(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 4,
          ),
          child: ListView(
            shrinkWrap: true,
            children: children ?? [],
          ),
        ),
      ),
    );
  }
}
