import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/Authentication/SignUp.dart';
import 'package:restaurant_app/AppConstants.dart';
import 'package:restaurant_app/Dashboard/Dashboard.dart';
import 'package:restaurant_app/Dashboard/Screens/Menu/AddMenu.dart';
import 'package:restaurant_app/Dashboard/Screens/ProfileCompletion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/Login/Login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  static var route = [
    GetPage(name: '/', page: () => LoginPage()),
    GetPage(name: '/signUp', page: () => SignUp()),
    GetPage(name: '/dashboard', page: () => Dashboard()),
    GetPage(name: '/profileComplete', page: () => ProfileCompletion()),
    GetPage(name: '/menu', page: () => AddMenu()),
  ];
  final token;
  MyApp({this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColorBrightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor,displayColor: kMainColor)),
      home: token == null ? LoginPage() : Dashboard(),
      getPages: route,
      initialRoute: token == null ? '/' : "/dashboard",
    );
  }
}
