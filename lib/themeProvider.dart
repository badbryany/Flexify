import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeModeKey = 'themeMode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme(); // Load initial theme on instantiation
  }

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_themeModeKey) == null ||
        prefs.getString(_themeModeKey) == '') {
      prefs.setString(_themeModeKey, 'system');
    }

    switch (prefs.getString('themeMode')) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }

  toggleTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
