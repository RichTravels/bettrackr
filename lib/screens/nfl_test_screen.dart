// lib/screens/nfl_test_screen.dart
import 'package:flutter/material.dart';
import '../utils/nfl_brands.dart';
import '../models/bet.dart';
import '../models/sports.dart';
import '../widgets/live_bet_card.dart';

class NflTestScreen extends StatelessWidget {
  const NflTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NFL Test Screen")),
      body: ListView(
        children: nflBrands.entries.map<Widget>((entry) {
          final brand = entry.value;

          final bet = Bet(
            id: "test-${entry.key.name}",
            sport: SportType.nfl,
            nflTeam: entry.key,
            betType: "Moneyline",
            oddsDecimal: 1.91,
            stake: 100,
            date: DateTime.now(),
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: LiveBetCard(bet: bet),
          );
        }).toList(),
      ),
    );
  }
}
