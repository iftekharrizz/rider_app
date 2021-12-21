// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rider_app/ComponentsAndConstants/components_constants.dart';
import 'package:rider_app/ComponentsAndConstants/divider.dart';
import 'package:rider_app/DataHandler/app_data.dart';
import 'package:rider_app/HttpAssistants/request_assistants.dart';
import 'package:rider_app/Models/place_prediction.dart';
import 'package:rider_app/services/config_maps.dart';

class SearchScreen extends StatefulWidget {
  static String idScreen = "SearchScreen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextController = TextEditingController();
  TextEditingController dropOffTextController = TextEditingController();
  List<PlacePredictions> predictionList = [];
  @override
  Widget build(BuildContext context) {
    String placeName =
        Provider.of<AppData>(context).pickUpLocation!.placeName ?? "";
    pickUpTextController.text = placeName;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              )
            ]),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 30.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Center(
                        child: Text(
                          "Set Drop Off",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: "Brand-Bold"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/pickicon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickUpTextController,
                              decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "images/desticon.png",
                        height: 16.0,
                        width: 16.0,
                      ),
                      SizedBox(
                        width: 18.0,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: dropOffTextController,
                              onChanged: (val) {
                                setState(() {
                                  val.length > 0 ?
                                  findPlace(val):predictionList.clear();
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Drop Off Location",
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          predictionList.isNotEmpty
              ? Container(
                  height: 143,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: AlwaysScrollableScrollPhysics(),
                      child: ListView.separated(
                        padding: EdgeInsets.all(0.0),
                        itemBuilder: (context, index) {
                          return PredictionTile(
                            placePredictions: predictionList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            DividerWidget(),
                        itemCount: predictionList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://api.tomtom.com/search/2/geocode/$placeName.json?limit=5&countrySet=CA&key=$autoCompSearchKey";
      var res = await RequestAssistants.getRequest(autoCompleteUrl);
      if (res.hashCode == 200) {
        print("nothing found");
      } else {
        var predictions = res["results"];

        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();
        print(predictions.toString());
        setState(() {
          predictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  const PredictionTile({Key? key, required this.placePredictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            width: 10.0,
          ),
          Row(
            children: [
              Icon(Icons.add_location),
              SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placePredictions.street_name.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      placePredictions.local_name.toString() +
                          " " +
                          placePredictions.country_subDivisionName.toString(),
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
