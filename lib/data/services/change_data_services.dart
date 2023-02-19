// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:cloudinary/cloudinary.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/bookings_provider.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/models/profile_model.dart';
import 'package:rentbox_vendor/res/components/box_componets.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileServices {
//                                                                             /
  ///-------------------------- [ Profile ] ----------------------------/

  Future getProfile({required context}) async {
    final dio = Dio();

    // SHARED PRIFERENCE OBJECT
    final prefs = await SharedPreferences.getInstance();

    /// passing [ACCESTOKENS] in to header
    final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
    dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";

    Response response =
        await dio.get(ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.profile);

    try {
      if (response.statusCode == 201) {
        log(response.data.toString());
        List<ProfileModel> profileModel = [];
        ProfileModel mapJson = ProfileModel.fromJson(response.data);
        profileModel.add(mapJson);
        return profileModel;
      }
    } catch (e, s) {
      log('+----------------------------ERROR---------------------+\n$e');
      log('+----------------------------SOURCE---------------------+\n$s');
    }

    return [];
  }

  //                                                                           /
  //                                                                           /
  //                                                                           /
  //                                                                           /
  ///-------------------------- [ send Otp ] ----------------------------------/

  Future<List<SendOtpModel>> sendOtpForEdit({required context}) async {
    try {
      final prov = Provider.of<ChangeBasicsProvider>(context, listen: false);

      final dio = Dio();

      // SHARED PRIFERENCE OBJECT
      final prefs = await SharedPreferences.getInstance();

      /// passing [ACCESTOKENS] in to header
      final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
      dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";

      Response response = await dio.post(
          ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.sendOtp,
          data: {'mobile': prov.mobileCtrl.text, 'name': prov.nameCtrl.text},
          options: Options(contentType: "application/json"));

      if (response.statusCode == 201) {
        // prov.pageTransaction(true);
        // prov2.loading(false);
        List<SendOtpModel> otpModel = [];
        SendOtpModel mapJson = SendOtpModel.fromJson(response.data);
        otpModel.add(mapJson);
        return otpModel;
      } else if (response.statusCode == 400) {
        log('invalid phone number');
        commonSnackBar(context: context, text: 'Mobile number alredy exisists');
        return [];
      }
    } catch (e, s) {
      log('+----------------------------ERROR---------------------+\n$e');
      log('+----------------------------SOURCE---------------------+\n$s');
    }
    return [];
  }

  //                                                                             /
  //                                                                             /
  //                                                                             /
  //                                                                             /
  ///-------------------------- [ Patch data ] ----------------------------------/
  Future<List<EditProfileWithOtp>> patchProfile(
      {required context, required String otp}) async {
    try {
      final prov = Provider.of<ChangeBasicsProvider>(context, listen: false);

      final dio = Dio();

      // SHARED PRIFERENCE OBJECT
      final prefs = await SharedPreferences.getInstance();

      /// passing [ACCESTOKENS] in to header
      final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
      dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";

      Response response = await dio.patch(
          ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.profile,
          data: {
            'mobile': prov.dummyMobile.text,
            'name': prov.dummyName.text,
            'otp': otp
          },
          options: Options(contentType: "application/json"));

      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        List<EditProfileWithOtp> otpModel = [];
        EditProfileWithOtp mapJson = EditProfileWithOtp.fromJson(response.data);
        otpModel.add(mapJson);
        return otpModel;
      } else {
        log('invalid phone number');
        commonSnackBar(context: context, text: 'Mobile number alredy exisists');
        return [];
      }
    } catch (e, s) {
      log('+----------------------------ERROR---------------------+\n$e');
      log('+----------------------------SOURCE---------------------+\n$s');
    }
    return [];
  }

  ///                                                                            /
  ///-------------------------- [ Profile image ] -------------------------------/
  Future<void> UploadProfilePic({required url, required context}) async {
    try {
      final dio = Dio();

      // SHARED PRIFERENCE OBJECT
      final prefs = await SharedPreferences.getInstance();

      /// passing [ACCESTOKENS] in to header
      final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
      dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";
      log('1');
      Response response = await dio.patch(
          ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.profilePic,
          data: {'profilePic': url},
          options: Options(contentType: "application/json"));

      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        final prov2 = Provider.of<BookingProvider>(context, listen: false);
        prov2.loading(false);
      } else {
        log('erorr');
        final prov2 = Provider.of<BookingProvider>(context, listen: false);
        prov2.loading(true);
      }
    } catch (e, s) {
      final prov2 = Provider.of<BookingProvider>(context, listen: false);
      prov2.loading(false);
      log('+----------------------------ERROR---------------------+\n$e');
      log('+----------------------------SOURCE---------------------+\n$s');
    }
  }
}
