import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/AppConstants.dart';
import 'package:restaurant_app/Services/Auth/Authservice.dart';
import 'package:restaurant_app/Utils/CustomerToast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool isLoading = false;
  bool isPasswordVisible = true;
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String mail) {
    if (mail != null)
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(mail);
  }

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
        child: Stack(
          children: [
            Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                children: <Widget>[
                  SizedBox(height: 32.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (input) => input.length >= 5
                        ? null
                        : "Enter at least 5 characters",
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Restaurant name',
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phone_numer,
                    validator: (input) =>
                        input.length >= 10 ? null : "Enter valid phone number",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Phone number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: mail_controller,
                    validator: (input) => input != null && isValidEmail(input)
                        ? null
                        : "Enter valid mail address",
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    controller: password_controller,
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
                      child: Text('Create Account'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await createAccount();
                        } else {
                          Get.snackbar(null, "Please enter valid fields",
                              margin: EdgeInsets.all(10),
                              backgroundColor: kPrimaryColor,
                              colorText: Colors.white);
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isLoading = false;
                        });
                        Get.offAllNamed('/');
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Already have an account? ',
                              style:
                                  TextStyle(color: kTextColor, fontSize: 16)),
                          TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 16)),
                        ]),
                      )),
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

  saveLogin(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('token', token);
      print(prefs.getString('token'));
    });
  }

  Future<void> createAccount() async {
    await AuthService()
        .addNew(
            nameController.text.toString().trim(),
            phone_numer.text.toString().trim(),
            password_controller.text.toString().trim(),
            mail_controller.text.toString().trim())
        .then((result) => {
              setState(() {
                isLoading = false;
              }),
              if (result != null && result.statusCode == 200)
                {
                  if (result.data['success'])
                    {
                      saveLogin(result.data['msg']),
                      Get.offAllNamed('/dashboard'),
                      Get.snackbar("Success", "Account created successfully !",
                          margin: EdgeInsets.all(10),
                          backgroundColor: Colors.lightGreen,
                          colorText: Colors.white)
                    }
                  else {
                      Get.snackbar("Error", result.data['msg']??"Not able create new account please try after some time",
                          margin: EdgeInsets.all(10),
                          backgroundColor: kPrimaryColor,
                          colorText: Colors.white)
                    }
                }
              else
                {failureToast("Error", result.data['message'])}
            });
  }
}
