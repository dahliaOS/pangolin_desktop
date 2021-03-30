import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:pangolin/internal/visualEngine/visualData.dart';

Future<String> _loadDataAsset() async {
  return await rootBundle.loadString('assets/json/visualData.json');
}

Future loadVisualEngine() async {
  String jsonString = await _loadDataAsset();
  final jsonResponse = json.decode(jsonString);
  VisualInformation visuals = new VisualInformation.fromJson(jsonResponse);
  print(visuals.titleInfo);
}
