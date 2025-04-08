class Event {
  /**
   * Id of the event
   */
  String? id;

  /**
   * Name of the event
   */
  String? name;

  /**
   * Event description
   */
  String? description;

  /**
   * Location of the event
   */
  String? location;

  /**
   * Start time of the event
   */
  DateTime? startTime;

  /**
   * End time of the event
   */
  DateTime? endTime;
}

/**
 * Possible colors for google calendar events
 * ref https://developers.google.com/apps-script/reference/calendar/event-color?hl=de
 */
enum EventColor {
  PALE_BLUE(id: 1,  color: "#a4bdfc"),
  PALE_GREEN(id: 2,  color: "#7AE7BF"),
  MAUVE(id: 3,  color: "#BDADFF"),
  PALE_RED(id: 4,  color: "#FF887C"),
  YELLOW(id: 5,  color: "#FBD75B"),
  ORANGE(id: 6,  color: "#FFB878"),
  CYAN(id: 7,  color: "#46D6DB"),
  GRAY(id: 8,  color: "#E1E1E1"),
  BLUE(id: 9,  color: "#5484ED"),
  GREEN(id: 10, color: "#51B749"),
  RED(id: 11, color: "#DC2127");

  const EventColor({
    required this.id,
    required this.color
  });

  final int id;
  final String color;
}