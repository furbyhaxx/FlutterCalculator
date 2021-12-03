import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button {
  String text;
  Color textColor;  // Colors.green[400]
  Color buttonColor;

  static const Color actionBtnColor = Colors.blueAccent;
  static const Color actionTxtColor = Colors.black;

  static const Color operatorBtnColor = Colors.blue;
  static const Color operatorTxtColor = Colors.white;

  static const Color numberBtnColor = Colors.white;
  static const Color numberTxtColor = Colors.black;

  static const Color calculateBtnColor = Colors.orange;
  static const Color calculateTxtColor = Colors.white;


  Button(this.text, this.buttonColor, this.textColor);

}