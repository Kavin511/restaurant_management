import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Model/profileModel.dart';
import 'package:restaurant_app/Services/Account/AccountService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HotelNameCompletionSheet.dart';

class ProfilePage extends StatefulWidget {
  final Profile profileData;

  const ProfilePage({Key key, this.profileData}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * .4,
            child: Stack(
              children: [
                new Container(
                    width: size.width,
                    height: size.height * .4 - 50,
                    child: Image.asset(
                      'images/cover.jpg',
                      width: size.width,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      width: 118,
                      height: 118,
                      // color: Colors.white,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'images/user.png',
                      ),
                    ))
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: RichText(
          //       text: TextSpan(
          //           recognizer: TapGestureRecognizer()
          //             ..onTap = () {
          //               showModalBottomSheet(
          //                   context: context,
          //                   builder: (BuildContext context) {
          //                     return Container(
          //                         width: 100,
          //                         color: Colors.blue,
          //                         child: Padding(
          //                             padding: EdgeInsets.only(
          //                                 bottom: MediaQuery.of(context)
          //                                     .viewInsets
          //                                     .bottom),
          //                             child: TextField()));
          //                   });
          //             },
          //           text: 'Mobile number',
          //           style: DefaultTextStyle.of(context).style),
          //       softWrap: true),
          // ),
          Card(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                            text: '+91- ${widget.profileData.mobileNumber} '),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.smartphone,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                            text: '${widget.profileData.email} '),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.mail,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return ModalBottomSheet();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                            text:
                                '${widget.profileData.address != null ? widget.profileData.address : "Click here to add address "} '),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_city,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return HotelNameBottomSheet();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18),
                            text:
                                '${widget.profileData.hotelName != null ? widget.profileData.hotelName : "Click here to Add hotel name"}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.food_bank,
                        color: Colors.black87,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () async {
                await removeLogin();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18),
                            text: 'Logout'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.logout,
                        color: Colors.redAccent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  removeLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    return Get.offAllNamed('/signUp');
  }
}

class ModalBottomSheet extends StatefulWidget {
  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  AccountService accountService = AccountService();
  TextEditingController addressController = TextEditingController();

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
                    controller: addressController,
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
                            accountService
                                .changeAddress(addressController.text
                                            .toString()
                                            .trim()
                                            .length >
                                        0
                                    ? addressController.text.toString().trim()
                                    : "Address is empty")
                                .then(() => {Navigator.of(context).pop()})
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
