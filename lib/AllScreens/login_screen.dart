// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/registration_screen.dart';
import 'package:rider_app/ComponentsAndConstants/components_constants.dart';
import 'package:rider_app/services/auth.dart';
import 'package:rider_app/services/database.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  AuthService _auth = AuthService();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //reverse: true,
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("images/logo.png"),
                height: height / 4,
              ),
              Text(
                "Login as a Rider",
                style: TextStyle(fontSize: 24, fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    DecoTextFormField(
                      textController: email,
                      labelString: "Email",
                      hintString: "Enter your email here..",
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    DecoTextFormField(
                      obsText: true,
                      textController: password,
                      labelString: "Password",
                      hintString: "Enter your password here..",
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    customElevatedButton(
                        buttonName: "Login",
                        onTap: () {
                          if (!email.text.contains("@")) {
                            displayToastMessage("Email address is not valid.");
                          } else if (password.text.length < 6) {
                            displayToastMessage(
                                "Password must be atleast 6 characters.");
                          } else {
                            _auth.logInUser(context,
                                email: email.text, password: password.text);
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RegistrationScreen.idScreen, (route) => false);
                            },
                            child: Text("Register here."))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
