// lib/widgets/live_bet_card.dart
import 'package:flutter/material.dart';
import '../models/bet.dart';
import '../models/sports.dart';
import '../utils/nfl_brands.dart';
import '../utils/nba_brands.dart';
import 'team_logo.dart';

class LiveBetCard extends StatelessWidget {
  final Bet bet;
  const LiveBetCard({super.key, required this.bet});

  @override
  Widget build(BuildContext context) {
    // Pick brand depending on sport
    dynamic brand;
    String sportIcon = "assets/football.png"; // default

    if (bet.sport == SportType.nfl && bet.nflTeam != null) {
      brand = nflBrands[bet.nflTeam!.name];
      sportIcon = "assets/football.png";
    } else if (bet.sport == SportType.nba ||
        bet.sport == SportType.wnba ||
        bet.sport == SportType.ncaab) {
      if (bet.teamText != null) {
        brand = nbaBrands[bet.teamText!];
      }
      sportIcon = "assets/basketball.png";
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      elevation: 3,
      child: ListTile(
        leading: brand != null
            ? TeamLogo(
          brand: brand,
          sportIcon: sportIcon,
          size: 56,
        )
            : null,
        title: Text(
          bet.teamText ?? bet.displayLabel,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${bet.betType} • Odds ${bet.oddsDecimal.toStringAsFixed(2)}",
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Stake: \$${bet.stake.toStringAsFixed(2)}"),
            Text("To Win: \$${bet.potentialPayout.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
