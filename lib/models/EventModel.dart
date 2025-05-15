import 'dart:convert';
import 'dart:ui';

class EventModel {
  String id;
  String title;
  String? description;
  EventColor? color;
  EventType eventType;
  List<String>? creators;
  EventTransparency transparency;
  String? location;
  DateTime? startTime;
  DateTime? endTime;
  List<String>? tags;

  EventModel({
    required this.id,
    required this.title,
    this.description,
    this.color,
    required this.eventType,
    this.creators,
    this.location,
    required this.transparency,
    this.startTime,
    this.endTime,
    this.tags
  });

  factory EventModel.fromJson(Map<String, dynamic> jsonMap){

    // Convert Map<String, dynamic> to Map<String, String>
    return EventModel(
        id: jsonMap["id"] as String,
        title: jsonMap["title"] as String,
        description: jsonMap["description"] as String,
        color: EventColor.fromId(int.tryParse(jsonMap["color"])),
        eventType: EventType.fromText(jsonMap["eventType"]),
        creators: List<String>.from(jsonMap["creators"]),
        transparency: EventTransparency.fromText(jsonMap["transparency"]),
        location: jsonMap["location"] as String,
        startTime: DateTime.parse(jsonMap["startTime"]),
        endTime: DateTime.parse(jsonMap["endTime"]),
        tags: List<String>.from(jsonMap["tags"]),
    );}


  static List<EventModel> eventsFromJson(String str) => List<EventModel>.from(json.decode(str).map((x) => EventModel.fromJson(x)));
  @override
  String toString() {
    // TODO: implement toString
    return '''{
      \"id\": $id,
      \"title\": \"$title\",
      \"description\": \"$description\",
      \"color\": \"$color\",
      \"eventType\": \"$eventType\",
      \"creators\": $creators,
      \"transparency\": \"$transparency\",
      \"location\": \"$location\",
      \"startTime\": \"$startTime\",
      \"endTime\": \"$endTime\",
      \"tags\": $tags
     }''';
  }
}

enum EventTransparency{
  OPAQUE,
  TRANSPARENT;

  @override
  String toString(){
    return name;
  }

  factory EventTransparency.fromText(String text){
    return EventTransparency.values.firstWhere((eventColor) => eventColor.name == text);
  }
}

enum EventType{
  DEFAULT,
  BIRTHDAY,
  FOCUS_TIME,
  FROM_GMAIL,
  OUT_OF_OFFICE,
  WORKING_LOCATION;

  @override
  String toString(){
    return name;
  }

  factory EventType.fromText(String text){
    return EventType.values.firstWhere((eventColor) => eventColor.name == text);
  }
}

enum EventColor {
/**
 * Possible colors for google calendar events
 * ref https://developers.google.com/apps-script/reference/calendar/event-color?hl=de
 */
  NONE,
  PALE_BLUE,
  PALE_GREEN,
  MAUVE,
  PALE_RED,
  YELLOW,
  ORANGE,
  CYAN,
  GRAY,
  BLUE,
  GREEN,
  RED;

  factory EventColor.fromId(int? id){
    return EventColor.values.firstWhere((eventColor) => eventColor.index == id, orElse: () => EventColor.NONE);
  }
  factory EventColor.fromColor(Color? color){
    return EventColor.values.firstWhere((eventColor) => eventColor.color == color, orElse: () => EventColor.NONE);
  }
  @override
  String toString(){
    return "${index != 0? index : ''}";
  }
}

extension ColorsExtension on EventColor {
  Color? get color {
    switch (this) {
      case EventColor.PALE_BLUE:
        return Color(0xFFA4BDFC);
      case EventColor.PALE_GREEN:
        return Color(0xFF7AE7BF);
      case EventColor.MAUVE:
        return Color(0xFFBDADFF);
      case EventColor.PALE_RED:
        return Color(0xFFFF887C);
      case EventColor.YELLOW:
        return Color(0xFFFBD75B);
      case EventColor.ORANGE:
        return Color(0xFFFFB878);
      case EventColor.CYAN:
        return Color(0xFF46D6DB);
      case EventColor.GRAY:
        return Color(0xFFE1E1E1);
      case EventColor.BLUE:
        return Color(0xFF5484ED);
      case EventColor.GREEN:
        return Color(0xFF51B749);
      case EventColor.RED:
        return Color(0xFFDC2127);
      case EventColor.NONE:
        return null;
    }
  }
}