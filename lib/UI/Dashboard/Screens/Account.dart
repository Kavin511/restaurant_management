import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final profileState = GlobalKey<_AccountState>();
  bool profileCompleted = false;
  String mobileNumber;

  void onTap() {
    Get.toNamed(
      '/profileComplete',
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height * .4,
        child: Column(
          children: [
            Stack(
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
                      width: 120,
                      height: 120,
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
            RichText(
                text: TextSpan(
                    text: 'Mobile number',
                    style: DefaultTextStyle.of(context).style),
                softWrap: true)
          ],
        ),
      ),
    );
  }
}
