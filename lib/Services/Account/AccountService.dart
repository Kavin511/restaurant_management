import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountService {
  Dio dio = new Dio();
  String base_URL = "https://restaurant-backend.herokuapp.com/restaurant";

  getProfile(mobileNumber) async {
    try {
      return await dio.get(base_URL + "/getProfile/" + mobileNumber,
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  changeRestaurantName(mobileNumber, hotelName) async {
    try {
      return await dio.patch(base_URL + "/updateprofile/" + mobileNumber,
          data: {"hotelName": hotelName},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  changeAddress(mobileNumber, hotelName) async {
    try {
      return await dio.patch(base_URL + "/updateprofile/" + mobileNumber,
          data: {"hotelName": hotelName},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  updateLocation(mobileNumber, hotelName) async {
    try {
      return await dio.patch(base_URL + "/updateprofile/" + mobileNumber,
          data: {"hotelName": hotelName},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
}
