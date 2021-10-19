import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:restaurant_app/AppConstants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Dio dio = new Dio();

  login(mobileNumber, password) async {
    return await dio.post(restaurantUrl + "/login",
        data: {"mobileNumber": mobileNumber, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
        onSendProgress: (sent, total) {
      if (sent != total)
        Get.snackbar('Logging in', 'Authenticated !',
            showProgressIndicator: true, snackPosition: SnackPosition.BOTTOM);
      else
        Get.snackbar('Processing!', '',
            duration: Duration(seconds: 100),
            snackPosition: SnackPosition.BOTTOM);
    });
  }

  addNew(name, mobileNumber, password, String email) async {
    try {
      return await dio.post(restaurantUrl + "/register",
          data: {
            "mobileNumber": mobileNumber,
            "password": password,
            "email": email,
            "hotelName": name,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Get.snackbar('Error occurred', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  getInfo(tokens) async {
    dio.options.headers['Authorization'] = 'Bearer $tokens';
    return await dio.get(restaurantUrl + "/getInfo");
  }
}
