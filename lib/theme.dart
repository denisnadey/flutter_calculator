import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xff20274C),
  accentColor: const Color(0xffD4D9EC),
  backgroundColor: const Color(0xff414d7b),
  brightness: Brightness.dark,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Color(0xffffffff))),
);

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.green,
  backgroundColor: const Color(0xff414d7b),
  brightness: Brightness.light,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.green)),
);
