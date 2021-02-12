import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuService {
  Dio dio = new Dio();
  String base_URL = "https://restaurant-backend.herokuapp.com/restaurant";

  addMenu(mobileNumber, foodName, foodDesc, price, category, foodType) async {
    try {
      return await dio.post(base_URL + "/addMenu",
          data: {
            "mobileNumber": 123457,
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
