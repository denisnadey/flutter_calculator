import 'package:flutter/material.dart';
import 'theme.dart';

enum ThemeType { lightTheme, darkTheme }

class ThemeModel extends ChangeNotifier {
  ThemeData currentTheme = darkTheme;
  ThemeType _themeType = ThemeType.darkTheme;

  void toggleTheme() {
    if (_themeType == ThemeType.darkTheme) {
      currentTheme = lightTheme;
      _themeType = ThemeType.lightTheme;
      return notifyListeners();
    }

    if (_themeType == ThemeType.lightTheme) {
      currentTheme = darkTheme;
      _themeType = ThemeType.darkTheme;
      return notifyListeners();
    }
  }
}
