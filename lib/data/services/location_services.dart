// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:cloudinary/cloudinary.dart';
import 'package:rentbox_vendor/models/location.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationServices {
  final Dio dio = Dio();
  Future<List<LocationModel>> getLocations(context) async {
    Response response = await dio.get(ApiUrls.baseUrl + ApiUrls.setup);

    try {
      // SHARED PRIFERENCE OBJECT
      final prefs = await SharedPreferences.getInstance();

      /// passing [ACCESTOKENS] in  header
      final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');

      dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";
      log(ACCESS_TOKEN);
      if (response.statusCode == 201) {
        List<LocationModel> locatiomModel = [];
        LocationModel mapJson = LocationModel.fromJson(response.data);
        locatiomModel.add(mapJson);
        return locatiomModel;
      }
    } catch (error) {
      commonException(context: context, error: error);
    }
    return [];
  }
}

commonException({error, context}) {
  if (error is DioError) {
    switch (error.type) {
      // ... rest of the switch case statements
      case DioErrorType.connectTimeout:
        commonSnackBar(context: context, text: 'Conecection Timeouted');
        break;
      case DioErrorType.sendTimeout:
        commonSnackBar(context: context, text: 'Conecection send timeout');
        break;
      case DioErrorType.receiveTimeout:
        commonSnackBar(context: context, text: 'Conecection receive timeout');
        break;
      case DioErrorType.response:
        commonSnackBar(context: context, text: 'No Response');
        break;
      case DioErrorType.cancel:
        commonSnackBar(context: context, text: 'Request canceled');
        break;
      case DioErrorType.other:
        commonSnackBar(context: context, text: 'some other error');
        break;
    }
  } else if (error is TypeError) {
    commonSnackBar(context: context, text: 'some other error');
    return;
  }
}
