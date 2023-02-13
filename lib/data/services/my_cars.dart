import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/models/mycars.dart';

import '../../res/constant/urls.dart';

class MyCarsService {
  final dio = Dio();

  Future<List<MyCarsModel>> fetchCars() async {
    Response response =
        await dio.get("${ApiUrls.baseUrl}${ApiUrls.auth}/myCars");

    if (response.statusCode == 201) {
      List<MyCarsModel> searchModel = [];
      MyCarsModel mapJson = MyCarsModel.fromJson(response.data);
      searchModel.add(mapJson);
      return searchModel;
    } else {
      const CircularProgressIndicator();
    }
    return [];
  }
}
