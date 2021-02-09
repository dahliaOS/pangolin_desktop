import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';

class LauncherItem extends StatelessWidget {
  final String? iconPath;
  final Widget? application;
  const LauncherItem(this.iconPath, this.application);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.white..withOpacity(0.3),
      onTap: () {},
      child: BoxContainer(
        useBlur: false,
        width: 128,
        height: 128,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/icons/$iconPath.png"),
            Text(iconPath.toString()),
          ],
        ),
      ),
    );
  }
}
