import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/HttpAssistants/request_assistants.dart';
import 'package:rider_app/Models/address.dart';
import 'package:rider_app/services/config_maps.dart';

class AssistantMethods {
  static Future<String?> searchCoordinatesAddress (Position position, BuildContext context) async {
    String placeAddress = "";
    String url = "http://api.positionstack.com/v1/reverse?access_key=$revGeoKey&query=${position.latitude},${position.longitude}&limit=1";
    var response = await RequestAssistants.getRequest(url);

    if(response != "noData"){

      String street = response["data"][0]["name"];
      String locality = response["data"][0]["region"];
      placeAddress = street +", "+locality;


      Address userPickUpAddress = Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
      
      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);



      return placeAddress;
    }
  }
}
