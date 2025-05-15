import 'dart:convert';

import 'package:project_coco/models/EventModel.dart';


class PropertyModel {
  EventColor color;
  bool hidden;

  PropertyModel({
  required this.color,
  required this.hidden,
  });

  static Map<String, PropertyModel> propertiesFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, PropertyModel>(k, PropertyModel.fromJson(v)));

  factory PropertyModel.fromJson(Map<String, dynamic> jsonMap) => PropertyModel(
    color: EventColor.fromId(int.parse(jsonMap["color"])),
    hidden: jsonMap["hidden"] as bool,
  );

  @override
  String toString() {
    // TODO: implement toString
    return "{\"color\": ${color.index}, \"hidden\": $hidden}";
  }
}