// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:rentbox_vendor/view_model/Vendor%20Auth/otp.dart';

import '../../res/components/warning_widgets.dart';

class SignUpApiServices {
  /// SignUpApiServices
  /// Use Dio to post the data to the API.
  /// get values form the UI screen and make a new user
  /// if the user not alredy exisists.
  Future signUpApiServices(
      {required BuildContext context,
      required name,
      required password,
      required mobile}) async {
    try {
      log("otp send akum  eppo , waite cheyii ... eppo kittum");
      log("http://localhost:5001/vendor/signup");

      // This will genarate a response from the api
      Response response = await Dio().post(
          "http://192.168.0.169:5001/vendor/signup",
          data: {"name": name, "mobile": mobile, "password": password});
      // This will send the response to the UI screen
      // Printing the response from the above function
      log(response.toString());
      log("otp  sendikkunu , nokinok");
      log("signup code : ${response.statusCode}");
      if (response.statusCode == 201) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return OTPScreen(mobile: mobile);
            },
          ),
        );
      } else if (response.statusCode == 409) {
        log("message");
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'user already exists'),
        );
        return;
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'Server Down'),
        );
        return;
      } else if (response.statusCode == 503) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages()
              .commonSnackBar(text: 'Server Down,cant sent otp now'),
        );
        return;
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'Server Down'),
        );
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'Something Went Rong'),
        );
        return;
      }
    } catch (error) {
      log(error.toString());
      if (error is DioError) {
        handleDioError(context, error);
      } else {
        handleException(context, error);
      }
    }
  }

  void handleDioError(BuildContext context, DioError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      DialogeMessages().commonSnackBar(
          text: "Server Down ...\n ${error.message.toString()}"),
    );
  }

  void handleException(BuildContext context, dynamic exception) {
    ScaffoldMessenger.of(context).showSnackBar(
      DialogeMessages().commonSnackBar(text: exception.message.toString()),
    );
  }
}
/*
else if (response.statusCode! == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'user already exists'),
        );
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'Server Down'),
        );
      } else if (response.statusCode == 503) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages()
              .commonSnackBar(text: 'Server Down,cant sent otp now'),
        );
      } else if (response.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'Server Down'),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'Something Went Rong'),
        );
      }
*/
