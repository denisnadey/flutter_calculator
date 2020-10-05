import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xff131618),
  accentColor: Colors.white,
  brightness: Brightness.dark,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Color(0xffffffff))),
);

ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.green,
  brightness: Brightness.light,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.green)),
);
