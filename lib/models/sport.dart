// lib/models/sport.dart
enum Sport { nfl, nba, mlb, nhl, ncaaf, ufc, boxing, unknown }

Sport parseSport(String? s) {
  if (s == null) return Sport.unknown;
  switch (s.toLowerCase()) {
    case 'nfl': return Sport.nfl;
    case 'nba': return Sport.nba;
    case 'mlb': return Sport.mlb;
    case 'nhl': return Sport.nhl;
    case 'ncaaf': return Sport.ncaaf;
    case 'ufc': return Sport.ufc;
    case 'boxing': return Sport.boxing;
    default: return Sport.unknown;
  }
}

String sportLabel(Sport s) {
  switch (s) {
    case Sport.nfl: return 'NFL';
    case Sport.nba: return 'NBA';
    case Sport.mlb: return 'MLB';
    case Sport.nhl: return 'NHL';
    case Sport.ncaaf: return 'NCAAF';
    case Sport.ufc: return 'UFC';
    case Sport.boxing: return 'Boxing';
    case Sport.unknown: return 'Sport';
  }
}
