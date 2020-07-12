import 'package:flutter/material.dart';

void main() {
  runApp(new Logs());
}

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'System Logs',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new LogsPage(),
    );
  }
}

class LogsPage extends StatefulWidget {
  LogsPage({Key key}) : super(key: key);
  @override
  _LogsPageState createState() => new _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('System Logs'),
      ),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.apps),
                selectedIcon: Icon(Icons.apps),
                label: Text('Application Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.new_releases),
                selectedIcon: Icon(Icons.new_releases),
                label: Text('Event Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: Text('Service Logs'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.brightness_low),
                selectedIcon: Icon(Icons.brightness_low),
                label: Text('System Logs'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: Text('selectedIndex: $_selectedIndex'),
            ),
          )
        ],
      ),
    );
  }
}
