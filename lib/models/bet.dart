import 'sports.dart';
import 'nfl.dart';

enum BetStatus { live, won, lost, push }

class Bet {
  final String id;
  final SportType sport;
  final NflTeam? nflTeam;
  final String? teamText;
  final String betType;
  final double oddsDecimal;
  final double stake;
  final BetStatus status;
  final DateTime date;
  final double profit;
  final String? notes;

  Bet({
    required this.id,
    required this.sport,
    this.nflTeam,
    this.teamText,
    required this.betType,
    required this.oddsDecimal,
    required this.stake,
    this.status = BetStatus.live,
    required this.date,
    this.profit = 0.0,
    this.notes,
  });

  bool get isNFL => sport == SportType.nfl;

  String get displayLabel {
    if (isNFL && nflTeam != null) {
      return nflTeamName[nflTeam] ?? nflTeam!.name;
    }
    return teamText ?? sport.name;
  }

  double get potentialPayout => stake * oddsDecimal;
}
