import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistants
{
  static Future<dynamic> getRequest (String url) async{

    try{
      http.Response response = await http.get(Uri.parse(url));

      String jsonData = response.body;
      var decodeData = jsonDecode(jsonData);
      return decodeData;
    }catch(e){
      print(e);
      return "noData";
    }

  }

}