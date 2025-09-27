import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Theme Mode",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<ThemeMode>(
            value: settings.themeMode,
            items: const [
              DropdownMenuItem(value: ThemeMode.system, child: Text("System")),
              DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
              DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
            ],
            onChanged: (val) {
              if (val != null) {
                settings.setThemeMode(val);
              }
            },
          ),
          const SizedBox(height: 24),
          const Text("Odds Format",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: settings.oddsFormat,
            items: const [
              DropdownMenuItem(value: "decimal", child: Text("Decimal")),
              DropdownMenuItem(value: "fractional", child: Text("Fractional")),
              DropdownMenuItem(value: "american", child: Text("American")),
            ],
            onChanged: (val) {
              if (val != null) {
                settings.setOddsFormat(val);
              }
            },
          ),
        ],
      ),
    );
  }
}
