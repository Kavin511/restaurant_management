import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Services/Menu/MenuService.dart';
import 'package:restaurant_app/Utils/DecimalFormatter.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _value = 1;
  jwtDecoder jwt;

  @override
  void initState() {
    jwt = jwtDecoder();
  }

  String category = "", foodType = "Veg";
  int dropDownValue = -1;
  var foodList = ['Snack', 'Fast food', 'Meals'];
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemDescriptionController = TextEditingController();
  bool itemNameValid = true, itemPriceValid = true, itemDescriptionValid = true;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.chevron_left_sharp),
      //     onPressed: () {
      //       Get.back(
      //         closeOverlays: true,
      //       );
      //     },
      //   ),
      //   centerTitle: true,
      //   title: Text('Menu item'),
      //   actions: [],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text) {
                        if (text.isEmpty || text.length < 2) {
                          return 'Food name should be at least 2 characters ';
                        }
                        return null;
                      },
                      controller: itemNameController,
                      decoration: InputDecoration(
                          hintText: "Food name",
                          labelText: 'Item name',
                          filled: true,
                          fillColor: const Color(0xFFf8f8f8),
                          focusedBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          prefixIcon: Icon(Icons.fastfood_rounded)),
                      cursorRadius: Radius.circular(100),
                      autocorrect: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text) {
                        if (text.isEmpty || text.length < 2) {
                          return 'Food description should have at least 10 characters';
                        }
                        return null;
                      },
                      controller: itemDescriptionController,
                      decoration: InputDecoration(
                          hintText: "Food description",
                          labelText: 'Item description',
                          filled: true,
                          fillColor: const Color(0xFFf8f8f8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          prefixIcon: Icon(Icons.description)),
                      cursorRadius: Radius.circular(100),
                      autocorrect: true,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text) {
                        if (text.isEmpty || text.length < 2) {
                          return 'Enter price of food item';
                        }
                        return null;
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      controller: itemPriceController,
                      decoration: InputDecoration(
                          hintText: "Food price",
                          labelText: 'Item price ₹',
                          filled: true,
                          fillColor: const Color(0xFFf8f8f8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          prefixIcon: Icon(Icons.money)),
                      cursorRadius: Radius.circular(100),
                      autocorrect: true,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                                value: 1,
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                            title: Text('Veg'),
                            onTap: () {
                              setState(() {
                                _value = 1;
                                foodType = "Veg";
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            leading: Radio(
                                value: 2,
                                groupValue: _value,
                                // activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                            title: Text('Non-Veg'),
                            onTap: () {
                              setState(() {
                                _value = 2;
                                foodType = 'Non-Veg';
                              });
                            },
                          ),
                        )
                      ])),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      validator: (String value) {
                        if (value?.isEmpty ?? true) {
                          return 'Select suitable category';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFf8f8f8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                      icon: Icon(Icons.arrow_drop_down_circle_outlined),
                      hint: dropDownValue == -1
                          ? Text('Select food category')
                          : Text(foodList[dropDownValue]),
                      isExpanded: true,
                      iconSize: 30.0,
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value;
                        });
                      },
                      items: foodList.map((val) {
                        return DropdownMenuItem(
                          onTap: () => {category = val},
                          child: Text(val),
                          value: val,
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: Text('Add Food'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          onPrimary: Colors.white,
                          shadowColor: Colors.blueAccent,
                          elevation: 7,
                        ),
                        onPressed: validateItems,
                      )),
                  isLoading
                      ? Container(
                          child: Center(
                          child: CircularProgressIndicator(),
                        ))
                      : Container(),
                ],
              )),
        ),
      ),
    ));
  }

  void validateItems() async {
    var mobileNumber = await jwt.decode();
    if (_formKey.currentState.validate()) {
      MenuService()
          .addMenu(itemPriceController.text, itemDescriptionController.text,
              itemPriceController.text, category, foodType)
          .then((val) => {
                    setState(() {
                      isLoading = !isLoading;
                    }),
                    Get.back(
                      closeOverlays: true,
                    ),
                    Fluttertoast.showToast(
                        msg: "Menu added successfully!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
              // Scaffold.of(context).showSnackBar(
              //     SnackBar(content: Text('Menu updated successfully')))
              //
              // }
              );
    } else {
      print('Items req');
    }
  }
}
