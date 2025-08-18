import 'package:flutter/foundation.dart';
import '../models/bet.dart';

class BetsProvider with ChangeNotifier {
  final List<Bet> _bets = [];

  List<Bet> get allBets => [..._bets];

  List<Bet> get liveBets =>
      _bets.where((b) => b.status == BetStatus.live).toList();

  List<Bet> get settledBets =>
      _bets.where((b) => b.status == BetStatus.settled).toList();

  double get liveExposure {
    return liveBets.fold(0.0, (sum, bet) => sum + bet.stake);
  }

  double get settledPL {
    return settledBets.fold(0.0, (sum, bet) => sum + bet.profit);
  }

  int get winStreak {
    int streak = 0;
    for (var bet in settledBets.reversed) {
      if (bet.result == BetResult.win) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  void addBet(Bet bet) {
    _bets.add(bet);
    notifyListeners();
  }

  void removeBet(Bet bet) {
    _bets.removeWhere((b) => b.id == bet.id);
    notifyListeners();
  }

  void updateBet(Bet updatedBet) {
    final index = _bets.indexWhere((b) => b.id == updatedBet.id);
    if (index != -1) {
      _bets[index] = updatedBet;
      notifyListeners();
    }
  }
}
