import 'package:dahlia_backend/dahlia_backend.dart';
import 'package:flutter/material.dart';

class ErrorWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BoxContainer(
      color: Colors.black.withOpacity(0.3),
      useSystemOpacity: false,
      customBlur: 30,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "ERROR",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Please try again or contact the support",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
