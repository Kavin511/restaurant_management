import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();
  String base_URL = "https://restaurant-backend.herokuapp.com/restaurant";
  login(name, password) async {
    try {
      return await dio.post(base_URL + "/login",
          data: {"mobileNumber": name, "password": password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.toString(),
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.grey,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  test() async {
    try {
      return await dio.post(base_URL);
    } on DioError catch (e) {
      print(e);
    }
  }

  addNew(mobileNumber, password) async {
    try {
      return await dio.post(base_URL + "/register", data: {
        "mobileNumber": mobileNumber,
        "password": password,
        "email": mobileNumber
      });
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.toString(),
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.grey,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }

  getInfo(tokens) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $tokens';
      return await dio.get(base_URL + "/getInfo");
    } on DioError catch (e) {
      // Fluttertoast.showToast(
      //     msg: e.response.data['msg'].toString(),
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.grey,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
    }
  }
}
