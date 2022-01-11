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

import 'dart:io';
import 'package:flutter/material.dart';

//TODO Localize this File

List<String> getNetworks() {
  final ProcessResult result =
      Process.runSync('nmcli', ['--terse', '-e', 'no', 'dev', 'wifi']);
  final String networks = result.stdout as String;
  final List<String> availableNetworks = networks.split("\n");

  //.forEach((network) {network = network.split(':');});

  return availableNetworks;
}

IconData wifiBars(String nmcliIn, String security) {
  if (nmcliIn == "▂▄▆█" || nmcliIn == "▂▄▆_" || nmcliIn == "▂▄__") {
    if (security == "WPA2") {
      return Icons.signal_wifi_4_bar_lock;
    } else {
      return Icons.signal_wifi_4_bar;
    }
  } else {
    return Icons.signal_wifi_bad;
  }
}

Widget networkTile(
  String title,
  bool connected,
  String strength,
  String security,
  BuildContext context,
) {
  return ListTile(
    //the icons suck but thats going to be all that is here until https://github.com/google/material-design-icons/issues/181 is resolved.
    leading: Icon(wifiBars(strength, security)),
    title: Text(title),
    subtitle: connected
        ? const Text("Connected", style: TextStyle(color: Colors.green))
        : const Text("Not connected"),
    onTap: () {
      final passwordController = TextEditingController();
      if (security == "WPA2" || security == "WPA1 WPA2" || security == "") {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Join Wi-Fi network"),
            content: SizedBox(
              height: 125,
              child: Column(
                children: [
                  TextFormField(
                    enabled: false,
                    initialValue: title,
                    decoration: const InputDecoration(
                      //prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'SSID',
                    ),
                  ),
                  Container(
                    height: 15,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    enabled: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Process.runSync("nmcli", [
                    "dev",
                    "wifi",
                    "connect",
                    title,
                    "password",
                    passwordController.text
                  ]);
                  // print("Connecting to: " + title);
                  Navigator.of(ctx).pop();
                  final String networkConnection = Process.runSync('curl', [
                    'https://packages.dahliaos.io/validation.get'
                  ]).stdout.toString().replaceAll('\n', '');
                  if (networkConnection == "true") {
                    final snackBar = SnackBar(
                      content: Text("Successfully connected to $title"),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    final snackBar = SnackBar(
                      content: Text("$title does not have internet access."),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  //TODO: Set state here to indicate connection/fail
                },
                child: const Text("Connect"),
              ),
            ],
          ),
        );
      } else {
        final snackBar = SnackBar(
          content: Text(
            "$title does not use a supported security protocol ($security)",
          ),
        );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    },
  );
}

List<Widget> parseNetworks(BuildContext context) {
  final List<String> input = getNetworks();
  final List<Widget> tiles = [
    Container(
      height: 10,
    ),
  ];
  for (final String network in input) {
    //TODO: Remove channel and frequency duplicate networks
    if (network.split(":").length > 1) {
      //print(network);
      if (network.split(":")[0] == "*") {
        tiles.add(
          networkTile(
            network.split(":")[7],
            true,
            network.split(":")[12],
            network.split(":")[13],
            context,
          ),
        );
      } else {
        tiles.add(
          networkTile(
            network.split(":")[7],
            false,
            network.split(":")[12],
            network.split(":")[13],
            context,
          ),
        );
      }
    }
  }

  return tiles;
}
