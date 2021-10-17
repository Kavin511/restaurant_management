import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:restaurant_app/AppConstants.dart';
import 'package:restaurant_app/Model/LoginModel.dart';
import 'package:restaurant_app/Services/Auth/Authservice.dart';
import 'package:restaurant_app/bloc/authentication/LoginBloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phone_number = TextEditingController();
  final password_controller = TextEditingController();
  Login login;
  LoginBloc loginBloc;

  bool isLoading = false;
  bool isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edibles',
          style: TextStyle(
            color: kTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(height: 80.0),
                  TextFormField(
                    controller: phone_number,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (input) =>
                        input.length >= 10 ? null : "Enter valid phone number",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Phone number',
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: password_controller,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (input) => input.length >= 5
                        ? null
                        : "Enter password of at least 5 characters",
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(isPasswordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        )),
                    obscureText: isPasswordVisible,
                  ),
                  SizedBox(height: 12.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(10),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          triggerSignIn();
                        } else {
                          Get.snackbar(null, "Please enter all fields properly",
                              margin: EdgeInsets.all(10),
                              backgroundColor: kPrimaryColor,
                              colorText: Colors.white);
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  buildSignUpButton()
                ],
              ),
            ),
            Center(
              child: AbsorbPointer(
                absorbing: isLoading,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Visibility(
                    visible: isLoading,
                    child: Container(
                      color: Colors.white70,
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton buildSignUpButton() {
    return TextButton(
        onPressed: () {
          Get.offAllNamed('/signUp');
        },
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: 'Don\'t  have an account? ',
              style: TextStyle(color: kTextColor, fontSize: 16)),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(color: Colors.blueAccent, fontSize: 16))
        ])));
  }

  void triggerSignIn() {
    AuthService()
        .login(phone_number.text.toString().trim(),
            password_controller.text.toString().trim())
        .then((val) => {
              print(val),
              if (val.data['success'])
                {
                  setState(() {
                    isLoading = false;
                  }),
                  saveLogin(val.data['msg']),
                  Get.offAndToNamed('/dashboard'),
                }
              else
                {
                  setState(() {
                    isLoading = false;
                  }),
                  Get.snackbar("Error", val.data['message'],
                      margin: EdgeInsets.all(10),
                      backgroundColor: kPrimaryColor,
                      colorText: Colors.white)
                }
            })
        .catchErr((e) => {
              setState(() {
                isLoading = false;
              }),
              Get.snackbar('Error', e.toString(),
                  snackPosition: SnackPosition.BOTTOM)
            });
  }

  @override
  void initState() {
    super.initState();
    // loginBloc = LoginBloc(login);
  }

  saveLogin(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
      print(prefs.getString('token'));
    });
  }
}
