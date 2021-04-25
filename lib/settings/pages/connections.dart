/*
Copyright 2021 The dahliaOS Authors
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/settings/settings.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:provider/provider.dart';

class Connections extends StatelessWidget {
  List<WifiItem> wifiList = List<WifiItem>.empty(growable: true);
  List<BluetoothItem> bluetoothList = List<BluetoothItem>.empty(growable: true);
  @override
  void initState() {
    wifiList.add(WifiItem("Wi-Fi 1", true));
    wifiList.add(WifiItem("Wi-Fi 2", false));
    wifiList.add(WifiItem("Wi-Fi 3", false));
    bluetoothList.add(BluetoothItem("Some Random Bluetooth Device", false));
    bluetoothList.add(BluetoothItem(
        "Another Bluetooth Device with a longer name to test if that causes errors",
        false));
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingsTitle("Connections"),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsHeader(heading: "Wi-Fi and Bluetooth"),
                    SettingsTile(
                      children: [
                        Wrap(
                          children: [
                            Column(
                              children: [
                                SwitchListTile(
                                  onChanged: (bool value) {
                                    _data.wifi = !_data.wifi;
                                  },
                                  value: _data.wifi,
                                  title: Text("Enable Wi-Fi"),
                                ),
                                /* CustomConditionWidget(
                                    DatabaseManager.get("wifi"),
                                    Container(
                                        height: 300,
                                        child:
                                            /* ListView.builder(
                                          itemCount: wifiList.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return ListTile(
                                              leading: Icon(
                                                wifiList[i].icon,
                                                color: wifiList[i].connected
                                                    ? Color(DatabaseManager.get(
                                                        "accentColorValue"))
                                                    : Colors.grey,
                                              ),
                                              title: Text(
                                                wifiList[i].name,
                                                style: TextStyle(
                                                  color: wifiList[i].connected
                                                      ? Color(DatabaseManager.get(
                                                          "accentColorValue"))
                                                      : (DatabaseManager.get(
                                                              "darkMode")
                                                          ? Colors.white
                                                          : Colors.grey[900]),
                                                ),
                                              ),
                                              subtitle: Text(
                                                  wifiList[i].connected
                                                      ? "Connected"
                                                      : "Disconnected"),
                                              onTap: () {
                                                setState(() {
                                                  setConnected(i, wifiList);
                                                });
                                              },
                                            );
                                          }),*/
                                            new ClipRect(
                                                child: new WirelessApp())),
                                SizedBox.shrink()), */
                              ],
                            ),
                            Divider(),
                            Column(
                              children: [
                                SwitchListTile(
                                  onChanged: (bool value) {
                                    _data.bluetooth = !_data.bluetooth;
                                  },
                                  value: _data.bluetooth,
                                  title: Text("Enable Bluetooth"),
                                ),
                                /* CustomConditionWidget(
                                    DatabaseManager.get("bluetooth"),
                                    Container(
                                      height: 300,
                                      child: ListView.builder(
                                          itemCount: bluetoothList.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return ListTile(
                                              leading: Icon(
                                                bluetoothList[i].icon,
                                                color: bluetoothList[i]
                                                        .connected
                                                    ? Color(DatabaseManager.get(
                                                        "accentColorValue"))
                                                    : Colors.grey,
                                              ),
                                              title: Text(
                                                bluetoothList[i].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: bluetoothList[i]
                                                          .connected
                                                      ? Color(DatabaseManager.get(
                                                          "accentColorValue"))
                                                      : (DatabaseManager.get(
                                                              "darkMode")
                                                          ? Colors.white
                                                          : Colors.grey[900]),
                                                ),
                                              ),
                                              subtitle: Text(
                                                  bluetoothList[i].connected
                                                      ? "Connected"
                                                      : "Disconnected"),
                                              onTap: () {
                                                setState(() {
                                                  setConnected(
                                                      i, bluetoothList);
                                                });
                                              },
                                            );
                                          }),
                                    ),
                                    SizedBox.shrink()), */
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WifiItem {
  String name;
  IconData icon = Icons.wifi;
  bool connected;

  WifiItem(this.name, this.connected);
}

class BluetoothItem {
  String name;
  IconData icon = Icons.bluetooth;
  bool connected;

  BluetoothItem(this.name, this.connected);
}

void setConnected(int index, List items) {
  switch (items[index].connected) {
    case true:
      for (int _i = 0; _i < items.length; _i++) {
        items[_i].connected = false;
      }
      items[index].connected = false;
      break;
    case false:
      for (int _i = 0; _i < items.length; _i++) {
        items[_i].connected = false;
      }
      items[index].connected = true;
      break;
  }
}
