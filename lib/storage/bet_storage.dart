import 'package:flutter/foundation.dart';
import '../models/bet.dart';

enum BetResult { pending, win, loss, push }

class Bet {
  final String id;
  final String team;
  final double stake;
  final double odds; // decimal odds (e.g. 1.91, 2.5, etc.)
  final DateTime date;
  BetResult result;

  Bet({
    required this.id,
    required this.team,
    required this.stake,
    required this.odds,
    required this.date,
    this.result = BetResult.pending,
  });

  /// 🔹 Calculate profit dynamically
  double get profit {
    switch (result) {
      case BetResult.win:
        return (stake * odds) - stake; // payout minus stake
      case BetResult.loss:
        return -stake; // lose the stake
      case BetResult.push:
        return 0.0; // refunded
      case BetResult.pending:
        return 0.0; // not settled yet
    }
  }

  /// 🔹 Return potential profit if pending
  double get potentialProfit {
    return (stake * odds) - stake;
  }
}
