import 'package:flutter/material.dart';

class textStyle {
  TextStyle style2(double x) {
    return new TextStyle(
        color: Colors.black54, fontWeight: FontWeight.bold, fontSize: x * 0.05);
  }

  TextStyle style3(double x) {
    return new TextStyle(
        color: Colors.black54, fontWeight: FontWeight.bold, fontSize: x * 0.04);
  }

  TextStyle style1(double x) {
    return new TextStyle(
        fontSize: x * 0.04,
        color: Colors.black54,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline);
  }

  TextStyle style4(double x) {
    return new TextStyle(
        fontSize: x * 0.07,
        color: Colors.white,
        // fontWeight: FontWeight.bold,
        );
  }
  TextStyle style5(double x) {
    return new TextStyle(
        fontSize: x * 0.03,
        color: Colors.red,
        // fontWeight: FontWeight.bold,
        );
  }
}
