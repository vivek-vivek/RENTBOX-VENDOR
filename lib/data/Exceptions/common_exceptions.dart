import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/res/components/warning_widgets.dart';

Future internetConncetionCheck(context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        DialogeMessages().commonSnackBar(text: 'No Internet concetion'),
      );
    }
  } on SocketException catch (_) {
    ScaffoldMessenger.of(context).showSnackBar(
      DialogeMessages().commonSnackBar(text: 'No Internet concetion'),
    );
  }
}

void handleDioError(BuildContext context, DioError error) {
  ScaffoldMessenger.of(context).showSnackBar(
    DialogeMessages()
        .commonSnackBar(text: "Server Down ...\n ${error.message.toString()}"),
  );
}

void handleException(BuildContext context, dynamic exception) {
  ScaffoldMessenger.of(context).showSnackBar(
    DialogeMessages().commonSnackBar(text: exception.message.toString()),
  );
}

///
///----------------------------- [Common Exception] -----------------------------/
///
class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error['message'];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
