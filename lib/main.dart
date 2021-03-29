import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:restaurant_app/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/Authentication/Login.dart';
import 'UI/Authentication/SignUp.dart';
import 'UI/Dashboard/Dashboard.dart';
import 'UI/Dashboard/Screens/Menu/AddMenu.dart';
import 'UI/Dashboard/Screens/ProfileCompletion.dart';

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
    GetPage(name: '/menu', page: () => AddMenu(), curve: Curves.fastOutSlowIn),
  ];
  final token;
  MyApp({this.token});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.leftToRightWithFade,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColorBrightness: Brightness.dark,
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor)),
      home: token == null ? LoginPage() : Dashboard(),
      getPages: route,
      initialRoute: token == null ? '/' : "/dashboard",
    );
  }
}
