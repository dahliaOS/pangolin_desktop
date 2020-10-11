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

import 'package:Pangolin/utils/hiveManager.dart';
import 'package:Pangolin/main.dart';
import 'package:Pangolin/utils/widgets/conditionWidget.dart';
import 'package:Pangolin/utils/widgets/settingsTile.dart';
import 'package:flutter/material.dart';

class GeneralManagement extends StatefulWidget {
  @override
  _GeneralManagementState createState() => _GeneralManagementState();
}

String _selectedLanguage = Pangolin.settingsBox.get("languageName");

class _GeneralManagementState extends State<GeneralManagement> {
  List<String> languages = HiveManager.get("settingsLanguageSelectorList");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "General Management",
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
                      child: Text("Language and Region",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 5),
                    SettingsTile(
                      children: [
                        Text("Language"),
                        SizedBox(height: 5),
                        Container(
                          width: 1.7976931348623157e+308,
                          child: DropdownButton<String>(
                            icon: Icon(null),
                            hint: Text("Language"),
                            value: _selectedLanguage,
                            items: languages.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              _setLanguage(_, context);
                              setState(() {
                                _selectedLanguage =
                                    Pangolin.settingsBox.get("languageName");
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Time",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SettingsTile(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Automatic Time"),
                            Switch(
                              value: HiveManager.get("enableAutoTime"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager.set("enableAutoTime", state);
                                });
                              },
                            )
                          ],
                        ),
                        ConditionWidget(
                            !(HiveManager.get("enableAutoTime")),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(),
                                SizedBox(height: 15),
                                Text("Time Zone"),
                                SizedBox(height: 5),
                                Container(
                                  width: 1.7976931348623157e+308,
                                  child: DropdownButton<String>(
                                    icon: Icon(null),
                                    hint: Text("Time"),
                                    value: HiveManager.get("timeZoneName"),
                                    items: languages.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {
                                      _setLanguage(_, context);
                                      setState(() {
                                        _setTimezone(_, context);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Show Seconds"),
                            Switch(
                              value: HiveManager.get("showSeconds"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager.set("showSeconds", state);
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Enable 24 Hour Time"),
                            Switch(
                              value: HiveManager.get("enable24hTime"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager.set("enable24hTime", state);
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text("Keyboard",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold)),
                    ),
                    SettingsTile(
                      children: [
                        Text("Set Keyboard layout - WIP"),
                        SizedBox(height: 5),
                        Container(
                          width: 1.7976931348623157e+308,
                          child: DropdownButton<String>(
                            icon: Icon(null),
                            hint: Text("Language"),
                            value: HiveManager.get("keyboardLayoutName"),
                            items: languages.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {
                              setState(() {
                                _setKeyboard(_, context);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          color: Color(0x00ffffff),
          child: new SizedBox(
              height: 50,
              width: 15,
              child: new Padding(
                  padding: EdgeInsets.all(0),
                  child: Card(
                    elevation: 0,
                    color: Colors.amber[500],
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: new Row(
                        children: [
                          new Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.warning,
                                    size: 25,
                                    color: Colors.grey[900],
                                  ))),
                          Center(
                              child: new Padding(
                                  padding: EdgeInsets.all(8),
                                  child: new Text(
                                    "WARNING: You are on a pre-release build of dahliaOS. Some settings don't work yet.",
                                    style: new TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 14,
                                      fontFamily: "Roboto",
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  )))),
    );
  }
}

void _setLanguage(String _selected, BuildContext context) {
  switch (_selected) {
    case "English - United States":
      Pangolin.setLocale(context, Locale("en", "US"));
      Pangolin.settingsBox.put("language", "en_US");
      Pangolin.settingsBox.put("languageName", "English - United States");
      break;
    case "Deutsch - Deutschland":
      Pangolin.setLocale(context, Locale("de", "DE"));
      Pangolin.settingsBox.put("language", "de_DE");
      Pangolin.settingsBox.put("languageName", "Deutsch - Deutschland");
      break;
    case "Français - France":
      Pangolin.setLocale(context, Locale("fr", "FR"));
      Pangolin.settingsBox.put("language", "fr_FR");
      Pangolin.settingsBox.put("languageName", "Français - France");
      break;
    case "Polski - Polska":
      Pangolin.setLocale(context, Locale("pl", "PL"));
      Pangolin.settingsBox.put("language", "pl_PL");
      Pangolin.settingsBox.put("languageName", "Polski - Polska");
      break;
    case "Hrvatski - Hrvatska":
      Pangolin.setLocale(context, Locale("hr", "HR"));
      Pangolin.settingsBox.put("language", "hr_HR");
      Pangolin.settingsBox.put("languageName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - België":
      Pangolin.setLocale(context, Locale("nl", "BE"));
      Pangolin.settingsBox.put("language", "nl_BE");
      Pangolin.settingsBox.put("languageName", "Nederlands - België");
      break;
    case "Nederlands - Nederland":
      Pangolin.setLocale(context, Locale("nl", "NL"));
      Pangolin.settingsBox.put("language", "nl_NL");
      Pangolin.settingsBox.put("languageName", "Nederlands - Nederland");
      break;
    case "عربى - إيران":
      Pangolin.setLocale(context, Locale("ar", "AR"));
      Pangolin.settingsBox.put("language", "ar_AR");
      Pangolin.settingsBox.put("languageName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      Pangolin.setLocale(context, Locale("bs", "BS"));
      Pangolin.settingsBox.put("language", "bs_BH");
      Pangolin.settingsBox
          .put("languageName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Português - Brasil":
      Pangolin.setLocale(context, Locale("pt", "PT"));
      Pangolin.settingsBox.put("language", "pt_BR");
      Pangolin.settingsBox.put("languageName", "Português - Brasil");
      break;
  }
}

void _setKeyboard(String _selected, BuildContext context) {
  switch (_selected) {
    case "English - United States":
      Pangolin.setLocale(context, Locale("en", "US"));
      Pangolin.settingsBox.put("keyboardLayout", "en_US");
      Pangolin.settingsBox.put("keyboardLayoutName", "English - United States");
      break;
    case "Deutsch - Deutschland":
      Pangolin.setLocale(context, Locale("de", "DE"));
      Pangolin.settingsBox.put("keyboardLayout", "de_DE");
      Pangolin.settingsBox.put("keyboardLayoutName", "Deutsch - Deutschland");
      break;
    case "Français - France":
      Pangolin.setLocale(context, Locale("fr", "FR"));
      Pangolin.settingsBox.put("keyboardLayout", "fr_FR");
      Pangolin.settingsBox.put("keyboardLayoutName", "Français - France");
      break;
    case "Polski - Polska":
      Pangolin.setLocale(context, Locale("pl", "PL"));
      Pangolin.settingsBox.put("keyboardLayout", "pl_PL");
      Pangolin.settingsBox.put("keyboardLayoutName", "Polski - Polska");
      break;
    case "Hrvatski - Hrvatska":
      Pangolin.setLocale(context, Locale("hr", "HR"));
      Pangolin.settingsBox.put("keyboardLayout", "hr_HR");
      Pangolin.settingsBox.put("keyboardLayoutName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - België":
      Pangolin.setLocale(context, Locale("nl", "BE"));
      Pangolin.settingsBox.put("keyboardLayout", "nl_BE");
      Pangolin.settingsBox.put("keyboardLayoutName", "Nederlands - België");
      break;
    case "Nederlands - Nederland":
      Pangolin.setLocale(context, Locale("nl", "NL"));
      Pangolin.settingsBox.put("keyboardLayout", "nl_NL");
      Pangolin.settingsBox.put("keyboardLayoutName", "Nederlands - Nederland");
      break;
    case "عربى - إيران":
      Pangolin.setLocale(context, Locale("ar", "AR"));
      Pangolin.settingsBox.put("keyboardLayout", "ar_AR");
      Pangolin.settingsBox.put("keyboardLayoutName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      Pangolin.setLocale(context, Locale("bs", "BS"));
      Pangolin.settingsBox.put("keyboardLayout", "bs_BH");
      Pangolin.settingsBox
          .put("keyboardLayoutName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Português - Brasil":
      Pangolin.setLocale(context, Locale("pt", "PT"));
      Pangolin.settingsBox.put("keyboardLayout", "pt_BR");
      Pangolin.settingsBox.put("keyboardLayoutName", "Português - Brasil");
      break;
  }
}

void _setTimezone(String _selected, BuildContext context) {
  switch (_selected) {
    case "English - United States":
      Pangolin.setLocale(context, Locale("en", "US"));
      Pangolin.settingsBox.put("timeZone", "en_US");
      Pangolin.settingsBox.put("timeZoneName", "English - United States");
      break;
    case "Deutsch - Deutschland":
      Pangolin.setLocale(context, Locale("de", "DE"));
      Pangolin.settingsBox.put("timeZone", "de_DE");
      Pangolin.settingsBox.put("timeZoneName", "Deutsch - Deutschland");
      break;
    case "Français - France":
      Pangolin.setLocale(context, Locale("fr", "FR"));
      Pangolin.settingsBox.put("timeZone", "fr_FR");
      Pangolin.settingsBox.put("timeZoneName", "Français - France");
      break;
    case "Polski - Polska":
      Pangolin.setLocale(context, Locale("pl", "PL"));
      Pangolin.settingsBox.put("timeZone", "pl_PL");
      Pangolin.settingsBox.put("timeZoneName", "Polski - Polska");
      break;
    case "Hrvatski - Hrvatska":
      Pangolin.setLocale(context, Locale("hr", "HR"));
      Pangolin.settingsBox.put("timeZone", "hr_HR");
      Pangolin.settingsBox.put("timeZoneName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - België":
      Pangolin.setLocale(context, Locale("nl", "BE"));
      Pangolin.settingsBox.put("timeZone", "nl_BE");
      Pangolin.settingsBox.put("timeZoneName", "Nederlands - België");
      break;
    case "Nederlands - Nederland":
      Pangolin.setLocale(context, Locale("nl", "NL"));
      Pangolin.settingsBox.put("timeZone", "nl_NL");
      Pangolin.settingsBox.put("timeZoneName", "Nederlands - Nederland");
      break;
    case "عربى - إيران":
      Pangolin.setLocale(context, Locale("ar", "AR"));
      Pangolin.settingsBox.put("timeZone", "ar_AR");
      Pangolin.settingsBox.put("timeZoneName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      Pangolin.setLocale(context, Locale("bs", "BS"));
      Pangolin.settingsBox.put("timeZone", "bs_BH");
      Pangolin.settingsBox
          .put("timeZoneName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Português - Brasil":
      Pangolin.setLocale(context, Locale("pt", "PT"));
      Pangolin.settingsBox.put("timeZone", "pt_BR");
      Pangolin.settingsBox.put("timeZoneName", "Português - Brasil");
      break;
  }
}
