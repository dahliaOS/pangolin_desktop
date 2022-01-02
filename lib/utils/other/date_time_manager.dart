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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pangolin/utils/data/database_manager.dart';

class DateTimeManager {
  const DateTimeManager._();

  /// Current time [ValueNotifier]
  ///
  /// Notifies about the current time according to the [DateFormat]
  static ValueNotifier<String>? _timeNotifier;

  /// Current date [ValueNotifier]
  ///
  /// Notifies about the current date according to the [DateFormat]
  static ValueNotifier<String>? _dateNotifier;

  static String? _time;
  static String? _date;

  static Future<void> initialiseScheduler() async {
    //TODO create an initalisation for the default format
    //setTimeFormat('12h+S');
    setDateFormat("dd.MM.yyyy");

    _timeNotifier = ValueNotifier(_getTimeFormat().format(DateTime.now()));

    _dateNotifier = ValueNotifier(
      DateFormat(DatabaseManager.get('dateFormat')).format(DateTime.now()),
    );

    while (true) {
      formatTime();
      formatDate();
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  static ValueNotifier<String>? getTimeNotifier() => _timeNotifier;

  static ValueNotifier<String>? getDateNotifier() => _dateNotifier;

  /// Returns the Time with the selected format
  ///
  /// eg. 11:30 am | 16:20
  /// Note: To get realtime time updates use [getTimeNotifier]
  static String? getTime() => _time;

  /// Returns the Date with the selected format
  ///
  /// eg. 24.12.2021 | 12/24/2021
  /// Note: To get realtime date updates use [getDateNotifier]
  static String? getDate() => _date;

  /// Format the Date
  static void formatDate() {
    _date =
        DateFormat(DatabaseManager.get('dateFormat')).format(DateTime.now());
    _dateNotifier!.value = _date!;
  }

  /// Get the [DateFormat]
  static DateFormat _getTimeFormat() {
    DateFormat _format;
    switch (DatabaseManager.get('timeFormat')) {
      case '12h':
        _format = DateFormat.jm();
        break;
      case '24h':
        _format = DateFormat.Hm();
        break;
      case '12h+s':
        _format = DateFormat.jms();
        break;
      case '24h+s':
        _format = DateFormat.Hms();
        break;
      default:
        _format = DateFormat.Hms();
        break;
    }
    return _format;
  }

  /// Format the time
  static void formatTime() {
    _time = _getTimeFormat().format(DateTime.now());
    _timeNotifier!.value = _time!;
  }

  /// Sets the Time Format
  /// Choose the time format:
  /// am/pm:  "12h"
  /// 24hr:       "24h"
  /// am/pm with seconds: "12h+s"
  /// 24hr with seconds: "24h+s"
  static void setTimeFormat(String format) {
    DatabaseManager.set('timeFormat', format.toLowerCase());
  }

  /// Sets the Date Format
  /// Choose a time format
  /// More information: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  static void setDateFormat(String format) {
    DatabaseManager.set('dateFormat', format);
  }
}
