import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'file:///D:/C%20files/AndroidStudioProjects/restaurant_app/lib/Services/Auth/Authservice.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final phone_numer = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                // Image.asset('assets/diamond.png')
                Icon(Icons.person_outline, size: 50.0),
                SizedBox(height: 16.0),
                Text('Create Account'),
              ],
            ),
            SizedBox(height: 70.0),
            TextField(
              controller: phone_numer,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.phone_android),
                labelText: 'Phone number',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: password_controller,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 12.0),
            // ButtonBar(
            //   alignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     // FlatButton(
            //     //   child: Text('CANCEL'),
            //     //   onPressed: () {
            //     //     Get.back();
            //     //   },
            //     // ),
            //
            //   ],
            // ),
            CupertinoButton.filled(
              child: Text('Create Account'),
              onPressed: () {
                AuthService()
                    .addNew(phone_numer.text.toString().trim(),
                        password_controller.text.toString().trim())
                    .then((val) => {
                          if (val.data['success'])
                            {
                              Get.toNamed('/dashboard'),
                              // Fluttertoast.showToast(
                              //     msg: val.data['msg'].toString(),
                              //     toastLength: Toast.LENGTH_LONG,
                              //     gravity: ToastGravity.BOTTOM,
                              //     backgroundColor: Colors.grey,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0)
                            }
                        });
              },
            ),
            SizedBox(height: 32.0),
            FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Already have an account? Login'))
          ],
        ),
      ),
    );
  }
}
