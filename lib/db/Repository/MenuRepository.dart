import 'package:dio/dio.dart';
import 'package:restaurant_app/Model/menuModel.dart';
import 'package:restaurant_app/db/Networking/MenuNetworking/MenuApiHelper.dart';

class MenuRepository {
  ApiHelper _helper = ApiHelper();

  MenuRepository._privateConstructor();

  static final MenuRepository _menuRepository = MenuRepository
      ._privateConstructor();

  factory MenuRepository() {
    return _menuRepository;
  }

  dynamic response;

  Future<List<Menu>> getMenu(var mobileNumber) async {
    if (response == null)
      response = await _helper.get('/getMenu/$mobileNumber');
    return MenuResponse
        .fromJson(response)
        .menu;
  }
}