// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/res/components/warning_widgets.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApiServices {
  Future loginApiServices({mobile, password, context}) async {
    try {
      log("hi ");
      log("$mobile $password");
      Response response = await Dio()
          .post("${ApiUrls.baseUrl}${ApiUrls.auth}${ApiUrls.login}", data: {
        "mobile": mobile,
        "password": password,
      });

      log(response.statusCode.toString());

      // LOGIN coplete
      if (response.statusCode == 201) {
        // SHARED PRIFERENCE OBJECT
        final prefs = await SharedPreferences.getInstance();

        // ACCESS TOKEN
        String ACCESS_TOKEN = response.data['accessToken'];
        prefs.setString('ACCESS_TOKEN', ACCESS_TOKEN);

        // LOGIN OR NOT
        prefs.setBool('isLoggedIn', true);

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      } else if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
            DialogeMessages().commonSnackBar(text: 'user note found!'));
        return;
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(DialogeMessages()
            .commonSnackBar(
                text:
                    'User Not Found With This Information ,Try to signup again'));
      }
    } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(
          DialogeMessages().commonSnackBar(text: 'time outed request'));
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(DialogeMessages()
          .commonSnackBar(text: 'OOPS!!! No Internet Conection !'));
    } catch (error) {
      if (error is DioError) {
        handleDioError(context, error);
      } else {
        log(error.toString());
      }
    }
  }

  void handleDioError(BuildContext context, DioError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      DialogeMessages().commonSnackBar(
          text: "Server Down ...\n ${error.message.toString()}"),
    );
  }
}
