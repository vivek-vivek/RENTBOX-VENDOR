import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/res/components/warning_widgets.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpApiServices {
  /// OtpApiServices
  /// Use Dio to post the data to the API.
  /// get the mobile number from the textformfield and make and verify
  Future otpApiServices({
    required mobile,
    required otp,
    required context,
  }) async {
    try {
      //sending data to a server in the JSON format
      var json = jsonEncode({'mobile': mobile, 'otp': otp});
      var response = await Dio().post(
          ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.otpVerify,
          data: json,
          options: Options(contentType: "application/json"));
      log("otp status code : ${response.statusCode}");
      // If the request is successful,so get the access token from the response
      String accessToken = response.data['accessToken'];

      if (response.statusCode == 201) {
        // Get the shared preferences object
        final prefs = await SharedPreferences.getInstance();

        // Store the access token
        prefs.setString('access_token', accessToken);
        prefs.setBool('isLoggedIn', true);

        // to logout
        //final prefs = await SharedPreferences.getInstance();
        // prefs.remove("isLoggedIn");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (response.statusCode == 400) {
        //error message => Otp Is Incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'OOPS!!! Otp Is Incorrect !'),
        );
      }
    } on SocketException {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        DialogeMessages()
            .commonSnackBar(text: 'OOPS!!! No Internet Conection !'),
      );

      //Handling timeout error---------->
    } on DioError catch (e) {
      if (e.response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages()
              .commonSnackBar(text: 'OOPS!!! Something Went Wrong !'),
        );
        Navigator.of(context).pop();
      }
    } catch (error) {
      log(error.toString());
    }
  }
}
