/*
Copyright 2019 The dahliaOS Authors
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
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(new WirelessApp());
}

class WirelessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
        canvasColor: const Color(0xFFffffff),
      ),
      home: new WirelessHomePage(),
    );
  }
}

void submitNetwork(String id, String cred) {
  //print(id);
  //print(cred);
  Process.run('network-agent', [id, cred]);
}

class WirelessHomePage extends StatefulWidget {
  WirelessHomePage({Key key}) : super(key: key);
  @override
  _WirelessHomePageState createState() => new _WirelessHomePageState();
}

String id;
String cred;

class _WirelessHomePageState extends State<WirelessHomePage> {
  /// This is the private State class that goes with MyStatefulWidget
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'SSID',
                    ),
                    validator: (ssid) {
                      if (ssid.isEmpty) {
                        return 'Please enter the network\'s SSID';
                      } else {
                        id = ssid;
                        print("id: success");
                      }
                      print("id: return");
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (password) {
                      if (password.isEmpty) {
                        return 'Please enter the network\'s password';
                      } else {
                        cred = password;
                        print("pw: success");
                      }
                      print("pw: return");
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState.validate()) {
                          submitNetwork(id, cred);
                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('Network configured'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                            width: 300,
                            padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                          );

                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Text('Connect'),
                    ),
                  ),
                ],
              ),
            )));
  }
}
