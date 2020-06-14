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

/*This will ultimately be replaced by a global system file, but keep it for android*/
//import 'dart:async';
import 'package:flutter/material.dart';

class WallpaperGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/wallpaper.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class WallpaperIcon extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/wallpaper.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class CalculatorGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/calculator.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class PhoneGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/phone.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class GmailGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/Gmail-icon.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class MusicGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/music.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class SettingsGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/settings.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}

class ClockGrid extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      child: Image.asset(
        'lib/images/clock.png',
        fit:BoxFit.fill,
        width: 50.0,
        height: 50.0,
      ),

      padding: const EdgeInsets.all(0.0),
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
  }
}
