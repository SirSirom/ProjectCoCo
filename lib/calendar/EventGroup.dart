import 'Event.dart';

/**
 * Class to group calendar events
 */
class EventGroup {
  /**
   * Title of the events they grouped by
   */
  String? title;

  /**
   * Color, events of the event group should have
   */
  EventColor? eventGroupColor;

  /**
   * Whether the event group is visible or not
   */
  bool isVisible = true;

  /**
   * Events of the event group
   */
  List<Event>? events;
}