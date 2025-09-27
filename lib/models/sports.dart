// lib/models/sports.dart
enum SportType { nfl, nba, nhl, ufc, boxing, wnba, ncaab }

extension SportTypeName on SportType {
  String get name {
    switch (this) {
      case SportType.nfl:
        return "NFL";
      case SportType.nba:
        return "NBA";
      case SportType.nhl:
        return "NHL";
      case SportType.ufc:
        return "UFC";
      case SportType.boxing:
        return "Boxing";
      case SportType.wnba:
        return "WNBA";
      case SportType.ncaab:
        return "NCAAB";
    }
  }

  String get emoji {
    switch (this) {
      case SportType.nfl:
        return "🏈";
      case SportType.nba:
        return "🏀";
      case SportType.nhl:
        return "🏒";
      case SportType.ufc:
        return "🥋";
      case SportType.boxing:
        return "🥊";
      case SportType.wnba:
        return "🏀";
      case SportType.ncaab:
        return "🏀";
    }
  }
}
