// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';

class SuccessSplash extends StatelessWidget {
  const SuccessSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      backgroundColor: Colors.black,
      splash: SizedBox(
        width: 200000,
        child: Center(
          child: CircleAvatar(
            radius: 100,
            child: Image.asset('lib/view/successgif.gif'),
          ),
        ),
      ),
      nextScreen: const HomeScreen(),
      // nextScreen: const HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
