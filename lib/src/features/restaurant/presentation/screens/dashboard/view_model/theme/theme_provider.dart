import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();

    if (_disposed) return;

    bool isDarkMode = _themeMode == ThemeMode.dark;

    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;

    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);

    if (_disposed) return;

    notifyListeners();
  }

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();

    if (_disposed) return;

    final isDarkMode = prefs.getBool('isDarkMode') ?? false;

    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    if (_disposed) return;

    notifyListeners();
  }
}
