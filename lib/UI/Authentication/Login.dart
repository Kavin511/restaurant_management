import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Constants.dart';
import 'package:restaurant_app/Services/Auth/Authservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phone_number = TextEditingController();
  final password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: kTextColor),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                Column(
                  children: <Widget>[
                    SizedBox(height: 70.0),
                    TextField(
                      controller: phone_number,
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
                    CupertinoButton.filled(
                      onPressed: () async {
                        AuthService()
                            .login(phone_number.text.toString().trim(),
                                password_controller.text.toString().trim())
                            .then((val) => {
                                  // if (val.data['success'])
                                  //   {
                                  AuthService()
                                      .getInfo(val.data['msg'])
                                      .then((value) => {
                                            if (value.data['success'])
                                              {
                                                saveLogin(val.data['msg']),
                                                Get.toNamed('/dashboard'),
                                                Get.snackbar('Success',
                                                    'Logged in successfully!',
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    )),
                                              }
                                          })
                                  // Get.toNamed('/dashboard')
                                  // }
                                });
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: FlatButton(
                  onPressed: () {
                    Get.toNamed('/signUp');
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Don\'t  have an account? ',
                          style: TextStyle(color: kTextColor, fontSize: 16)),
                      TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(color: Colors.blue, fontSize: 16))
                    ]),
                  )),
            )
          ],
        ),
      ),
    );
  }

  saveLogin(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
      print(prefs.getString('token'));
    });
  }
}
