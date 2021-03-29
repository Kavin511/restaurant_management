import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Constants.dart';
import 'package:restaurant_app/Services/Menu/MenuService.dart';
import 'package:restaurant_app/Utils/DecimalFormatter.dart';
import 'package:restaurant_app/db/bloc/menuBloc.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';

class AddMenu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<AddMenu> {
  int _value = 1;
  jwtDecoder jwt;

  @override
  void initState() {
    menuBloc = MenuBloc();
    jwt = jwtDecoder();
  }

  String category = "", foodType = "Veg";
  int dropDownValue = -1;
  var foodList = ['Snack', 'Fast food', 'Meals'];
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController foodPriceController = TextEditingController();
  final TextEditingController foodDescriptionController =
      TextEditingController();
  final imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  MenuBloc menuBloc;

  @override
  Widget build(BuildContext context) {
    void validateFoods() {
      if (_formKey.currentState.validate()) {
        setState(() {
          isLoading = !isLoading;
        });
        MenuService()
            .addMenu(
                foodNameController.text,
                foodDescriptionController.text,
                foodPriceController.text,
                category,
                foodType,
                imageUrlController.text)
            .then(
              (val) => {
                setState(() {
                  isLoading = !isLoading;
                }),
                close()
              },
              // Scaffold.of(context).showSnackBar(
              //     SnackBar(content: Text('Menu updated successfully'))),
            );
        menuBloc.fetchMenu();
      } else {
        // setState(() {
        //   isLoading = !isLoading;
        // });
      }
    }
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            close();
          },
        ),
        centerTitle: true,
        title: Text('Menu Food'),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: imageUrlController,
                      validator: (text) {
                        if (text.isEmpty || text.length < 4) {
                          return 'Enter food image url ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Food url",
                          labelText: 'Food url',
                          filled: true,
                          fillColor: const Color(0xFFf8f8f8),
                          focusedBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          prefixIcon: Icon(Icons.fastfood)),
                      cursorRadius: Radius.circular(100),
                      autocorrect: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: foodNameController,
                      validator: (text) {
                        if (text.isEmpty || text.length < 4) {
                          return 'Food name should be at least 4 characters ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Food name",
                          labelText: 'Food name',
                          filled: true,
                          fillColor: const Color(0xFFf8f8f8),
                          focusedBorder: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(width: 2.0),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          prefixIcon: Icon(Icons.fastfood)),
                      cursorRadius: Radius.circular(100),
                      autocorrect: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: foodDescriptionController,
                      validator: (text) {
                        if (text.isEmpty || text.length < 10) {
                          return 'Food description should have at least 10 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Food description",
                          labelText: 'Food description',
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
                          return 'Enter price of food Food';
                        }
                        return null;
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                          controller: foodPriceController,
                          decoration: InputDecoration(
                              hintText: "Food price",
                              labelText: 'Food price ₹',
                              filled: true,
                              fillColor: const Color(0xFFf8f8f8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              prefixIcon: Icon(Icons.attach_money)),
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
                          icon: Icon(Icons.keyboard_arrow_down),
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
                              // onTap: () => {category = val},
                              child: Text(val),
                              value: val,
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoButton(
                            color: kPrimaryColor,
                            child: Text('Add Food'),
                            onPressed: validateFoods,

                          )),
                      isLoading
                      ? Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(

                            strokeWidth: 3,
                            ),
                          ),
                        )
                      : Container(),
                ],
              )),
        ),
      ),
    ));
  }

  void close() {
    Get.back(
      closeOverlays: true,
    );
  }
}
