import 'package:flutter/material.dart';
import 'package:restaurant_app/UI/Dashboard/Screens/Menu/MenuTile.dart';
import 'package:restaurant_app/db/Model/menuModel.dart';

class MenuCard extends StatelessWidget {
  Menu menuData;

  MenuCard(this.menuData);

  @override
  Widget build(BuildContext context) {
    return MenuTile(
        foodName: menuData.foodName,
        foodDesc: menuData.foodDesc,
        price: menuData.price,
        foodType: menuData.foodType,
        availabiliy: menuData.availability);
  }
}
