import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
                Text('Login'),
              ],
            ),
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
                                        // Fluttertoast.showToast(
                                        //     msg: "Logged in successfully!",
                                        //     toastLength: Toast.LENGTH_LONG,
                                        //     gravity: ToastGravity.BOTTOM,
                                            //     backgroundColor: Colors.grey,
                                            //     textColor: Colors.white,
                                            //     fontSize: 16.0)
                                          }
                                      })
                  // Get.toNamed('/dashboard')
                          // }
                        });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 32.0),
            FlatButton(
                onPressed: () {
                  Get.toNamed('/signUp');
                },
                child: Text('Don\'t  have an account?Sign Up'))
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
