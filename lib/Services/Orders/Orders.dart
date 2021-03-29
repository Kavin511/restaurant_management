import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderServices {
  String baseUrl = "https://fluttereats.herokuapp.com/flutterEats/";
  Dio dio = Dio();

  updateStatus(id, status) async {
    try {
      await dio.patch(baseUrl + 'orderStatus/${id}',
          data: {'status': status},
          options: Options(contentType: Headers.formUrlEncodedContentType),
          onSendProgress: (sent, total) => {
                Get.snackbar('Success', 'Status updated successfully',
                    snackPosition: SnackPosition.BOTTOM)
              });
    } on DioError catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }
}
