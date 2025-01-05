import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get themeData {
    switch (_themeMode) {
      case ThemeMode.light:
        return lightMode;
      case ThemeMode.dark:
        return darkMode;
      case ThemeMode.system:
      default:
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        return (brightness == Brightness.dark) ? darkMode : lightMode;
    }
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.system) {
      _themeMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}
