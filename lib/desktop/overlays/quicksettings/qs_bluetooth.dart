import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/widgets/qs_appbar.dart';
import 'package:provider/provider.dart';

class QsBluetooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pref = context.watch<PreferenceProvider>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: QsAppBar(
        title: "Bluetooth",
        value: _pref.bluetooth,
        onTap: () {
          _pref.bluetooth = !_pref.bluetooth;
        },
        /* onTap: () {
          _pref.bluetooth = !_pref.bluetooth;
        }, */
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
