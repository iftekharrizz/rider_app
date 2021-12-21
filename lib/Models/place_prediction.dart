// ignore_for_file: non_constant_identifier_names

class PlacePredictions{
  String? street_name;
  String? local_name;
  String? country_subDivisionName;

  PlacePredictions({this.street_name,this.local_name,this.country_subDivisionName});

  PlacePredictions.fromJson(Map<String, dynamic>json){
    street_name = json["address"]["streetName"];
    local_name = json["address"]["localName"];
    country_subDivisionName = json["address"]["countrySubdivisionName"];
  }


}