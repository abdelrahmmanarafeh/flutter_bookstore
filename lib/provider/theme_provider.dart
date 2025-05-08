import 'package:flutter/material.dart';

// Manages the theme state (light/dark) for the application.
// It extends ChangeNotifier to notify listeners when the theme changes.
class ThemeProvider with ChangeNotifier {
  // Private variable to hold the current theme mode.
  // Defaults to light mode.
  ThemeMode _themeMode = ThemeMode.light;

  // Getter to access the current theme mode.
  ThemeMode get themeMode => _themeMode;

  // Getter to check if dark mode is currently enabled.
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Toggles the theme between light and dark mode.
  void toggleTheme(bool isOn) {
    // Set the theme mode based on the switch's state.
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    // Notify all listening widgets that the theme has changed,
    // so they can rebuild with the new theme.
    notifyListeners();
  }
}
