import 'package:restaurant_app/db/Model/menuModel.dart';
import 'package:restaurant_app/db/Networking/MenuNetworking/MenuApiHelper.dart';

class MenuRepository {
  ApiHelper _helper = ApiHelper();

  Future<List<Menu>> getMenu(String mobileNumber) async {
    final response = await _helper.get('/getMenu/$mobileNumber');
    return MenuResponse.fromJson(response).menu;
  }
}