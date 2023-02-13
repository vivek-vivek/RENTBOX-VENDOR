import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/services/my_cars.dart';

import '../../models/mycars.dart';

class MyCarsProvider with ChangeNotifier {
  List<String> id = [];
  List<int> seatNum = [];
  List<Location> location = [];
  List<String> name = [];
  List<int> price = [];
  List<int> rcNumber = [];
  List<String> verified = [];
  List<List<String>> photos = [];
  List<MyCarsModel> response = [];

  List<dynamic> locationid = [];
  List<dynamic> locationName = [];

  Future getMyCars({context}) async {
    Provider.of<AddCarProvider>(context).loading(true);
    response.clear();
    response = await MyCarsService().fetchCars();
    for (var element in response) {
      id.add(element.id);
      seatNum.add(element.seatNum);
      location.add(element.location);
      name.add(element.name);
      price.add(element.price);
      rcNumber.add(element.rcNumber);
      verified.add(element.verified);
      photos.add(element.photos);
      notifyListeners();
    }

    for (var element in location) {
      locationid.add(element.id);
      locationName.add(element.location);
      notifyListeners();
    }
    notifyListeners();
    Provider.of<AddCarProvider>(context).loading(true);
  }
}
