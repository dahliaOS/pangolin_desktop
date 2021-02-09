import 'package:flutter/material.dart';

class Wallpaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            "assets/images/wallpapers/Three_Bubbles.png",
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          child: Text(
            "Warning!\nYou are using a pre release version of the Pangolin Desktop",
            style: TextStyle(color: Colors.white),
          ),
          bottom: 80,
          right: 20,
        )
      ],
    );
  }
}
