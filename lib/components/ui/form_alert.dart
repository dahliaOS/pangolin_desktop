import 'package:flutter/material.dart';

Widget formAlert(Color color, String text, Color textColor, IconData icon) {
  return ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    child: Container(
      color: color,
      height: 40,
      width: 280,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Icon(
              icon,
              color: textColor,
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          )
        ],
      ),
    ),
  );
}
