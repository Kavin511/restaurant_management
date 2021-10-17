import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/db/Networking/MenuNetworking/MenuException.dart';

class ProfileApiHelper {
  String baseURl = "https://restaurant-backend.herokuapp.com/restaurant";

  Future<dynamic> get(String endPoint) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(baseURl + endPoint));
      responseJson = _returnResponse(response);
    } on SocketException {}
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      default:
        throw MenuFetchDataException('Error occurred ${response.statusCode}');
    }
  }
}
