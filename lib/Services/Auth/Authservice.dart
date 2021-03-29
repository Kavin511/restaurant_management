import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Constants.dart';

class AuthService {
  Dio dio = new Dio();

  login(mobileNumber, password) async {
    try {
      return await dio.post(restaurantUrl + "/login",
          data: {"mobileNumber": mobileNumber, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }


  addNew(name, address, mobileNumber, password, String email) async {
    try {
      return await dio.post(restaurantUrl + "/register", data: {
        "mobileNumber": mobileNumber,
        "password": password,
        "email": email,
        "hotelName": name,
        "address": address,
      });
    } on DioError catch (e) {
      Get.snackbar('Error occurred', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getInfo(tokens) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $tokens';
      return await dio.get(restaurantUrl + "/getInfo");
    } on DioError catch (e) {
      Get.snackbar('Error occurred', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
