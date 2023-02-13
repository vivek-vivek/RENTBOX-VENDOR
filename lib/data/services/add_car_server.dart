// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:cloudinary/cloudinary.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/models/add_car_model.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCarServices {
  final dio = Dio();

  Future<void> addNewCar(context) async {
    Provider.of<AddCarProvider>(context, listen: false).loading(true);
    // SHARED PRIFERENCE OBJECT
    final pro = Provider.of<AddCarProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();

    /// passing [ACCESTOKENS] in to header
    final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
    dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";

    /// Data Object for Send Data in to API
    final addCarOrderModel = AddCarOrderModel(
      carData: CarData(
        modelName: pro.modelnamectrl.text.toString(),
        price: int.parse(pro.pricectrl.text),
        seatNum: pro.intseatNum,
        location: pro.districId.toString(),
        rcNumber: int.parse(pro.rcNumctrl.text),
        pickupPoints: pro.passPickupId,
        fuelType: pro.oilctrl.text,
        transmission: pro.gearctrl.text,
      ),
      photos: pro.cloudinoryCarURL,
      documents: pro.cloudinoryDoquementURL,
    );

    final response = await dio.post(
        ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.addCar,
        data: addCarOrderModel.toJson());
    log(response.statusCode.toString());
    log(response.data.toString());
    Provider.of<AddCarProvider>(context, listen: false).loading(false);
  }
}
