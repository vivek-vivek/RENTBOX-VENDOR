import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:rentbox_vendor/data/services/booking_server.dart';
import 'package:rentbox_vendor/models/bookings_model.dart';
import 'package:rentbox_vendor/view_model/bookings/order_details.dart';

class BookingProvider extends ChangeNotifier {
  bool isLoading = false;
  /*------------------------------RESPONSE------------------------------------*/
  List<BookingModel> response = [];

  /*---------------------------API RESPONSE DATA-------------------------------*/

  List<Event> upCommingEvents = [];
  List<Event> completedEvents = [];

  /*----------------------------UPCOMMING CARS DATA----------------------------*/

  List<String> id = [];
  List<String> pickupDate = [];
  List<String> pickupTime = [];
  List<String> dropOffDate = [];
  List<String> dropOffTime = [];
  List<String> carId = [];
  List<String> userId = [];
  List<int> price = [];
  List<bool> pickupStatus = [];
  List<bool> dropOffStatus = [];

  List<Pickup> pickup = [];
  // List<CarData> carData = [];

  /*----------------------------PICKUP DATA------------------------------------*/

  List<String> name = [];
  List<String> pickupId = [];
  List<Coords> coords = [];

  /*--------------------------------COORDS------------------------------------*/

  List<double> lat = [];
  List<double> lng = [];

  /*------------------------------CAR DATA--------------------------------------*/

  List<String> newCarId = [];
  List<String> gearType = [];
  List<String> fuelType = [];
  List<int> seatNum = [];
  List<String> location = [];
  List<String> vendor = [];
  List<String> carName = [];
  List<int> totalPrice = [];
  List<int> rcNumber = [];

  List<dynamic> bookedTime = [];
  List<DateTime> bookedDates = [];
  List<dynamic> photos = [];
  List<String> pickupPoints = [];
  List<bool> status = [];

  void loading(bool valu) {
    isLoading = valu;
    notifyListeners();
  }

  refresh() {
    response.clear();
    upCommingEvents.clear();
    completedEvents.clear();
    id.clear();
    pickupDate.clear();
    pickupTime.clear();
    dropOffDate.clear();
    dropOffTime.clear();
    carId.clear();
    userId.clear();
    price.clear();
    pickupStatus.clear();
    dropOffStatus.clear();
    pickup.clear();
    // carData.clear();
    name.clear();
    pickupId.clear();
    coords.clear();
    lat.clear();
    lng.clear();
    newCarId.clear();
    gearType.clear();
    fuelType.clear();
    seatNum.clear();
    location.clear();
    vendor.clear();
    carName.clear();
    totalPrice.clear();
    rcNumber.clear();
    bookedTime.clear();
    bookedDates.clear();
    photos.clear();
    pickupPoints.clear();
  }

  upcomingEvents(context) async {
    status.clear();
    response.clear();
    upCommingEvents.clear();
    completedEvents.clear();
    id.clear();
    pickupDate.clear();
    pickupTime.clear();
    dropOffDate.clear();
    dropOffTime.clear();
    carId.clear();
    userId.clear();
    price.clear();
    pickupStatus.clear();
    dropOffStatus.clear();
    pickup.clear();
    // carData.clear();
    name.clear();
    pickupId.clear();
    coords.clear();
    lat.clear();
    lng.clear();
    newCarId.clear();
    gearType.clear();
    fuelType.clear();
    seatNum.clear();
    location.clear();
    vendor.clear();
    carName.clear();
    totalPrice.clear();
    rcNumber.clear();
    bookedTime.clear();
    bookedDates.clear();
    photos.clear();
    pickupPoints.clear();
    notifyListeners();
    response = await BookingServices().getResponse(context);
    notifyListeners();
    for (var element in response) {
      upCommingEvents.addAll(element.upComingEvents);
      log('response : ${element.upComingEvents}');

      notifyListeners();
    }
// UPCOMMING PICKUPS
    for (var element in upCommingEvents) {
      log('carname : ${element.name}');
      carName.add(element.name);
      gearType.add(element.gearType);
      photos.add(element.photos);
      fuelType.add(element.fuelType);
      rcNumber.add(element.rcNumber);
      seatNum.add(element.seatNum);
      carId.add(element.id);
      myorders.add(element.myOrders);
      notifyListeners();
    }

    for (var element in myorders) {
      exId.add(element.id);
      pickupDate.add(element.pickupDate);
      pickupTime.add(element.pickupTime);
      dropOffDate.add(element.dropOffDate);
      dropOffTime.add(element.dropOffTime);
      pickup.add(element.pickup);
      price.add(element.price);
      notifyListeners();
    }
    // PICKUP
    for (var element in pickup) {
      name.add(element.name);
      id.add(element.id);
      coords.add(element.coords);
      notifyListeners();
    }

    // COORDS
    for (var element in coords) {
      lat.add(element.lat);
      lng.add(element.lng);
      notifyListeners();
    }

    loading(false);

    notifyListeners();
  }

  ///---------------[Closed cars]
  ///
  List<MyOrders> myorders = [];
  List<String> exId = [];
  expiringEvents(context) async {
    loading(true);
    response.clear();
    completedEvents.clear();
    carName.clear();
    photos.clear();
    gearType.clear();
    fuelType.clear();
    rcNumber.clear();
    seatNum.clear();
    carId.clear();
    myorders.clear();
    exId.clear();
    pickupDate.clear();
    pickupTime.clear();
    dropOffDate.clear();
    dropOffTime.clear();
    pickup.clear();
    price.clear();
    name.clear();
    id.clear();
    coords.clear();
    lat.clear();
    lng.clear();
    response = await BookingServices().getResponse(context);
    notifyListeners();
    for (var element in response) {
      completedEvents.addAll(element.completedEvents);

      notifyListeners();
    }

    // UPCOMMING PICKUPS
    for (var element in completedEvents) {
      carName.add(element.name);
      gearType.add(element.gearType);
      photos.add(element.photos);
      fuelType.add(element.fuelType);
      rcNumber.add(element.rcNumber);
      seatNum.add(element.seatNum);
      carId.add(element.id);
      myorders.add(element.myOrders);
      notifyListeners();
    }

    for (var element in myorders) {
      exId.add(element.id);
      pickupDate.add(element.pickupDate);
      pickupTime.add(element.pickupTime);
      dropOffDate.add(element.dropOffDate);
      dropOffTime.add(element.dropOffTime);
      pickup.add(element.pickup);
      price.add(element.price);
      notifyListeners();
    }
    // PICKUP
    for (var element in pickup) {
      name.add(element.name);
      id.add(element.id);
      coords.add(element.coords);
      notifyListeners();
    }

    // COORDS
    for (var element in coords) {
      lat.add(element.lat);
      lng.add(element.lng);
      notifyListeners();
    }

    loading(false);
    notifyListeners();
  }
}
