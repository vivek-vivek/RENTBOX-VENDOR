// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

class CommonTextformfelid extends StatelessWidget {
  CommonTextformfelid(
      {super.key,
      required this.rsize,
      required this.hintText,
      this.height = 0.15,
      required this.width,
      required this.controller,
      // required this.texttype,
      required this.errormessage,
      this.seat = false});

  final Size rsize;
  final String hintText;
  num height;
  num width;
  TextEditingController controller;
  // TextInputType texttype;
  String errormessage;
  bool seat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: rsize.width * 0.04),
      child: Container(
        padding: EdgeInsets.only(left: rsize.width * 0.04),
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(rsize.width * 0.02),
          ),
        ),
        child: TextFormField(
          // keyboardType: texttype,
          controller: controller,
          decoration:
              InputDecoration(hintText: hintText, border: InputBorder.none),
          validator: (value) {
            if (value!.isEmpty) {
              return errormessage;
            } else if (seat == true) {
              if (value.isNotEmpty && !RegExp(r'^\d+$').hasMatch(value)) {
                return 'Please enter Valid Number';
              } else if (value.isNotEmpty) {
                final intValue = int.tryParse(value);
                if (intValue == null || intValue <= 1) {
                  return 'Please enter a value greater than 1';
                }
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
