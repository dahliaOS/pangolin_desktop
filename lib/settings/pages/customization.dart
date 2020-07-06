import 'package:flutter/material.dart';

class Customization extends StatefulWidget {
  @override
  _CustomizationState createState() => _CustomizationState();
}

class _CustomizationState extends State<Customization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
        child: Column(
          children: [
            Center(
                child: Text(
              "Customization",
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
