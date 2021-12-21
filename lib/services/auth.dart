import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/login_screen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:rider_app/ComponentsAndConstants/components_constants.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future logInUser(BuildContext context,
      {String? email, String? password}) async {

    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max : 10 , msg:"Authenticating. Please wait");

    final User? user = (await _auth
            .signInWithEmailAndPassword(email: email!, password: password!)
            .catchError((errMsg) {
              Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString());
    }))
        .user;

    if (user != null) {
      userRef.child(user.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          displayToastMessage("Welcome back Mr. " + snap.value["name"]);
          pd.close();
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
        }
      });
      return user;
    } else {
      displayToastMessage("Error: Can't login right now! try again later.");
      Navigator.pop(context);
    }
  }

  Future registerNewUser(BuildContext context,
      {String? email, String? password, String? name, String? phone}) async {
    final User? user = (await _auth
            .createUserWithEmailAndPassword(email: email!, password: password!)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString());
    }))
        .user;

    if (user != null) {
      Map userDataMap = {
        "name": name!.trim(),
        "email": email.trim(),
        "phone": phone!.trim(),
      };
      userRef.child(user.uid).set(userDataMap);
      displayToastMessage("Congratualtions Mr. " +
          userDataMap["name"] +
          " your account just got created!");
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
      return user;
    } else {
      displayToastMessage(
          "Error: Can't create new account right now! try again later.");
    }
  }

  /*Stream<User?> get user{
    return _auth.authStateChanges();
  }*/

  Future signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.idScreen, (route) => false);
  }

}
