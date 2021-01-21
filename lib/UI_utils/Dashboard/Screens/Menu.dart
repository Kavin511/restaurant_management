import 'dart:ui';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _value = 1;
  String dropDownValue;
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemDescriptionController = TextEditingController();
  bool itemNameValid = true, itemPriceValid = true, itemDescriptionValid = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Get.back(
                closeOverlays: true,
              );
            },
          ),
          centerTitle: true,
          title: Text('Menu item'),
          actions: [],
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (text) {
                      if (text.isEmpty || text.length < 2) {
                        return 'Enter at least two characters';
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
                        return 'Enter at least ten characters for description';
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
                      // FilteringTextInputFormatter.deny(filterPattern)
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
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          leading: Radio(
                              value: 2,
                              groupValue: _value,
                              activeColor: Colors.blueAccent,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              }),
                          title: Text('Non-Veg'),
                          onTap: () {
                            setState(() {
                              _value = 2;
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
                    hint: dropDownValue == null
                        ? Text('Select food category')
                        : Text(dropDownValue),
                    isExpanded: true,
                    iconSize: 30.0,
                    onChanged: (_value) {
                      setState(() {
                        dropDownValue = _value;
                      });
                    },
                    items: ['Snack', 'Fast food', 'Meals'].map((val) {
                      return DropdownMenuItem(
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
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shadowColor: Colors.blueAccent,
                        elevation: 7,
                      ),
                      onPressed: validateItems,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateItems() {
    if (_formKey.currentState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Menu updated successfully')));
    }
  }
}
