import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/services/location_services.dart';
import 'package:rentbox_vendor/models/location.dart';

class LocationProvider with ChangeNotifier {
  /*----------------------CATAGORIZING DATA FROM API--------------------------*/
  // Get loacation Variables
  List<PickupPoint> locationPickupPoints = [];
  List<dynamic> locationID = [];
  List<dynamic> locationImage = [];
  List<dynamic> locationNames = [];

  /// child of locationPickupPoints
  List<String> pickupName = [];

  List<LocationModel> response = [];
  List<Location> locationDetailes = [];

  List<dynamic> id = [];
  List<DropdownMenuItem<String>> dropdownItems = [];
  // Function --> ( 1 )
  /// Response from the server(http://localhost:5001)
  getLocationResponse(context) async {
    final rsize = MediaQuery.of(context).size;
    // Response from  class HomeServise -location
    Provider.of<AddCarProvider>(context, listen: false).loading(true);
    notifyListeners();
    response.clear();

    response = await LocationServices().getLocations(context);

    notifyListeners();
    // Response of Locations setting data into
    // locatonMap  map
    log('enterd');
    if (response.isNotEmpty) {
      locationDetailes.clear();
      for (var element in response) {
        locationDetailes.addAll(element.locations);
      }

      locationID.clear();
      locationNames.clear();
      locationPickupPoints.clear();
      pickupName.clear();

      notifyListeners();
      for (var element in locationDetailes) {
        locationID.add(element.id);
        locationImage.add(element.image);
        locationNames.add(element.location);
        locationPickupPoints.addAll(element.pickupPoints);
        notifyListeners();
      }
      dropdownItems.clear();
      for (var element in locationPickupPoints) {
        id.add(element.id);
        pickupName.add(element.name);
        dropdownItems.add(
          DropdownMenuItem(
            alignment: Alignment.centerLeft,
            value: element.id,
            child: Padding(
              padding: EdgeInsets.only(left: rsize.width * 0.1),
              child: Text(
                element.name,
                style: TextStyle(fontSize: rsize.width * 0.032),
              ),
            ),
          ),
        );
        notifyListeners();
      }

      notifyListeners();
    } else {
      log(" check out on ---> lib/controller/provider/location.dart---> ( 1 )");
    }
    Provider.of<AddCarProvider>(context, listen: false).loading(false);
    notifyListeners();
  }
}
