// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/login_screen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/ComponentsAndConstants/components_constants.dart';
import 'package:rider_app/services/auth.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";

  final _auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                "Register as a Rider",
                style: TextStyle(fontSize: 24, fontFamily: "Brand-Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    DecoTextFormField(
                      textController: name,
                      labelString: "Name",
                      hintString: "Enter your Name",
                    ),
                    DecoTextFormField(
                      labelString: "Email",
                      hintString: "Enter your email",
                      textController: email,
                    ),
                    DecoTextFormField(
                      labelString: "Phone",
                      hintString: "Enter your phone number",
                      textController: phone,
                    ),
                    DecoTextFormField(
                      obsText: true,
                      labelString: "Password",
                      hintString: "Enter your password",
                      textController: password,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    customElevatedButton(
                        buttonName: "Create Account",
                        onTap: () {
                          if (name.text.length < 3) {
                            displayToastMessage(
                                "Name must be atleast 3 characters.");
                          } else if (!email.text.contains("@")) {
                            displayToastMessage("Email address is not valid.");
                          } else if (phone.text.isEmpty) {
                            displayToastMessage("Phone number is mandatory");
                          } else if (password.text.length < 6) {
                            displayToastMessage(
                                "Password must be atleast 6 characters.");
                          } else {
                            _auth.registerNewUser(context,
                                name: name.text,
                                email: email.text,
                                password: password.text,
                                phone: phone.text);
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.idScreen, (route) => false);
                          },
                          child: Text("Login"),
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                          ),
                        )
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
