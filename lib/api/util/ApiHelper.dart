import 'package:project_coco/api/models/EventModel.dart';
import 'package:project_coco/api/models/PropertyModel.dart';
import 'package:project_coco/signin/GoogleLogin.dart';
import 'package:http/http.dart' as http;

import '../models/CalendarModel.dart';
/**
 * Class to handle google api request
 */
class ApiHelper{
  /// Sets the endpoint for the api
  /// different release states possible
  static String endpoint = "https://script.google.com/macros/s/AKfycbyHxsZ4f_Q9UIUKAK7tk1ug0ZIPeaIRZTSVXT9KmsQ/dev/";

   static Future<http.Response> sendRequest(String uri,HttpMethod httpMethod,{Map<String, String>? additionalHeaders,Object? postBody}) async {
     /// Get the auth headers and append them to possible additionals
     Map<String,String> authHeaders = await GoogleLogin.getAuthHeaders();
     Map<String, String> finalHeaders = {...authHeaders,
       if (additionalHeaders != null) ...additionalHeaders
     };

     ///Handle Requests
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
     ///send Request and Parse by method from PropertyModel
     return PropertyModel.propertiesFromJson((await sendRequest('Properties', HttpMethod.GET)).body);
   }
   static Future<http.Response> saveProperties(Map<String, PropertyModel> properties)  async{
     ///send Post to save properties on AppScript
     return await sendRequest('Properties', HttpMethod.POST, postBody: "$properties");
   }
   static Future<http.Response> enableCalendar(String calendarId) async{
     ///send Post to enable calendar on AppScript
     return await sendRequest('$calendarId/Enable', HttpMethod.POST, postBody: "{}");
   }
   static Future<http.Response> disableCalendar(String calendarId) async{
     ///send Post to disable calendar on AppScript
     return await sendRequest('$calendarId/Disable', HttpMethod.POST, postBody: "{}");
   }
   static Future<List<CalendarModel>> loadCalendars() async {
     ///send Request and Parse by method from CalendarModel
     return CalendarModel.calendarsFromJson((await sendRequest('Calendars', HttpMethod.GET)).body);
   }
   static Future<List<CalendarModel>> loadEnabledCalendars() async {
     ///send Request and Parse by method from CalendarModel
     String body = (await sendRequest('Calendars', HttpMethod.GET)).body;
     List<CalendarModel> calendars = CalendarModel.calendarsFromJson(body);
     ///retain only calendars that are registered
     calendars.retainWhere((calendar) => calendar.registered);
     return calendars ;
   }

   static Future<List<EventModel>> loadEvents(String calendarId,{DateTime? startTime, DateTime? endTime}) async {
     ///send Request and Parse by method from EventModel
     ///use startTime and endTime in Iso8601 to filter events
     return EventModel.eventsFromJson((await sendRequest('$calendarId/Events?startTime=${startTime?.toIso8601String()}&endTime=${endTime?.toIso8601String()}', HttpMethod.GET)).body);
   }
}

///enum to handle Http Methods
enum HttpMethod{ POST,GET}