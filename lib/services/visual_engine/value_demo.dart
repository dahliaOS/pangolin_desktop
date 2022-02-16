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

import 'package:flutter/material.dart';

void main() {
  runApp(const ValueDemoApp());
}

class ValueDemoApp extends StatelessWidget {
  const ValueDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primaryColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFf0f0f0),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFF2196f3)),
      ),
      home: const ValueDemoHomePage(),
    );
  }
}

class ValueDemoHomePage extends StatefulWidget {
  const ValueDemoHomePage({Key? key}) : super(key: key);
  @override
  _ValueDemoHomePageState createState() => _ValueDemoHomePageState();
}

class _ValueDemoHomePageState extends State<ValueDemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Name'),
      ),
      body: Column(),
    );
  }
}
