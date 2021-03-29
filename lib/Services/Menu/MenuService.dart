import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';
class MenuService {
  Dio dio = new Dio();
  String base_URL = "https://restaurant-backend.herokuapp.com/restaurant";
  jwtDecoder jwt = jwtDecoder();

  addMenu(foodName, foodDesc, price, category, foodType, imageUrl) async {
    var mobileNum = await jwt.decode();
    mobileNum = mobileNum.toString();
    Response response;
    try {
      print(mobileNum);
      response = await dio.patch(base_URL + "/updateMenu/$mobileNum",
          data: {
            "imageUrl": imageUrl.toString(),
            "foodName": foodName.toString(),
            "foodDesc": foodDesc.toString(),
            "category": category.toString(),
            "price": price.toString(),
            "foodType": foodType.toString(),
            "availability": true,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      SnackBar(content: Text(e.toString()));
    }
    return response;
  }

  deleteMenu(foodName, foodDesc, price, foodType) async {
    var mobileNum = await jwt.decode();
    mobileNum = mobileNum.toString();
    var res;
    try {
      res = await dio.delete(base_URL + "/deleteMenu/$mobileNum",
          data: {
            "foodName": foodName.toString(),
            "foodDesc": foodDesc.toString(),
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
      SnackBar(
        content: Text('Deleted successfully !'),
      );
    } on DioError catch (e) {
      SnackBar(
        content: Text(e.toString()),
      );
    }
  }
}
