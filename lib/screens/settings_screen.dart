// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          const _SectionHeader('Appearance'),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: const Text('Theme'),
              subtitle: Text(
                switch (settings.themeMode) {
                  ThemeMode.system => 'System',
                  ThemeMode.light  => 'Light',
                  ThemeMode.dark   => 'Dark',
                },
              ),
              trailing: DropdownButton<ThemeMode>(
                value: settings.themeMode,
                onChanged: (mode) {
                  if (mode != null) {
                    context.read<SettingsProvider>().setThemeMode(mode);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark'),
                  ),
                ],
              ),
            ),
          ),

          const _SectionHeader('Bet Preferences'),
          Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: const Text('Odds Format'),
              subtitle: Text(
                switch (settings.oddsFormat) {
                  OddsFormat.american => 'American',
                  OddsFormat.decimal  => 'Decimal',
                },
              ),
              trailing: DropdownButton<OddsFormat>(
                value: settings.oddsFormat,
                onChanged: (v) {
                  if (v != null) {
                    context.read<SettingsProvider>().oddsFormat = v;
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: OddsFormat.american,
                    child: Text('American'),
                  ),
                  DropdownMenuItem(
                    value: OddsFormat.decimal,
                    child: Text('Decimal'),
                  ),
                ],
              ),
            ),
          ),

          const _SectionHeader('About'),
          Card(
            child: ListTile(
              title: const Text('Version'),
              // If you later add package_info_plus, replace 'v1.0.0' with the real version.
              trailing: Text('v1.0.0', style: Theme.of(context).textTheme.labelLarge),
              subtitle: const Text('BetTrackr'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary.withOpacity(0.85);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
