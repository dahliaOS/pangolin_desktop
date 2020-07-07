import 'package:flutter/material.dart';

class AdvancedFeatures extends StatefulWidget {
  @override
  _AdvancedFeaturesState createState() => _AdvancedFeaturesState();
}

class _AdvancedFeaturesState extends State<AdvancedFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Advanced Features",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
