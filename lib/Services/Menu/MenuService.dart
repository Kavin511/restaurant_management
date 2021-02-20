import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';

class MenuService {
  Dio dio = new Dio();
  String base_URL = "https://restaurant-backend.herokuapp.com/restaurant";
  jwtDecoder jwt = jwtDecoder();

  addMenu(foodName, foodDesc, price, category, foodType) async {
    var mobileNum = await jwt.decode();
    try {
      return await dio.post(base_URL + "/updateMenu/$mobileNum",
          data: {
            "mobileNumber": mobileNum.toString(),
            "foodName": foodName,
            "foodDesc": foodDesc,
            "category": category,
            "price": price,
            "foodType": foodType,
            "availability": true,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: "Error while updating menu,Try after some time",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
