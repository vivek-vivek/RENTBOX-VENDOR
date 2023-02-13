import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rentbox_vendor/data/provider/add_car.dart';
import 'package:rentbox_vendor/data/provider/location_proivider.dart';
import 'package:rentbox_vendor/data/provider/login_provider.dart';
import 'package:rentbox_vendor/data/provider/my_cars.dart';
import 'package:rentbox_vendor/data/provider/signup_provider.dart';
import 'package:rentbox_vendor/view_model/Google%20Map/map_screen.dart';
import 'package:rentbox_vendor/view_model/Rent%20My%20Cars/rent_my_car.dart';
import 'package:rentbox_vendor/view_model/Rent%20My%20Cars/sucess.dart';
import 'package:rentbox_vendor/view_model/product/product_landing_screen.dart';
import 'package:rentbox_vendor/view_model/product/single_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view_model/Splash/splash_screen.dart';

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
        ChangeNotifierProvider<AddCarProvider>(create: (_) => AddCarProvider()),
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<MyCarsProvider>(create: (_) => MyCarsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/allCars': (context) => const ProductLandingScreen(),
          '/singleProduct': (context) => const SingleProductScreen(),
          '/mapScreen': (context) => const MapScreen(),
          '/rentMyCar': (context) => const RentMyCar(),
          '/succesSplash': (context) => const SuccessSplash(),
        },
        home: SplashScreen(isLoggedIn: isLoggedIn),
        // home: MapScreen(),
      ),
    );
  }
}
