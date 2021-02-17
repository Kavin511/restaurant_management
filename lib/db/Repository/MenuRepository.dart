import 'package:restaurant_app/db/Networking/MenuNetworking/MenuApiHelper.dart';

class MenuRepository {
  ApiHelper _helper = ApiHelper();

  Future<List<Menu>> fetchMenu() async {
    final response = await _helper.get('/menu');
  }
}