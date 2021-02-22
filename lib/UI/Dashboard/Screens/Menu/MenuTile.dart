import 'package:flutter/material.dart';
import 'package:restaurant_app/Services/Menu/MenuService.dart';
import 'package:restaurant_app/UI/Dashboard/Screens/Menu/MenuDescTile.dart';
import 'package:restaurant_app/db/bloc/menuBloc.dart';

class MenuTile extends StatefulWidget {
  MenuTile({
    Key key,
    this.foodName,
    this.foodDesc,
    this.price,
    this.foodType,
    this.availabiliy,
  }) : super(key: key);

  final String foodName;
  final String foodDesc;
  final String price;
  final String foodType;
  final String availabiliy;

  @override
  _MenuTileState createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  final GlobalKey _menuKey = new GlobalKey();
  MenuService menuService;
  MenuBloc menuBloc;

  @override
  void initState() {
    super.initState();
    menuService = MenuService();
    menuBloc = MenuBloc();
  }
  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
        key: _menuKey,
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text('Delete'), value: 'Delete'),
            ],
        onSelected: (_) async {
          menuService.deleteMenu(
              widget.foodName, widget.foodDesc, widget.price, widget.foodType);
          menuBloc.fetchMenu();
        });
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: InkWell(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/food.jpg'),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                    child: MenuDescTile(
                      foodName: widget.foodName,
                      foodDesc: widget.foodDesc,
                      foodType: widget.foodType,
                      price: widget.price,
                      availabiliy: widget.availabiliy,
                    )),
              ),
              button
            ],
          ),
        ),
      ),
    );
  }
}
