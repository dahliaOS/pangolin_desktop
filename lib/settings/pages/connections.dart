import 'dart:ui';

import 'package:Pangolin/settings/hiveManager.dart';
import 'package:Pangolin/widgets/conditionWidget.dart';
import 'package:Pangolin/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

class Connections extends StatefulWidget {
  @override
  _ConnectionsState createState() => _ConnectionsState();
}

class _ConnectionsState extends State<Connections> {
  List<WifiItem> wifiList = new List<WifiItem>();
  List<BluetoothItem> bluetoothList = new List<BluetoothItem>();
  @override
  void initState() {
    // TODO: implement initState
    wifiList.add(new WifiItem("Wifi 1", true));
    wifiList.add(new WifiItem("Wifi 2", false));
    wifiList.add(new WifiItem("Wifi 3", false));
    bluetoothList.add(new BluetoothItem("Some Random Bluetooth Device", false));
    bluetoothList.add(new BluetoothItem(
        "Another Bluetooth Device with a longer name to test if that causes errors",
        false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Connections",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Wifi and Bluetooth",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Wrap(
                          children: [
                            SettingsTile(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Enable Wifi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Switch(
                                      value: HiveManager().get("wifi"),
                                      onChanged: (bool state) {
                                        setState(() {
                                          HiveManager().set("wifi", state);
                                        });
                                      },
                                    )
                                  ],
                                ),
                                CustomConditionWidget(
                                    HiveManager().get("wifi"),
                                    Container(
                                      height: 300,
                                      child: ListView.builder(
                                          itemCount: wifiList.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return ListTile(
                                              leading: Icon(
                                                wifiList[i].icon,
                                                color: wifiList[i].connected
                                                    ? Color(HiveManager().get(
                                                        "accentColorValue"))
                                                    : Colors.grey,
                                              ),
                                              title: Text(
                                                wifiList[i].name,
                                                style: TextStyle(
                                                  color: wifiList[i].connected
                                                      ? Color(HiveManager().get(
                                                          "accentColorValue"))
                                                      : Colors.black,
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
                                          }),
                                    ),
                                    Text("Wifi is Disabled")),
                              ],
                            ),
                            SettingsTile(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Enable Bluetooth",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Switch(
                                      value: HiveManager().get("bluetooth"),
                                      onChanged: (bool state) {
                                        setState(() {
                                          HiveManager().set("bluetooth", state);
                                        });
                                      },
                                    )
                                  ],
                                ),
                                CustomConditionWidget(
                                    HiveManager().get("bluetooth"),
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
                                                    ? Color(HiveManager().get(
                                                        "accentColorValue"))
                                                    : Colors.grey,
                                              ),
                                              title: Text(
                                                bluetoothList[i].name,
                                                style: TextStyle(
                                                  color: bluetoothList[i]
                                                          .connected
                                                      ? Color(HiveManager().get(
                                                          "accentColorValue"))
                                                      : Colors.black,
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
                                    Text("Bluetooth is Disabled")),
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

setConnected(int index, List items) {
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
