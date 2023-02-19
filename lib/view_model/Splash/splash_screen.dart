import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentbox_vendor/data/provider/change_data.dart';
import 'package:rentbox_vendor/data/provider/my_cars.dart';
import 'package:rentbox_vendor/view_model/Vendor%20Auth/login.dart';
import 'package:rentbox_vendor/view_model/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  bool isLoggedIn;

  SplashScreen({
    super.key,
    required this.isLoggedIn,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                widget.isLoggedIn == true ? const HomeScreen() : LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final prefs = await SharedPreferences.getInstance();
      final a = prefs.getString('Profile');
      Provider.of<ChangeBasicsProvider>(context, listen: false)
          .setProf(a.toString());
    });

    log(widget.isLoggedIn.toString());

    return const Scaffold(
      body: Center(
        child: Text("Vendor Box"),
      ),
    );
  }
}
// "lib/view/assets/images/spla.png",