// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/models/mycars.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/constant/urls.dart';

class MyCarsService {
  Future<List<MyCarsModel>> fetchCars({context}) async {
    final dio = Dio();
    Provider.of<AddCarProvider>(context, listen: false).loading(true);
    // SHARED PRIFERENCE OBJECT
    final prefs = await SharedPreferences.getInstance();

    /// passing [ACCESTOKENS] in to header
    final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
    dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";
    log(" dxxgfchjhjlk $ACCESS_TOKEN");
    Response response =
        await dio.get(ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.myCars);

    if (response.statusCode == 201) {
      List<MyCarsModel> mycarS = [];
      log(response.data.toString());
      MyCarsModel mapJson = MyCarsModel.fromJson(response.data);
      mycarS.add(mapJson);
      return mycarS;
    } else {
      const CircularProgressIndicator();
    }
    return [];
  }
}
