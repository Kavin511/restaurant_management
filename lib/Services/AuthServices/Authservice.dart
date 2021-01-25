import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AuthService {
  Dio dio = new Dio();
  login(name, password) async {
    try {
      return await dio.post(
          "https://restaurant-backend.herokuapp.com/authentication",
          data: {"name": name, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  addNew(name, password) async {
    try {
      return await dio.post("https://restaurant-backend.herokuapp.com/adduser",
          data: {"name": name, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  getInfo(tokens) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $tokens';
      return await dio.get("https://restaurant-backend.herokuapp.com/getinfo");
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['msg'].toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
