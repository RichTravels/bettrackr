// lib/providers/bets_provider.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/bet.dart';

class BetsProvider extends ChangeNotifier {
  final List<Bet> _bets = [];

  List<Bet> get bets => List.unmodifiable(_bets);
  List<Bet> get liveBets => _bets.where((b) => b.status == BetStatus.live).toList();
  List<Bet> get settledBets => _bets.where((b) => b.status != BetStatus.live).toList();

  void addBet(Bet bet) {
    _bets.add(bet);
    notifyListeners();
  }

  void updateBet(Bet bet) {
    final idx = _bets.indexWhere((b) => b.id == bet.id);
    if (idx != -1) {
      _bets[idx] = bet;
      notifyListeners();
    }
  }

  void removeBet(String id) {
    _bets.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  double get totalStake => _bets.fold(0.0, (sum, b) => sum + b.stake);
  double get liveStake  => liveBets.fold(0.0, (sum, b) => sum + b.stake);
  double get totalProfit => settledBets.fold(0.0, (sum, b) => sum + b.profit);

  /// Bankroll model: starting at 0; realized profit minus live exposure
  double get bankroll => totalProfit - liveStake;

  /// Lifetime P/L series (cumulative) based on settled bets date order
  List<FlSpot> get profitSeries {
    final s = List<Bet>.from(settledBets)..sort((a,b) => a.date.compareTo(b.date));
    double acc = 0.0;
    final List<FlSpot> out = [];
    for (var i = 0; i < s.length; i++) {
      acc += s[i].profit;
      out.add(FlSpot(i.toDouble(), acc));
    }
    if (out.isEmpty) {
      // flat zero line (two points avoids fl_chart error)
      return const [FlSpot(0, 0), FlSpot(1, 0)];
    }
    return out;
  }

  Map<BetStatus,int> get resultCounts {
    final m = <BetStatus,int>{};
    for (final b in settledBets) {
      m[b.status] = (m[b.status] ?? 0) + 1;
    }
    return m;
  }
}
