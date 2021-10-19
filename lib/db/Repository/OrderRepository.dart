import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:restaurant_app/Model/OrderModal.dart';
import 'package:restaurant_app/db/Networking/OrderNetworking/OrderApiHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepository {
  OrderApiHelper _helper = OrderApiHelper();

  OrderRepository._internal();

  static final OrderRepository _orderRepository = OrderRepository._internal();

  factory OrderRepository() {
    return _orderRepository;
  }

  dynamic response;

  Future<List<OrderModal>> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String yourToken = prefs.getString('token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(yourToken);
    var number = decodedToken['mobileNumber'].toString();
    if (response == null)
      response = await _helper.get('/restaurantOrderDetails/${number}');
    return OrderResponse.fromJson(response).order;
  }
}
