// normal Boxdecorations for containers
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentbox_vendor/res/style/colors.dart';

BoxDecoration kBoxDecoration(
    {double resHeight = 0,
    Color color = MyColors.white,
    double blurRadiusSizeOF = 0.035,
    double borderRadiusOf = 0.030}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(resHeight * borderRadiusOf),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 6),
        blurRadius: 6.0,
        spreadRadius: 2,
      ),
    ],
  );
}

InputDecoration commonTextfeildDecoration(double respHeight, String label) {
  return InputDecoration(
    labelText: label,
    floatingLabelStyle: TextStyle(
      fontSize: respHeight * 0.05,
      color: MyColors.black,
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular((respHeight * 0.02))),
    labelStyle: GoogleFonts.anybody(
        color: MyColors.black, fontSize: respHeight * 0.035),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(respHeight * 0.02)),
      borderSide: BorderSide(width: respHeight * 0.003, color: MyColors.red),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(respHeight * 0.02)),
      borderSide: BorderSide(width: respHeight * 0.003, color: MyColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(respHeight * 0.02)),
      borderSide: BorderSide(
        width: respHeight * 0.003,
        color: MyColors.grey,
      ),
    ),
    hintStyle: TextStyle(
      color: Colors.grey.shade500,
    ),
    fillColor: Colors.grey.shade300,
    filled: true,
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> commonSnackBar(
    {String text = '',
    Color bgColor = MyColors.white,
    Color textColor = MyColors.btnText,
    context}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    clipBehavior: Clip.hardEdge,
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.all(15.0),
    elevation: 6.0,
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    content: Text(
      text,
      style: TextStyle(color: textColor),
    ),
  ));
}
