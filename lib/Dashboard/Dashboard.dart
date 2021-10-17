import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/Menu/Home.dart';
import 'Screens/Orders/Orders.dart';
import 'Screens/Profile/Account.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {
  int _pageIndex = 0;
  String text = "Restaurant";
  List<Widget> tabList = [Home(), Order(), Account()];
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
    Widget actionBarText() {
      return new Text(text);
    }
    return Scaffold(
        appBar: AppBar(
          title: actionBarText(),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) =>
          {
            setState(() => {
                  _pageIndex = index,
                }),
          },
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Menu')),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted), title: Text('Orders')),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervisor_account), title: Text('Account'))
          ],
        ),
        body: Center(
          child: tabList[_pageIndex],
        ));
  }
  onTabChanged(int index) {}

  void onPageChange(int value) {
    setState(() {
      this._pageIndex = value;
      this.text = value == 0 ? "Menu" : (value == 1 ? "Orders" : "Profile");
    });
  }
}
