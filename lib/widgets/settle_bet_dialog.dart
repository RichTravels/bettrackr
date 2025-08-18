import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bet.dart';
import '../providers/bets_provider.dart';

class SettleBetDialog extends StatelessWidget {
  final Bet bet;
  const SettleBetDialog({super.key, required this.bet});

  void _settle(BuildContext context, String result) {
    final betsProvider = Provider.of<BetsProvider>(context, listen: false);

    double profit = 0;
    if (result == "Won") {
      profit = (bet.stake * bet.odds) - bet.stake;
    } else if (result == "Lost") {
      profit = -bet.stake;
    }

    final updatedBet = bet.copyWith(
      result: result,
      profit: profit,
      status: BetStatus.settled,
    );

    betsProvider.updateBet(updatedBet);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Settle Bet',
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        bet.description,
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () => _settle(context, "Lost"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
          child: const Text('Lost'),
        ),
        ElevatedButton(
          onPressed: () => _settle(context, "Won"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent,
          ),
          child: const Text('Won'),
        ),
      ],
    );
  }
}
