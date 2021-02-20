import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:restaurant_app/db/Model/menuModel.dart';
import 'package:restaurant_app/db/Networking/MenuNetworking/MenuResponse.dart';
import 'package:restaurant_app/db/Repository/MenuRepository.dart';
import 'package:restaurant_app/db/bloc/menuBloc.dart';

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

class _HomeState extends State<Home> {
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  MenuRepository menuRepository = new MenuRepository();
  MenuBloc menuBloc;
  String mobileNumber = "123457";
  Menu menu = new Menu();

  void onTap() {
    Get.toNamed(
      '/menu',
    );
  }

  @override
  void initState() {
    super.initState();
    menuBloc = MenuBloc(mobileNumber);
  } // void _goToNextPage() {
  //   Navigator.of(context)
  //       .push(FadeRouteBuilder(page: Menu()))
  //       .then((value) => setState(() => rect == null));
  // }

  // Widget _ripple() {
  //   if (rect == null) {
  //     return Container();
  //   }
  //   return AnimatedPositioned(
  //     duration: animationDuration,
  //     left: rect.left,
  //     right: MediaQuery.of(context).size.width - rect.right,
  //     top: rect.top,
  //     bottom: MediaQuery.of(context).size.height - rect.bottom,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.blueAccent,
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return menuBloc.fetchMenu(mobileNumber);
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
                        child: CircularProgressIndicator(),
                      ),
                    );
                    break;
                  case Status.COMPLETED:
                    return new MenuList(
                      menuData: snapshot.data.data,
                    );
                    break;
                  case Status.ERROR:
                    print('error');
                    return new Container(
                      child: Center(
                        child: Text('Network error'),
                      ),
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

class MenuList extends StatefulWidget {
  final List<Menu> menuData;

  const MenuList({Key key, this.menuData}) : super(key: key);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: widget.menuData.length,
            itemBuilder: (context, index) => MenuCard(widget.menuData[index])));
  }
}

class MenuCard extends StatelessWidget {
  Menu menuData;

  MenuCard(this.menuData);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(menuData.foodName),
      subtitle: Text(menuData.foodDesc),
      leading: CircleAvatar(
        child: Image.asset(
          'images/cover.jpg',
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
