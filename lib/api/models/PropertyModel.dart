import 'dart:convert';

import 'package:project_coco/api/models/EventModel.dart';


class PropertyModel {
  EventColor color;
  bool hidden;

  PropertyModel({
  required this.color,
  required this.hidden,
  });

  ///for /Properties Endpoint
  ///Handles special Characters
  static Map<String, PropertyModel> propertiesFromJson(String str) {
    return Map.from(json.decode(str)).map((k, v) => MapEntry<String, PropertyModel>('"${k.toString().replaceAll("\\", "\\\\").replaceAll("\"", "\\\"")}"', PropertyModel.fromJson(v)));
  }

  factory PropertyModel.fromJson(Map<String, dynamic> jsonMap) => PropertyModel(
    color: EventColor.fromId(int.parse(jsonMap["color"])),// Use EventColors for Color
    hidden: jsonMap["hidden"] as bool,
  );

  @override
  String toString() {
    return "{\"color\": \"${color.index}\", \"hidden\": $hidden}";
  }
}