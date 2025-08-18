import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bet.dart';
import '../providers/bets_provider.dart';

class LiveBetCard extends StatelessWidget {
  final Bet bet;

  const LiveBetCard({Key? key, required this.bet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(bet.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<BetsProvider>().removeBet(bet);
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: ListTile(
          title: Text(
            bet.team,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(
            '${bet.sport} | Odds: ${bet.odds} | Stake: \$${bet.stake.toStringAsFixed(2)}',
          ),
          trailing: bet.isParlay
              ? const Icon(Icons.merge_type, color: Colors.orange) // ✅ Parlay icon
              : null,
        ),
      ),
    );
  }
}
