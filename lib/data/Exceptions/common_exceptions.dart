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
