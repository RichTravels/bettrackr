// lib/models/parlay.dart
import 'package:flutter/material.dart';
import 'nfl.dart';

@immutable
class ParlayLeg {
  final NflTeam team;      // leg selection
  final double odds;       // decimal odds for that leg
  const ParlayLeg({required this.team, required this.odds});

  Map<String, dynamic> toMap() => {
    'team': team.index,
    'odds': odds,
  };

  factory ParlayLeg.fromMap(Map<String, dynamic> m) => ParlayLeg(
    team: NflTeam.values[m['team'] as int],
    odds: (m['odds'] as num).toDouble(),
  );
}

@immutable
class Parlay {
  final String id;
  final String sport;           // e.g., 'nfl'
  final List<ParlayLeg> legs;   // 2+ legs
  final double amount;          // stake
  final double combinedOdds;    // decimal combined odds (product of legs)
  final String status;          // 'live' | 'settled'
  final String? result;         // 'win' | 'loss' | 'push' | null
  final DateTime date;          // created
  final DateTime? settledAt;    // when settled

  const Parlay({
    required this.id,
    required this.sport,
    required this.legs,
    required this.amount,
    required this.combinedOdds,
    required this.status,
    this.result,
    required this.date,
    this.settledAt,
  });

  Parlay copyWith({
    String? status,
    String? result,
    DateTime? settledAt,
  }) =>
      Parlay(
        id: id,
        sport: sport,
        legs: legs,
        amount: amount,
        combinedOdds: combinedOdds,
        status: status ?? this.status,
        result: result ?? this.result,
        date: date,
        settledAt: settledAt ?? this.settledAt,
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'sport': sport,
    'legs': legs.map((e) => e.toMap()).toList(),
    'amount': amount,
    'combinedOdds': combinedOdds,
    'status': status,
    'result': result,
    'date': date.millisecondsSinceEpoch,
    'settledAt': settledAt?.millisecondsSinceEpoch,
  };

  factory Parlay.fromMap(Map<String, dynamic> m) => Parlay(
    id: m['id'] as String,
    sport: m['sport'] as String,
    legs: (m['legs'] as List)
        .map((x) => ParlayLeg.fromMap(Map<String, dynamic>.from(x)))
        .toList(),
    amount: (m['amount'] as num).toDouble(),
    combinedOdds: (m['combinedOdds'] as num).toDouble(),
    status: m['status'] as String,
    result: m['result'] as String?,
    date: DateTime.fromMillisecondsSinceEpoch(m['date'] as int),
    settledAt: m['settledAt'] != null
        ? DateTime.fromMillisecondsSinceEpoch(m['settledAt'] as int)
        : null,
  );
}
