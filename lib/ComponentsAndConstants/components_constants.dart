// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DecoTextFormField extends StatelessWidget {
  DecoTextFormField({this.obsText = false, this.labelString, this.hintString,this.textController});
  bool obsText  ;
  final labelString;
  final hintString;
  final textController;

  @override
  Widget build(BuildContext context) {
    SizedBox(
      height: 1.0,
    );
    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.emailAddress,
      obscureText: obsText,
      decoration: InputDecoration(
        labelText: labelString,
        labelStyle: TextStyle(
          fontSize: 12.0,
        ),
        hintText: hintString,
        hintStyle: TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
      ),
      style: TextStyle(
        fontSize: 14.0,
      ),
    );
  }
}

ElevatedButton customElevatedButton({ String? buttonName, onTap}) {
  return ElevatedButton(
    child: Container(
      //color: Colors.black54,
      height: 50.0,
      child: Center(
        child: Text(
          buttonName!,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Brand-Regular",
            color: Colors.black,
          ),
        ),
      ),
    ),
    style: ElevatedButton.styleFrom(
        primary: Colors.yellowAccent,
        fixedSize: Size.fromWidth(250.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        )),
    onPressed: onTap,
  );
}

displayToastMessage ( String msg){
  Fluttertoast.showToast(msg: msg);
}

/*class ProgressDialog extends StatelessWidget {
  static const String idScreen = "progressDialog";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellowAccent,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),

        ),
      ),
    );
  }
}*/


