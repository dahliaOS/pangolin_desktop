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

import 'dart:ui';

import 'package:Pangolin/internal/locales/locales.g.dart';
import 'package:Pangolin/utils/hiveManager.dart';
import 'package:Pangolin/main.dart';
import 'package:Pangolin/utils/widgets/conditionWidget.dart';
import 'package:Pangolin/utils/widgets/settingsTile.dart';
import 'package:Pangolin/utils/widgets/settingsheader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GeneralManagement extends StatefulWidget {
  @override
  _GeneralManagementState createState() => _GeneralManagementState();
}

// String _selectedLanguage = Pangolin.settingsBox.get("languageName");

class _GeneralManagementState extends State<GeneralManagement> {
  List<Locale> localesLanguages = Locales.supported;
  String showLanguage(value) {
    final local = value.replaceAll("_", "-");
    return Locales.data['$local']['pangolin.qs_changelanguage'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "General",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Roboto"),
                  )),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsHeader(heading: "Language and Region"),
                    SettingsTile(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      children: [
                        Text("Language"),
                        SizedBox(height: 5),
                        Container(
                          width: 1.7976931348623157e+308,
                          child: DropdownButton<String>(
                            icon: Icon(null),
                            hint: Text("Language"),
                            value: '${context.locale}',
                            // items: languages.map((String value) {
                            items: localesLanguages.map((value) {
                              return DropdownMenuItem<String>(
                                value: '$value',
                                child: Text(showLanguage('$value')),
                              );
                            }).toList(),
                            onChanged: (_) {
                              _setLanguage(_, context);
                            },
                          ),
                        ),
                      ],
                    ),
                    SettingsHeader(heading: "Time"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: Icon(Icons.timelapse),
                          value: HiveManager.get("enableAutoTime"),
                          title: Text("Automatic time"),
                          onChanged: (bool state) {
                            setState(() {
                              HiveManager.set("enableAutoTime", state);
                            });
                          },
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
                                      _setKeyboard(_, context);
                                      setState(() {
                                        _setTimezone(_, context);
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            )),
                        SwitchListTile(
                          secondary: Text(
                            " :53",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          value: HiveManager.get("showSeconds"),
                          title: Text("Show seconds"),
                          onChanged: (bool state) {
                            setState(() {
                              HiveManager.set("showSeconds", state);
                            });
                          },
                        ),
                        SwitchListTile(
                          secondary: Text(
                            "14:00",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          value: HiveManager.get("enable24hTime"),
                          title: Text("Enable 24-hour time"),
                          onChanged: (bool state) {
                            setState(() {
                              HiveManager.set("enable24hTime", state);
                            });
                          },
                        ),
                      ],
                    ),
                    SettingsHeader(heading: "Keyboard"),
                    SettingsTile(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      children: [
                        Text("Set keyboard layout (WIP)"),
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
                                    "WARNING: You are on a pre-release build of dahliaOS, some settings don't work yet.",
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
  Locale locale = Locale(_selected.split('_').first, _selected.split('_').last);
  int index = Locales.supported.indexOf(locale);
  context.locale = Locales.supported[index];
}

void _setKeyboard(String _selected, BuildContext context) {
  switch (_selected) {
    case "عربى - إيران":
      EasyLocalization.of(context).locale = Locale("ar", "SA");
      Pangolin.settingsBox.put("keyboardLayout", "ar_SA");
      Pangolin.settingsBox.put("keyboardLayoutName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      EasyLocalization.of(context).locale = Locale("bs", "BA");
      Pangolin.settingsBox.put("keyboardLayout", "bs_BA");
      Pangolin.settingsBox
          .put("keyboardLayoutName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Hrvatski - Hrvatska":
      EasyLocalization.of(context).locale = Locale("hr", "HR");
      Pangolin.settingsBox.put("keyboardLayout", "hr_HR");
      Pangolin.settingsBox.put("keyboardLayoutName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - Nederland":
      EasyLocalization.of(context).locale = Locale("nl", "NL");
      Pangolin.settingsBox.put("keyboardLayout", "nl_NL");
      Pangolin.settingsBox.put("keyboardLayoutName", "Nederlands - Nederland");
      break;
    case "English - United States":
      EasyLocalization.of(context).locale = Locale("en", "US");
      Pangolin.settingsBox.put("keyboardLayout", "en_US");
      Pangolin.settingsBox.put("keyboardLayoutName", "English - United States");
      break;
    case "Français - France":
      EasyLocalization.of(context).locale = Locale("fr", "FR");
      Pangolin.settingsBox.put("keyboardLayout", "fr_FR");
      Pangolin.settingsBox.put("keyboardLayoutName", "Français - France");
      break;
    case "Deutsch - Deutschland":
      EasyLocalization.of(context).locale = Locale("de", "DE");
      Pangolin.settingsBox.put("keyboardLayout", "de_DE");
      Pangolin.settingsBox.put("keyboardLayoutName", "Deutsch - Deutschland");
      break;
    case "bahasa Indonesia - Indonesia":
      EasyLocalization.of(context).locale = Locale("id", "ID");
      Pangolin.settingsBox.put("keyboardLayout", "id_ID");
      Pangolin.settingsBox
          .put("keyboardLayoutName", "bahasa Indonesia - Indonesia");
      break;
    case "Polski - Polska":
      EasyLocalization.of(context).locale = Locale("pl", "PL");
      Pangolin.settingsBox.put("keyboardLayout", "pl_PL");
      Pangolin.settingsBox.put("keyboardLayoutName", "Polski - Polska");
      break;
    case "Português - Brasil":
      EasyLocalization.of(context).locale = Locale("pt", "BR");
      Pangolin.settingsBox.put("keyboardLayout", "pt_BR");
      Pangolin.settingsBox.put("keyboardLayoutName", "Português - Brasil");
      break;
    case "русский - Россия":
      EasyLocalization.of(context).locale = Locale("ru", "RU");
      Pangolin.settingsBox.put("keyboardLayout", "ru_RU");
      Pangolin.settingsBox.put("keyboardLayoutName", "русский - Россия");
      break;
    case "Svenska - Sverige":
      EasyLocalization.of(context).locale = Locale("sv", "SE");
      Pangolin.settingsBox.put("keyboardLayout", "sv_SE");
      Pangolin.settingsBox.put("keyboardLayoutName", "Svenska - Sverige");
      break;
    case "Український - Україна":
      EasyLocalization.of(context).locale = Locale("uk", "UA");
      Pangolin.settingsBox.put("keyboardLayout", "uk_UA");
      Pangolin.settingsBox.put("keyboardLayoutName", "Український - Україна");
      break;
  }
}

void _setTimezone(String _selected, BuildContext context) {
  switch (_selected) {
    case "عربى - إيران":
      EasyLocalization.of(context).locale = Locale("ar", "SA");
      Pangolin.settingsBox.put("timeZone", "ar_SA");
      Pangolin.settingsBox.put("timeZoneName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      EasyLocalization.of(context).locale = Locale("bs", "BA");
      Pangolin.settingsBox.put("timeZone", "bs_BA");
      Pangolin.settingsBox
          .put("timeZoneName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Hrvatski - Hrvatska":
      EasyLocalization.of(context).locale = Locale("hr", "HR");
      Pangolin.settingsBox.put("timeZone", "hr_HR");
      Pangolin.settingsBox.put("timeZoneName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - Nederland":
      EasyLocalization.of(context).locale = Locale("nl", "NL");
      Pangolin.settingsBox.put("timeZone", "nl_NL");
      Pangolin.settingsBox.put("timeZoneName", "Nederlands - Nederland");
      break;
    case "English - United States":
      EasyLocalization.of(context).locale = Locale("en", "US");
      Pangolin.settingsBox.put("timeZone", "en_US");
      Pangolin.settingsBox.put("timeZoneName", "English - United States");
      break;
    case "Français - France":
      EasyLocalization.of(context).locale = Locale("fr", "FR");
      Pangolin.settingsBox.put("timeZone", "fr_FR");
      Pangolin.settingsBox.put("timeZoneName", "Français - France");
      break;
    case "Deutsch - Deutschland":
      EasyLocalization.of(context).locale = Locale("de", "DE");
      Pangolin.settingsBox.put("timeZone", "de_DE");
      Pangolin.settingsBox.put("timeZoneName", "Deutsch - Deutschland");
      break;
    case "bahasa Indonesia - Indonesia":
      EasyLocalization.of(context).locale = Locale("id", "ID");
      Pangolin.settingsBox.put("timeZone", "id_ID");
      Pangolin.settingsBox.put("timeZoneName", "bahasa Indonesia - Indonesia");
      break;
    case "Polski - Polska":
      EasyLocalization.of(context).locale = Locale("pl", "PL");
      Pangolin.settingsBox.put("timeZone", "pl_PL");
      Pangolin.settingsBox.put("timeZoneName", "Polski - Polska");
      break;
    case "Português - Brasil":
      EasyLocalization.of(context).locale = Locale("pt", "BR");
      Pangolin.settingsBox.put("timeZone", "pt_BR");
      Pangolin.settingsBox.put("timeZoneName", "Português - Brasil");
      break;
    case "русский - Россия":
      EasyLocalization.of(context).locale = Locale("ru", "RU");
      Pangolin.settingsBox.put("timeZone", "ru_RU");
      Pangolin.settingsBox.put("timeZoneName", "русский - Россия");
      break;
    case "Svenska - Sverige":
      EasyLocalization.of(context).locale = Locale("sv", "SE");
      Pangolin.settingsBox.put("timeZone", "sv_SE");
      Pangolin.settingsBox.put("timeZoneName", "Svenska - Sverige");
      break;
    case "Український - Україна":
      EasyLocalization.of(context).locale = Locale("uk", "UA");
      Pangolin.settingsBox.put("timeZone", "uk_UA");
      Pangolin.settingsBox.put("timeZoneName", "Український - Україна");
      break;
  }
}
