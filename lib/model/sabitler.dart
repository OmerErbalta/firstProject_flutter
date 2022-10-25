// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Sabitler {
  static const anaRenk = Colors.lightBlue;

  static const borderRadius = BorderRadius.all(Radius.circular(50));
  static const padding8 = EdgeInsets.all(8);
  static const textStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Nunito',
    fontSize: 17,
  );
  static InputDecoration inputDecoration(String labelText, Icon icon) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0)),
      labelText: labelText,
      helperStyle: TextStyle(color: Colors.white),
      icon: icon,
      labelStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'Nunito',
        fontSize: 17,
      ),
    );
  }
}
