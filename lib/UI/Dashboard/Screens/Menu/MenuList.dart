import 'package:flutter/material.dart';
import 'package:restaurant_app/UI/Dashboard/Screens/Menu/MenuCard.dart';
import 'package:restaurant_app/db/Model/menuModel.dart';

class MenuList extends StatefulWidget {
  final List<Menu> menuData;

  const MenuList({Key key, this.menuData}) : super(key: key);

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    print(widget.menuData);
    return Scaffold(
        body: ListView.builder(
            itemCount: widget.menuData.length,
            itemBuilder: (context, index) => MenuCard(widget.menuData[index])));
  }
}
