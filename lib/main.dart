import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/data/provider/login_provider.dart';
import 'package:rentbox_vendor/data/provider/signup_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_model/Splash Screen/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignupProvider>(create: (_) => SignupProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(isLoggedIn: isLoggedIn),
        // home: MapScreen(),
      ),
    );
  }
}
