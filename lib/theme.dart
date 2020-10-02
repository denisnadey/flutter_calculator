import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xff131618),
  accentColor: Colors.white,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Color(0xffffffff))),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  accentColor: Colors.green,
  textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.green)),
);
