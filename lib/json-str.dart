//Stringifies JSON for applications
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'app_model.dart';


Future<String> _loadShapeAsset() async {
  return await rootBundle.loadString('assets/shape.json');
}


Future loadShape() async {
  String jsonString = await _loadShapeAsset();
  final jsonResponse = json.decode(jsonString);
  Shape shape = new Shape.fromJson(jsonResponse);
  print(shape.property.breadth);
}