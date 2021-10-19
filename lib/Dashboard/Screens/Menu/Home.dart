import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:restaurant_app/AppConstants.dart';
import 'package:restaurant_app/Model/menuModel.dart';
import 'package:restaurant_app/bloc/menuBloc.dart';
import 'package:restaurant_app/db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:restaurant_app/db/Repository/MenuRepository.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';

import 'MenuList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

void onTap() {
  Get.toNamed(
    '/menu',
  );
}

class _HomeState extends State<Home> {
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  MenuRepository menuRepository = new MenuRepository();
  MenuBloc menuBloc;
  String mobileNumber = '';
  jwtDecoder jwt;
  bool refreshing = false;
  Menu menu = new Menu();

  @override
  void initState() {
    super.initState();
    jwt = jwtDecoder();
    menuBloc = MenuBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RectGetter(
        key: rectGetterKey,
        child: FloatingActionButton.extended(
          isExtended: true,
          onPressed: onTap,
          label: Text("Add Menu"),
          icon:  Icon(
            Icons.restaurant_menu,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.grey,
        onRefresh: () {
          setState(() {
            refreshing = true;
          });
          MenuRepository().response = null;
          return menuBloc.fetchMenu();
        },
        child: StreamBuilder<MenuApiResponse>(
            stream: menuBloc.menuListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    print('loading');
                    return new Container(
                      child: Center(
                        child: !refreshing
                            ? CircularProgressIndicator()
                            : Container(),
                      ),
                    );
                    break;
                  case Status.COMPLETED:
                    print('completed');
                    return new MenuList(
                      menuData: snapshot.data.data,
                    );
                    break;
                  case Status.ERROR:
                    print('error do');
                    return new Container(
                      child: Center(
                          child: Text('Error while fetching please try after some time')),
                    );
                    break;
                }
              }
              return Container();
            }),
      ),
    );
  }
}
