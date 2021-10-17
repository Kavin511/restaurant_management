import 'package:flutter/material.dart';
import 'package:restaurant_app/Model/menuModel.dart';

import 'MenuTile.dart';

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
        availabiliy: menuData.availability,
        imageUrl: menuData.imageUrl);
  }
}
