import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _SpalshScreen(),
    );
  }
}

class _SpalshScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Image.asset(
            "assets/images/logos/pangolin/pangolinlogo.png",
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
