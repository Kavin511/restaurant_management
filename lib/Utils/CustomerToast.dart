import 'package:flutter/material.dart';
import 'package:get/get.dart';

successToast(String title, String message) {
  Get.snackbar(title, message,margin: EdgeInsets.all(10),backgroundColor: Colors.lightGreen);
}

failureToast(String title, String message) {
  Get.snackbar(title, message,margin: EdgeInsets.all(10),backgroundColor: Colors.redAccent);
}