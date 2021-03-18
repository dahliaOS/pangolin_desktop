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

import 'dart:ui';

import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pangolin/internal/locales/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:pangolin/widgets/settingsTile.dart';
import 'package:pangolin/widgets/settingsheader.dart';
import 'package:provider/provider.dart';

class GeneralManagement extends StatelessWidget {
  List<Locale> localesLanguages = Locales.supported;
  String showLanguage(value) {
    final local = value.replaceAll("_", "-");
    return Locales.data['$local']!['pangolin.qs_changelanguage']!;
  }

  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<PreferenceProvider>(context, listen: false);
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
                          /* child: DropdownButton<String>(
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
                              _setLanguage(_ ?? "en_US", context);
                            },
                          ), */
                        ),
                      ],
                    ),
                    SettingsHeader(heading: "Time"),
                    SettingsTile(
                      children: [
                        SwitchListTile(
                          secondary: Icon(Icons.timelapse),
                          value: _data.enableAutoTime,
                          title: Text("Automatic time"),
                          onChanged: (bool state) {
                            _data.enableAutoTime = !_data.enableAutoTime;
                          },
                        ),
                        /* ConditionWidget(
                            !(DatabaseManager.get("enableAutoTime")),
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
                                    value: DatabaseManager.get("timeZoneName"),
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
                            )), */
                        SwitchListTile(
                          secondary: Text(
                            " :53",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600),
                          ),
                          value: _data.showSeconds,
                          title: Text("Show seconds"),
                          onChanged: (bool state) {
                            _data.showSeconds = !_data.showSeconds;
                          },
                        ),
                        SwitchListTile(
                          secondary: Text(
                            "14:00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600),
                          ),
                          value: _data.enable24h,
                          title: Text("Enable 24-hour time"),
                          onChanged: (bool state) {
                            _data.enable24h = !_data.enable24h;
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
                          /* child: DropdownButton<String>(
                            icon: Icon(null),
                            hint: Text("Language"),
                            value: _data.keyboardLayoutName,
                            items: languages.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ), */
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
      EasyLocalization.of(context)?.setLocale(Locale("ar", "SA"));
      DatabaseManager.set("keyboardLayout", "ar_SA");
      DatabaseManager.set("keyboardLayoutName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      EasyLocalization.of(context)?.setLocale(Locale("bs", "BA"));
      DatabaseManager.set("keyboardLayout", "bs_BA");
      DatabaseManager.set(
          "keyboardLayoutName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Hrvatski - Hrvatska":
      EasyLocalization.of(context)?.setLocale(Locale("hr", "HR"));
      DatabaseManager.set("keyboardLayout", "hr_HR");
      DatabaseManager.set("keyboardLayoutName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - Nederland":
      EasyLocalization.of(context)?.setLocale(Locale("nl", "NL"));
      DatabaseManager.set("keyboardLayout", "nl_NL");
      DatabaseManager.set("keyboardLayoutName", "Nederlands - Nederland");
      break;
    case "English - United States":
      EasyLocalization.of(context)?.setLocale(Locale("en", "US"));
      DatabaseManager.set("keyboardLayout", "en_US");
      DatabaseManager.set("keyboardLayoutName", "English - United States");
      break;
    case "Français - France":
      EasyLocalization.of(context)?.setLocale(Locale("fr", "FR"));
      DatabaseManager.set("keyboardLayout", "fr_FR");
      DatabaseManager.set("keyboardLayoutName", "Français - France");
      break;
    case "Deutsch - Deutschland":
      EasyLocalization.of(context)?.setLocale(Locale("de", "DE"));
      DatabaseManager.set("keyboardLayout", "de_DE");
      DatabaseManager.set("keyboardLayoutName", "Deutsch - Deutschland");
      break;
    case "bahasa Indonesia - Indonesia":
      EasyLocalization.of(context)?.setLocale(Locale("id", "ID"));
      DatabaseManager.set("keyboardLayout", "id_ID");
      DatabaseManager.set("keyboardLayoutName", "bahasa Indonesia - Indonesia");
      break;
    case "Polski - Polska":
      EasyLocalization.of(context)?.setLocale(Locale("pl", "PL"));
      DatabaseManager.set("keyboardLayout", "pl_PL");
      DatabaseManager.set("keyboardLayoutName", "Polski - Polska");
      break;
    case "Português - Brasil":
      EasyLocalization.of(context)?.setLocale(Locale("pt", "BR"));
      DatabaseManager.set("keyboardLayout", "pt_BR");
      DatabaseManager.set("keyboardLayoutName", "Português - Brasil");
      break;
    case "русский - Россия":
      EasyLocalization.of(context)?.setLocale(Locale("ru", "RU"));
      DatabaseManager.set("keyboardLayout", "ru_RU");
      DatabaseManager.set("keyboardLayoutName", "русский - Россия");
      break;
    case "Svenska - Sverige":
      EasyLocalization.of(context)?.setLocale(Locale("sv", "SE"));
      DatabaseManager.set("keyboardLayout", "sv_SE");
      DatabaseManager.set("keyboardLayoutName", "Svenska - Sverige");
      break;
    case "Український - Україна":
      EasyLocalization.of(context)?.setLocale(Locale("uk", "UA"));
      DatabaseManager.set("keyboardLayout", "uk_UA");
      DatabaseManager.set("keyboardLayoutName", "Український - Україна");
      break;
  }
}

void _setTimezone(String _selected, BuildContext context) {
  switch (_selected) {
    case "عربى - إيران":
      EasyLocalization.of(context)?.setLocale(Locale("ar", "SA"));
      DatabaseManager.set("keyboardLayout", "ar_SA");
      DatabaseManager.set("keyboardLayoutName", "عربى - إيران");
      break;
    case "Bosanski - Bosna i Hercegovina":
      EasyLocalization.of(context)?.setLocale(Locale("bs", "BA"));
      DatabaseManager.set("keyboardLayout", "bs_BA");
      DatabaseManager.set(
          "keyboardLayoutName", "Bosanski - Bosna i Hercegovina");
      break;
    case "Hrvatski - Hrvatska":
      EasyLocalization.of(context)?.setLocale(Locale("hr", "HR"));
      DatabaseManager.set("keyboardLayout", "hr_HR");
      DatabaseManager.set("keyboardLayoutName", "Hrvatski - Hrvatska");
      break;
    case "Nederlands - Nederland":
      EasyLocalization.of(context)?.setLocale(Locale("nl", "NL"));
      DatabaseManager.set("keyboardLayout", "nl_NL");
      DatabaseManager.set("keyboardLayoutName", "Nederlands - Nederland");
      break;
    case "English - United States":
      EasyLocalization.of(context)?.setLocale(Locale("en", "US"));
      DatabaseManager.set("keyboardLayout", "en_US");
      DatabaseManager.set("keyboardLayoutName", "English - United States");
      break;
    case "Français - France":
      EasyLocalization.of(context)?.setLocale(Locale("fr", "FR"));
      DatabaseManager.set("keyboardLayout", "fr_FR");
      DatabaseManager.set("keyboardLayoutName", "Français - France");
      break;
    case "Deutsch - Deutschland":
      EasyLocalization.of(context)?.setLocale(Locale("de", "DE"));
      DatabaseManager.set("keyboardLayout", "de_DE");
      DatabaseManager.set("keyboardLayoutName", "Deutsch - Deutschland");
      break;
    case "bahasa Indonesia - Indonesia":
      EasyLocalization.of(context)?.setLocale(Locale("id", "ID"));
      DatabaseManager.set("keyboardLayout", "id_ID");
      DatabaseManager.set("keyboardLayoutName", "bahasa Indonesia - Indonesia");
      break;
    case "Polski - Polska":
      EasyLocalization.of(context)?.setLocale(Locale("pl", "PL"));
      DatabaseManager.set("keyboardLayout", "pl_PL");
      DatabaseManager.set("keyboardLayoutName", "Polski - Polska");
      break;
    case "Português - Brasil":
      EasyLocalization.of(context)?.setLocale(Locale("pt", "BR"));
      DatabaseManager.set("keyboardLayout", "pt_BR");
      DatabaseManager.set("keyboardLayoutName", "Português - Brasil");
      break;
    case "русский - Россия":
      EasyLocalization.of(context)?.setLocale(Locale("ru", "RU"));
      DatabaseManager.set("keyboardLayout", "ru_RU");
      DatabaseManager.set("keyboardLayoutName", "русский - Россия");
      break;
    case "Svenska - Sverige":
      EasyLocalization.of(context)?.setLocale(Locale("sv", "SE"));
      DatabaseManager.set("keyboardLayout", "sv_SE");
      DatabaseManager.set("keyboardLayoutName", "Svenska - Sverige");
      break;
    case "Український - Україна":
      EasyLocalization.of(context)?.setLocale(Locale("uk", "UA"));
      DatabaseManager.set("keyboardLayout", "uk_UA");
      DatabaseManager.set("keyboardLayoutName", "Український - Україна");
      break;
  }
}
