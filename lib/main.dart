import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/desktop/desktop.dart';
import 'package:pangolin/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  await DatabaseManager.initialseDatabase();
  PreferenceProvider();
  DateTimeManager.initialiseScheduler();
  DateTimeManager.formatTime();
  DateTimeManager.setDateFormat("yMd");
  DateTimeManager.formatDate();
  runApp(ChangeNotifierProvider<PreferenceProvider>.value(
      value: PreferenceProvider(),
      builder: (context, child) {
        return Pangolin();
      }));
}

class Pangolin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Desktop(),
      theme: theme(context),
    );
  }
}
