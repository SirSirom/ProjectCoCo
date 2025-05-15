import 'dart:convert';

import 'package:project_coco/signin/GoogleLogin.dart';
import 'package:http/http.dart' as http;
/**
 * Class to handle google api request
 */
class ApiHelper{

   static Future<http.Response> sendRequest(String uri,HttpMethod HTTPMethod,Object? postBody) async {

     Map<String,String> authHeaders = await GoogleLogin.getAuthHeaders();
     switch (HTTPMethod){
       case HttpMethod.POST:
         return await http.post(Uri.parse(uri),
             headers: authHeaders,
             body: postBody);
       case HttpMethod.GET:
         return await http.get(
             Uri.parse(uri),
             headers: authHeaders
        );
     }
   }
}

enum HttpMethod{ POST,GET}