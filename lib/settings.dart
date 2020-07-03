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

void main() {
  runApp(
    MaterialApp(
      home: Settings(),
    ),
  );
}

class Settings extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: SettingsPage(title: appTitle),
    );
  }
}


Container buildSettings(IconData icon, String title, Color color) {
  return new Container(
                height: 30,
                margin: EdgeInsets.only(left:15,top:15,),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(icon,
                          size: 20, color: color)),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(title,
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff000000))))
                ]));
}

Container buildSettingsHeader(String title) {
  return new Container(
            padding: const EdgeInsets.only(top:25, left:15,),
            alignment: Alignment.centerLeft,
            child:
            Text(title,
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff222222),
                            fontWeight: FontWeight.w600)));
}
        final TextEditingController editingController = new TextEditingController();

class SettingsPage extends StatelessWidget {
  final String title;

  SettingsPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: 
        
        
        



          Column(children: [
            Container(
                height: 50,
                color: Color(0xffeeeeee),
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.settings, color: Color(0xffff3D00))),
                  Text('Settings',
                      style:
                          TextStyle(fontSize: 20, color: Color(0xff222222)))
                ])),
          



 new 
 Expanded(child: 
 SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: new Column(children: <Widget>[
Container(
color: Color(0xffeeeeee),
child:
 Container(
        
      padding: new EdgeInsets.only(left: 10,right: 10,top: 0),
      margin: new EdgeInsets.only(bottom: 10.0),
      child: new Material(
          color: Colors.white,
        borderRadius: const BorderRadius.all(const Radius.circular(25)),
        elevation: 5.0,
        child: new Container(
            width:700,
          height: 35.0,
          margin: new EdgeInsets.only(left: 10,right:5),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    style: new TextStyle(color: Colors.grey[900],fontSize: 15,),
                    maxLines: 1,
                    decoration: new InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey[900],fontSize: 15,),
                      icon: Icon(Icons.search, color: const Color(0xFFff3d00),),
                      hintText: 'Search settings...',
                      border: InputBorder.none
                    ),
                    onSubmitted: null,
                    controller: editingController,
                  )
              )
            ],
          ),
        ),
      ),
    ),
),

buildSettingsHeader('WIRELESS & NETWORKS'),

buildSettings(Icons.network_wifi, 'Wi-Fi', Colors.cyan[600]),
buildSettings(Icons.bluetooth, 'Bluetooth', Colors.blue[600]),
buildSettings(Icons.sim_card, 'Data', Colors.red[500]),
buildSettings(Icons.settings_ethernet, 'Wired', Colors.amber[500]),

buildSettingsHeader('DEVICE'),

buildSettings(Icons.brightness_medium, 'Display', Colors.red[600]),
buildSettings(Icons.keyboard, 'Input', Colors.blue[800]),
buildSettings(Icons.usb, 'Ports', Colors.orange[500]),
buildSettings(Icons.volume_up, 'Sound', Colors.teal[500]),
buildSettings(Icons.storage, 'Storage', Colors.blue[500]),
buildSettings(Icons.power, 'Power', Colors.amber[500]),
buildSettings(Icons.devices, 'Devices', Colors.blue[800]),


buildSettingsHeader('SYSTEM'),

buildSettings(Icons.system_update, 'Updates', Colors.deepOrange[500]),
buildSettings(Icons.palette, 'Appearance', Colors.green[500]),
buildSettings(Icons.apps, 'Applications', Colors.purple[800]),
buildSettings(Icons.person, 'Users', Colors.cyan[800]),
buildSettings(Icons.visibility_off, 'Privacy', Colors.pink[500]),
buildSettings(Icons.access_time, 'Time', Colors.deepOrange[500]),
buildSettings(Icons.security, 'Security', Colors.blue[500]),
buildSettings(Icons.domain, 'Enterprise Enrollment', Colors.deepOrange[500]),
buildSettings(Icons.developer_board, 'Kernel', Colors.deepOrange[500]),
buildSettings(Icons.flag, 'Language', Colors.deepOrange[500]),

buildSettingsHeader('DEVELOPER'),

buildSettings(Icons.flag, 'Flags', Colors.deepOrange[500]),
buildSettings(Icons.developer_mode, 'Bootloader', Colors.green[500]),
buildSettings(Icons.extension, 'Extensions', Colors.blueGrey[500]),
buildSettings(Icons.brightness_low, 'Flutter', Colors.lightBlue[500]),
buildSettings(Icons.attach_money, 'System Shell', Colors.grey[500]),
buildSettings(Icons.android, 'Android Subsystem', Color(0xFF3DDA84)),
buildSettings(Icons.note, 'System Logs', Colors.deepOrange),

buildSettingsHeader('ABOUT'),

buildSettings(Icons.brightness_low, 'System', Colors.deepOrange[500]),
buildSettings(Icons.phone_android, 'Device', Colors.lightBlue[500]),
buildSettings(Icons.people, 'Credits', Colors.amber[600]),

buildSettingsHeader(' '),

                    ]))),

            
          ]),
        
        
        
        
        
      ),
    );
  }
}




