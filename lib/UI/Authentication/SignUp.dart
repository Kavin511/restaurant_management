import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/Constants.dart';
import 'package:restaurant_app/Services/Auth/Authservice.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final phone_numer = TextEditingController();
  final password_controller = TextEditingController();
  final mail_controller = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: kTextColor),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 32.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.food_bank),
                labelText: 'Restaurant name',
              ),
            ),
            SizedBox(height: 12.0),
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
              controller: mail_controller,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.mail),
                labelText: 'Email',
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
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.location_on),
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton.filled(
                child: Text('Create Account'),
                onPressed: () async {
                  await AuthService()
                      .addNew(
                          nameController.text.toString().trim(),
                          addressController.text.toString().trim(),
                          phone_numer.text.toString().trim(),
                          password_controller.text.toString().trim(),
                          mail_controller.text.toString().trim())
                      .then((val) => {
                            if (val.data['success'])
                              {
                                Get.toNamed('/dashboard'),
                                Get.snackbar('Success ',
                                    'Account created successfully !',
                                    snackPosition: SnackPosition.BOTTOM),
                              }
                          });
                },
              ),
            ),
            SizedBox(height: 32.0),
            FlatButton(
                onPressed: () {
                  Get.back();
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: kTextColor, fontSize: 16)),
                    TextSpan(
                        text: 'Login',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 16)),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
