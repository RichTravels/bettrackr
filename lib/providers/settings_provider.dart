import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _oddsFormat = "decimal";

  ThemeMode get themeMode => _themeMode;
  String get oddsFormat => _oddsFormat;

  SettingsProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('themeMode') ?? 0;
    final odds = prefs.getString('oddsFormat') ?? "decimal";

    _themeMode = ThemeMode.values[themeIndex];
    _oddsFormat = odds;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', mode.index);
    notifyListeners();
  }

  Future<void> setOddsFormat(String format) async {
    _oddsFormat = format;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('oddsFormat', format);
    notifyListeners();
  }
}
