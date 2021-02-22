import 'package:flutter/material.dart';
import 'package:restaurant_app/Services/Account/AccountService.dart';
import 'package:restaurant_app/db/bloc/profilebloc.dart';

class HotelNameBottomSheet extends StatefulWidget {
  @override
  _HotelNameBottomSheetState createState() => _HotelNameBottomSheetState();
}

class _HotelNameBottomSheetState extends State<HotelNameBottomSheet>
    with SingleTickerProviderStateMixin {
  AccountService accountService = AccountService();
  TextEditingController RestaurantNameController = TextEditingController();
  ProfileBloc profileBloc = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Wrap(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    controller: RestaurantNameController,
                    decoration: InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        icon: Icon(Icons.location_city)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                      onPressed: () => {
                            accountService.changeRestaurantName(
                                RestaurantNameController.text
                                            .toString()
                                            .trim()
                                            .length >
                                        0
                                    ? RestaurantNameController.text
                                        .toString()
                                        .trim()
                                    : "RestaurantName is empty"),
                            profileBloc.fetchProfile(),
                            SnackBar(
                                content:
                                    Text('Hotel name updated successfully !'))
                          },
                      icon: Icon(Icons.add),
                      label: Text('Add')),
                ),
                Container(
                  height: keyboardHeight,
                )
              ],
            ))
      ],
    );
  }
}
