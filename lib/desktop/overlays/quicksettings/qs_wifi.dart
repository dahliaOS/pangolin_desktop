import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/widgets/qs_appbar.dart';
import 'package:provider/provider.dart';

class QsWifi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: QsAppBar(
        title: "Wi-Fi",
        value: _pref.wifi,
        onTap: () {
          _pref.wifi = !_pref.wifi;
        },
        /* elevation: 0,
        toolbarHeight: 48,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.4),
        centerTitle: true,
        title: Text("Wi-Fi"),
        actions: [
          Switch(value: true, onChanged: (val) {}),
          SizedBox(
            width: 8,
          ),
        ], */
      ),
    );
  }
}
