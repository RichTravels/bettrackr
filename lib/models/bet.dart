import 'package:flutter/foundation.dart';

enum BetResult { win, loss, push, pending }
enum BetStatus { live, settled }

class Bet {
  final String id;
  final String description;
  final double stake;
  final double odds;
  final BetResult result;
  final double profit;
  final BetStatus status;
  final String team;
  final String sport;
  final DateTime date;
  final bool isParlay; // ✅ Added Parlay flag

  Bet({
    required this.id,
    required this.description,
    required this.stake,
    required this.odds,
    required this.result,
    required this.profit,
    required this.status,
    required this.team,
    required this.sport,
    required this.date,
    this.isParlay = false, // ✅ Default = false
  });

  /// Calculate potential profit
  double get potentialProfit {
    return stake * odds - stake;
  }

  /// CopyWith method for updates
  Bet copyWith({
    String? id,
    String? description,
    double? stake,
    double? odds,
    BetResult? result,
    double? profit,
    BetStatus? status,
    String? team,
    String? sport,
    DateTime? date,
    bool? isParlay,
  }) {
    return Bet(
      id: id ?? this.id,
      description: description ?? this.description,
      stake: stake ?? this.stake,
      odds: odds ?? this.odds,
      result: result ?? this.result,
      profit: profit ?? this.profit,
      status: status ?? this.status,
      team: team ?? this.team,
      sport: sport ?? this.sport,
      date: date ?? this.date,
      isParlay: isParlay ?? this.isParlay,
    );
  }
}
