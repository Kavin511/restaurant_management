import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';

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

  void onTap() {
    // setState(() {
    //   rect = RectGetter.getRectFromKey(rectGetterKey);
    // });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide);
    //     Future.delayed(animationDuration + delay, _goToNextPage);
    //   });
    // });
    Get.toNamed(
      '/menu',
    );
  }

  // void _goToNextPage() {
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
        floatingActionButton: RectGetter(
          key: rectGetterKey,
          child: FloatingActionButton(
            onPressed: onTap,
            child: Icon(
              Icons.restaurant_menu,
              semanticLabel: "Add menu item",
            ),
          ),
        ),
        body: Center(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'No menu items to display\nClick',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Icon(
                  Icons.restaurant_menu,
                  color: Colors.lightBlue,
                ),
              )),
              TextSpan(
                  text: 'to add menu item',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ]),
          ),
        ));
  }
}
