import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/UI_utils/Dashboard/Screens/Account.dart';
import 'package:restaurant_app/UI_utils/Dashboard/Screens/Home.dart';
import 'package:restaurant_app/UI_utils/Dashboard/Screens/Orders.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _pageIndex = 0;
  List<Widget> tabList = [Home(), Orders(), Account()];
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  void onTabTapped(int index) {}

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
            title: Text("Restaurant"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                semanticLabel: 'menu',
              ),
              onPressed: () {},
            )),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => {
            this._pageController.animateToPage(index,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInToLinear),
          },
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted_outlined),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account), label: 'Account')
          ],
        ),
        body: PageView(
          children: tabList,
          controller: _pageController,
          onPageChanged: onPageChange,
        ));
  }

  onTabChanged(int index) {}

  void onPageChange(int value) {
    setState(() {
      this._pageIndex = value;
    });
  }
}
