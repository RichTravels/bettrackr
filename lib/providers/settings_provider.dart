// lib/providers/settings_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Odds format preference used by AddBet screen and elsewhere.
enum OddsFormat { american, decimal }

class SettingsProvider with ChangeNotifier {
  // ---- Keys for SharedPreferences ----
  static const _themeKey = 'themeMode';
  static const _oddsKey  = 'oddsFormat';

  // ---- Theme ----
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  // ---- Odds Format ----
  OddsFormat _oddsFormat = OddsFormat.american;
  OddsFormat get oddsFormat => _oddsFormat;

  set oddsFormat(OddsFormat v) {
    _setOddsFormat(v);
  }

  Future<void> _setOddsFormat(OddsFormat v) async {
    _oddsFormat = v;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_oddsKey, v.name);
  }

  // ---- Load persisted settings ----
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();

    // theme
    final t = prefs.getString(_themeKey);
    if (t != null) {
      _themeMode = ThemeMode.values.firstWhere(
            (m) => m.name == t,
        orElse: () => ThemeMode.system,
      );
    }

    // odds
    final o = prefs.getString(_oddsKey);
    if (o != null) {
      _oddsFormat = OddsFormat.values.firstWhere(
            (f) => f.name == o,
        orElse: () => OddsFormat.american,
      );
    }

    notifyListeners();
  }
}
