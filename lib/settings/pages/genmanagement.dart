import 'package:Pangolin/settings/hiveManager.dart';
import 'package:Pangolin/widgets/conditionWidget.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/settingsTile.dart';

class GeneralManagement extends StatefulWidget {
  @override
  _GeneralManagementState createState() => _GeneralManagementState();
}

String _selectedLanguage = Pangolin.settingsBox.get("languageName");

class _GeneralManagementState extends State<GeneralManagement> {
  List<String> languages = HiveManager().get("settingsLanguageSelectorList");

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
                            Text("Show Seconds"),
                            Switch(
                              value: HiveManager().get("showSeconds"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager().set("showSeconds", state);
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Automatic Time"),
                            Switch(
                              value: HiveManager().get("enableAutoTime"),
                              onChanged: (bool state) {
                                setState(() {
                                  HiveManager().set("enableAutoTime", state);
                                });
                              },
                            )
                          ],
                        ),
                        ConditionWidget(
                            !(HiveManager().get("enableAutoTime")),
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
                                        _selectedLanguage = Pangolin.settingsBox
                                            .get("languageName");
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Enable 24 Hour Time"),
                                    Switch(
                                      value: HiveManager().get("enable24hTime"),
                                      onChanged: (bool state) {
                                        setState(() {
                                          HiveManager()
                                              .set("enable24hTime", state);
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            )),
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
                        Text("Set Keyboard layout"),
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
  }
}
