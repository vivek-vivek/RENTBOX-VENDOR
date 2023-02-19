// ignore_for_file: non_constant_identifier_names

// import 'package:dartz/dartz.dart';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/models/bookings_model.dart';
import 'package:rentbox_vendor/res/constant/urls.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BookingServices {
  /*---------------------------API DIO RESPONSE HANDLER------------------------*/
  Future<List<BookingModel>> getResponse(context) async {
    final Dio dio = Dio();
    log("a");
    // SHARED PRIFERENCE OBJECT
    final prefs = await SharedPreferences.getInstance();
    log('b');

    /// passing [ACCESTOKENS] in to header
    final dynamic ACCESS_TOKEN = prefs.getString('ACCESS_TOKEN');
    log('c');
    dio.options.headers["Authorization"] = "Bearer $ACCESS_TOKEN";
    log('d');

    /// GET [RESPONSE]

    Response response =
        await dio.get(ApiUrls.baseUrl + ApiUrls.auth + ApiUrls.bookings);
    log('fff');
    /*
   [pranv]
   Response response = await dio.get(ApiUrls.baseUrl + ApiUrls.bookings,options:Options(headers:{"Authorization":"Bearer $ACCESS_TOKEN"}));
    */
    try {
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        List<BookingModel> bookingModel = [];
        BookingModel mapJson = BookingModel.fromJson(response.data);
        bookingModel.add(mapJson);
        return bookingModel;
      }
    } catch (e, s) {
      log('+----------------------------ERROR---------------------+\n$e');
      log('+----------------------------SOURCE---------------------+\n$s');
    }
    // response is if null then return empty array
    return [];
  }
}

/*------------------------API RESPONSE EXCEPTION HANDLER----------------------*/
