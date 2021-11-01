import 'package:flutter/material.dart';

class Myconstant {
  static String appName = 'Hearing Test';

  //Route
  static String routnsignup = 'signup';
  static String routnlogin = 'login';
  static String routnpath = 'Path';
  //color
  static Color blue = Color.fromRGBO(149, 169, 203, 1);
  static Color neonblue = Color.fromRGBO(0, 138, 216, 1);
  static Color primary = Color.fromRGBO(56, 95, 113, 1);
  static Color lightprimary = Color.fromRGBO(56, 95, 113, 0.8);
  static Color dark = Color.fromRGBO(43, 65, 98, 1);
  static Color light = Color.fromRGBO(245, 240, 246, 1);
  static Color gray = Color.fromRGBO(229, 229, 229, 1);
  static Color darkgray = Color.fromRGBO(196, 196, 196, 1);
  static Color green = Color.fromRGBO(98, 148, 96, 1);
  static Color lightgreen = Color.fromRGBO(139, 187, 137, 1);
  static Color red = Color.fromRGBO(177, 116, 116, 1);
  static Color pink = Color.fromRGBO(224, 62, 82, 1);
  static Color orange = Color.fromRGBO(252, 76, 2, 1);
  static Color yellow = Color.fromRGBO(255, 158, 27, 1);

  TextStyle a1Style() =>
      TextStyle(fontSize: 20, color: Color.fromRGBO(43, 65, 98, 1));
  TextStyle a2Style() =>
      TextStyle(color: Color.fromRGBO(245, 240, 246, 1), fontSize: 20);
  TextStyle a3Style() =>
      TextStyle(color: Color.fromRGBO(245, 240, 246, 1), fontSize: 17);
  TextStyle a4Style() =>
      TextStyle(color: Color.fromRGBO(43, 65, 98, 1), fontSize: 18);

  ButtonStyle myButtonstyle() => ElevatedButton.styleFrom(
        primary: Myconstant.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
}
