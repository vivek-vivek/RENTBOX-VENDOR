import 'package:animated_splash_screen/animated_splash_screen.dart';
// ignore: must_be_immutable
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  bool isLoggedIn;

  SplashScreen({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    log(isLoggedIn.toString());
    final rsize = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      duration: 3000,
      backgroundColor: Colors.black,
      splash: Container(
        width: 5000,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsNames.splashImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "RENTBOX",
            style: GoogleFonts.truculenta(
              color: CommonColors.kWhite,
              fontWeight: FontWeight.w700,
              letterSpacing: 16,
              fontSize: rsize.width * 0.1,
            ),
          ),
        ),
      ),
      nextScreen: isLoggedIn == true ? const MyAppScreen() : LoginScreen(),
      // nextScreen: const MyAppScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
