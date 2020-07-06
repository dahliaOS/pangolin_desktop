import 'package:flutter/material.dart';

class Backup extends StatefulWidget {
  @override
  _BackupState createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
        child: Column(
          children: [
            Center(
                child: Text(
              "Backup",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ))
          ],
        ),
      ),
    );
  }
}
