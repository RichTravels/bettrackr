import 'package:flutter/material.dart';
import '../widgets/football_logo.dart';

class LogoTestScreen extends StatelessWidget {
  const LogoTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Logo Test")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: const [
          FootballLogo(abbr: "MIA", primary: Colors.teal, secondary: Colors.orange),
          FootballLogo(abbr: "LV", primary: Colors.black, secondary: Colors.grey),
          FootballLogo(abbr: "SF", primary: Colors.red, secondary: Color(0xFFB3995D)), // 49ers gold
          FootballLogo(abbr: "BAL", primary: Colors.purple, secondary: Colors.yellow), // swapped gold for yellow
        ],
      ),
    );
  }
}
