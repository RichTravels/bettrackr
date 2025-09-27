// lib/screens/nba_test_screen.dart
import 'package:flutter/material.dart';
import '../utils/nba_brands.dart';
import '../models/bet.dart';
import '../models/sports.dart';
import '../widgets/live_bet_card.dart';

class NbaTestScreen extends StatelessWidget {
  const NbaTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("NBA Test Screen")),
      body: ListView(
        children: nbaBrands.entries.map<Widget>((entry) {
          final brand = entry.value;

          final bet = Bet(
            id: "test-${entry.key.name}",
            sport: SportType.nba,
            teamText: brand.displayName, // NBA isn’t tied to enum like NFL
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
