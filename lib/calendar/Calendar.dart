import 'package:color/color.dart';

import "EventGroup.dart";

/**
 * Class to import data of google calendars.
 */
class Calendar {
  /**
   * Id of the calendar
  */
  String? id;

  /**
   * Name of the calendar
   */
  String? name;

  /**
   * Calendar description
   */
  String? description;

  /**
   * Color of the calendar
   */
  Color? color;

  /**
   * List of event groups
   */
  List<EventGroup>? eventGroups;

  Calendar(String this.id, String this.name, String this.description, Color this.color, List<EventGroup> this.eventGroups);
}