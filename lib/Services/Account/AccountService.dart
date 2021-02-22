import 'package:dio/dio.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';
import 'package:restaurant_app/jwtDecoder/profileDecoder.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class AccountService {
  Dio dio = new Dio();
  String base_URL = "https://restaurant-backend.herokuapp.com/restaurant";
  jwtDecoder jwt = jwtDecoder();
  ProfileDecoder profileDecoder = ProfileDecoder();

  getProfile() async {
    var mobileNum = await jwt.decode();
    mobileNum = mobileNum.toString();
    try {
      var response = await dio.get(base_URL + "/getProfile/" + mobileNum,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      profileDecoder.decode(response.data['profile']);
    } on DioError catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  changeRestaurantName(hotelName) async {
    var mobileNumber = await jwt.decode();
    mobileNumber = mobileNumber.toString();
    try {
      return await dio.patch(base_URL + "/updateprofile/" + mobileNumber,
          data: {"hotelName": hotelName},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  changeAddress(address) async {
    var mobileNumber = await jwt.decode();
    mobileNumber = mobileNumber.toString();
    try {
      return await dio.patch(base_URL + "/updateprofile/" + mobileNumber,
          data: {"address": address},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  updateLocation(hotelName) async {
    var mobileNumber = await jwt.decode();
    mobileNumber = mobileNumber.toString();
    try {
      return await dio.patch(base_URL + "/updateprofile/" + mobileNumber,
          data: {"hotelName": hotelName},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
}
