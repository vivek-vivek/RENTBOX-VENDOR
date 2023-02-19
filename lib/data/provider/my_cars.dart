import 'dart:developer';

import 'package:flutter/material.dart';
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

  List<Car> cars = [];

  var index;
  bool isloading = false;
  loading(boolv) {
    isloading = boolv;
    log(boolv.toString());
    notifyListeners();
  }

  void setIndex(cindex) {
    index = cindex;
    notifyListeners();
  }

  Future getMyCars({required context}) async {
    loading(true);

    id.clear();
    seatNum.clear();
    location.clear();
    name.clear();
    price.clear();
    rcNumber.clear();
    verified.clear();
    photos.clear();
    cars.clear();
    response = await MyCarsService().fetchCars(context: context);

    for (var element in response) {
      cars.addAll(element.cars);
      notifyListeners();
    }
    for (var element in cars) {
      id.add(element.id);
      seatNum.add(element.seatNum);
      location.add(element.location);
      name.add(element.name);
      log(element.name);
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

    loading(false);
    notifyListeners();
  }
}
