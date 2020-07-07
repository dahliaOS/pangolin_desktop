import 'package:flutter/material.dart';

Widget ConditionWidget(bool condition, Widget child) {
  if (condition == true) {
    return child;
  } else {
    return Container(height: 0); //or any other widget but not null
  }
}

Widget CustomConditionWidget(bool condition, Widget isTrue, Widget isFalse) {
  if (condition == true) {
    return isTrue;
  } else {
    return isFalse; //or any other widget but not null
  }
}
