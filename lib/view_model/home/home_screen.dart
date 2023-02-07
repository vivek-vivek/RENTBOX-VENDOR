import 'package:flutter/material.dart';
import 'package:rentbox_vendor/view_model/Splash%20Screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove("isLoggedIn");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SplashScreen(isLoggedIn: false)));
            },
            icon: const Icon(Icons.umbrella)),
      ),
    );
  }
}
