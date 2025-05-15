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
    return '''{
      "id": $id,
      "title": "$title",
      "description": "$description",
      "color": "$color",
      "eventType": "$eventType",
      "creators": $creators,
      "transparency": "$transparency",
      "location": "$location",
      "startTime": "$startTime",
      "endTime": "$endTime",
      "tags": $tags
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
/// Possible colors for google calendar events
/// ref https://developers.google.com/apps-script/reference/calendar/event-color?hl=de
  NONE(id: 0, color: null),
  PALE_BLUE(id: 1,  color: Color(0xFFA4BDFC)),
  PALE_GREEN(id: 2,  color: Color(0xFF7AE7BF)),
  MAUVE(id: 3,  color: Color(0xFFBDADFF)),
  PALE_RED(id: 4,  color: Color(0xFFFF887C)),
  YELLOW(id: 5,  color: Color(0xFFFBD75B)),
  ORANGE(id: 6,  color: Color(0xFFFFB878)),
  CYAN(id: 7,  color: Color(0xFF46D6DB)),
  GRAY(id: 8,  color: Color(0xFFE1E1E1)),
  BLUE(id: 9,  color: Color(0xFF5484ED)),
  GREEN(id: 10, color: Color(0xFF51B749)),
  RED(id: 11, color: Color(0xFFDC2127));

  final int id;
  final Color? color;

  const EventColor({
    required this.id,
    required this.color
  });

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