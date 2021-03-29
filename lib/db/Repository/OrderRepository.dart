import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:restaurant_app/db/Model/OrderModal.dart';
import 'package:restaurant_app/db/Networking/OrderNetworking/OrderApiHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  OrderApiHelper _helper = OrderApiHelper();

  Future<List<OrderModal>> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String yourToken = prefs.getString('token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    var number = decodedToken['mobileNumber'].toString();
    print(decodedToken);
    final response = await _helper.get('/restaurantOrderDetails/${number}');
    print(response);
    return OrderResponse.fromJson(response).order;
  }
}
