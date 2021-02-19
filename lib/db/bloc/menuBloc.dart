import 'dart:async';

import 'package:restaurant_app/db/Model/menuModel.dart';
import 'package:restaurant_app/db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:restaurant_app/db/Repository/MenuRepository.dart';

class MenuBloc {
  MenuRepository _menuRepository;
  StreamController _controller;

  StreamSink<MenuApiResponse<List<Menu>>> get menuListSink => _controller.sink;

  Stream<MenuApiResponse<List<Menu>>> get menuListStream => _controller.stream;

  MenuBloc(String mobileNumber) {
    _controller = StreamController<MenuApiResponse<List<Menu>>>();
    _menuRepository = MenuRepository();
    fetchMenu(mobileNumber);
  }

  fetchMenu(String mobileNumber) async {
    menuListSink.add(MenuApiResponse.loading('Getting menu available'));
    try {
      List<Menu> menuList = await _menuRepository.getMenu(mobileNumber);
      menuListSink.add(MenuApiResponse.completed(menuList));
    } catch (e) {
      menuListSink.add(MenuApiResponse.error('Error occurred'));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
  }
}
