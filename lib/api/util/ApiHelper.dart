import 'dart:convert';

import 'package:project_coco/api/models/EventModel.dart';
import 'package:project_coco/api/models/PropertyModel.dart';
import 'package:project_coco/signin/GoogleLogin.dart';
import 'package:http/http.dart' as http;

import '../models/CalendarModel.dart';
/**
 * Class to handle google api request
 */
class ApiHelper{
  static String endpoint = "https://script.google.com/macros/s/AKfycbyHxsZ4f_Q9UIUKAK7tk1ug0ZIPeaIRZTSVXT9KmsQ/dev/";

   static Future<http.Response> sendRequest(String uri,HttpMethod httpMethod,{Map<String, String>? additionalHeaders,Object? postBody}) async {
     Map<String,String> authHeaders = await GoogleLogin.getAuthHeaders();
     Map<String, String> finalHeaders = {...authHeaders,
       if (additionalHeaders != null) ...additionalHeaders
     };
     switch (httpMethod){
       case HttpMethod.POST:
         return await http.post(
             Uri.parse('$endpoint$uri'),
             headers: finalHeaders,
             body: postBody);
       case HttpMethod.GET:
         return await http.get(
             Uri.parse('$endpoint$uri'),
             headers: finalHeaders
        );
     }
   }

   static Future<Map<String, PropertyModel>> loadProperties() async{
     return PropertyModel.propertiesFromJson((await sendRequest('Properties', HttpMethod.GET)).body);
   }
  static Future<http.Response> saveProperties(Map<String, PropertyModel> properties)  async{
    return await sendRequest('Properties', HttpMethod.POST, postBody: "$properties");
  }
   static Future<http.Response> enableCalendar(String calendarId) async{
     return await sendRequest('$calendarId/Enable', HttpMethod.POST, postBody: "{}");
   }
   static Future<http.Response> disableCalendar(String calendarId) async{
     return await sendRequest('$calendarId/Disable', HttpMethod.POST, postBody: "{}");
   }
   static Future<List<CalendarModel>> loadCalendars() async {
     return CalendarModel.calendarsFromJson((await sendRequest('Calendars', HttpMethod.GET)).body);
   }
  static Future<List<CalendarModel>> loadEnabledCalendars() async {
    String body = (await sendRequest('Calendars', HttpMethod.GET)).body;
    List<CalendarModel> calendars = CalendarModel.calendarsFromJson(body);
    calendars.retainWhere((calendar) => calendar.registered);
    return calendars ;
  }
  static Future<List<EventModel>> loadEvents(String calendarId,{DateTime? startTime, DateTime? endTime}) async {
    return EventModel.eventsFromJson((await sendRequest('$calendarId/Events?startTime=${startTime?.toIso8601String()}&endTime=${endTime?.toIso8601String()}', HttpMethod.GET)).body);
  }
}

enum HttpMethod{ POST,GET}