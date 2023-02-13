// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/my_cars.dart';
import 'package:rentbox_vendor/res/style/colors.dart';
import 'package:rentbox_vendor/view_model/Vendor%20Auth/login.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  bool isLoggedIn;

  SplashScreen({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await Provider.of<MyCarsProvider>(context, listen: false)
    //       .getMyCars(context: context);
    // });

    log(isLoggedIn.toString());
    final rsize = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      duration: 3000,
      backgroundColor: Colors.black,
      splash: SizedBox(
        width: 5000,
        child: Center(
          child: Text(
            "RENTBOX- VENDOR",
            style: GoogleFonts.truculenta(
              color: MyColors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 10,
              fontSize: rsize.width * 0.1,
            ),
          ),
        ),
      ),
      nextScreen: isLoggedIn == true ? const HomeScreen() : LoginScreen(),
      // nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
