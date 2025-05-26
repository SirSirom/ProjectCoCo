import 'dart:convert';
import 'dart:ui';

///
/// Class to import data of google calendars.
class CalendarModel {

  String id;
  String name;
  String? description;
  Color? color;
  String? timeZone;
  bool registered;

  CalendarModel({
    required this.id,
    required this.name,
    this.description,
    this.color,
    this.timeZone,
    required this.registered
  }
  );

  static List<CalendarModel> calendarsFromJson(String str) => List<CalendarModel>.from(json.decode(str).map((x) => CalendarModel.fromJson(x)));
  

  factory CalendarModel.fromJson(Map<String, dynamic> jsonMap){

    // Convert Map<String, dynamic> to Map<String, String>
    return CalendarModel(
      id: jsonMap["id"] as String,
      name: jsonMap["name"] as String,
      description: jsonMap["description"] as String,
      color: Color(int.parse('0xFF${(jsonMap["color"] as String).substring(1)}')),
      timeZone: jsonMap["timeZone"] as String,
      registered: jsonMap["registered"] as bool
    );

  }

  @override
  String toString() {
    return '''{
      "id": $id,
      "name": "$name",
      "description": "$description",
      "color": "${color.toString()}",
      "timeZone": "$timeZone",
      "registered": $registered
     }''';
  }
}