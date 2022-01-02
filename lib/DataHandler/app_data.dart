import 'package:flutter/cupertino.dart';
import 'package:rider_app/Models/address.dart';
import 'package:flutter/foundation.dart';

class AppData extends ChangeNotifier{

  Address? pickUpLocation;
  String? userName;


  void updatePickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
  void setName(String name){
    userName=name;
    notifyListeners();
  }


}