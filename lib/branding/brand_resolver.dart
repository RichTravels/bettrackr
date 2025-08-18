// lib/branding/brand_resolver.dart
import 'package:flutter/material.dart';
import '../models/sport.dart';

class TeamBrand {
  final Sport sport;
  final String displayName; // e.g. "Baltimore Ravens" or "McGregor vs Diaz"
  final String badge;       // short label on the circle (e.g. BAL, LAL, UFC, BOX)
  final Color primary;
  final Color secondary;
  final bool isCombat;
  const TeamBrand({
    required this.sport,
    required this.displayName,
    required this.badge,
    required this.primary,
    required this.secondary,
    this.isCombat = false,
  });
}

/// Parse "SPORT: payload" from the team string you save in Bet.team.
/// Returns (sport, payload) where payload is either a team key/name or "A vs B (O/U x.x)".
({Sport sport, String payload}) parseSportAndPayload(String raw) {
  final idx = raw.indexOf(':');
  if (idx <= 0) return (sport: Sport.unknown, payload: raw.trim());
  final sportStr = raw.substring(0, idx).trim();
  final payload = raw.substring(idx + 1).trim();
  return (sport: parseSport(sportStr), payload: payload);
}

String _norm(String s) => s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

/// ======================= NFL (full) =======================
class _Brand {
  final String name, abbr;
  final Color p, s;
  const _Brand(this.name, this.abbr, this.p, this.s);
}
const Map<String, _Brand> _nfl = {
  'ari': _Brand('Arizona Cardinals', 'ARI', Color(0xFF97233F), Color(0xFFFFB612)),
  'atl': _Brand('Atlanta Falcons', 'ATL', Color(0xFFA71930), Color(0xFF000000)),
  'bal': _Brand('Baltimore Ravens', 'BAL', Color(0xFF241773), Color(0xFF9E7C0C)),
  'buf': _Brand('Buffalo Bills', 'BUF', Color(0xFF00338D), Color(0xFFC60C30)),
  'car': _Brand('Carolina Panthers', 'CAR', Color(0xFF0085CA), Color(0xFF101820)),
  'chi': _Brand('Chicago Bears', 'CHI', Color(0xFF0B162A), Color(0xFFC83803)),
  'cin': _Brand('Cincinnati Bengals', 'CIN', Color(0xFFFB4F14), Color(0xFF000000)),
  'cle': _Brand('Cleveland Browns', 'CLE', Color(0xFF311D00), Color(0xFFFF3C00)),
  'dal': _Brand('Dallas Cowboys', 'DAL', Color(0xFF041E42), Color(0xFFA5ACAF)),
  'den': _Brand('Denver Broncos', 'DEN', Color(0xFF002244), Color(0xFFFB4F14)),
  'det': _Brand('Detroit Lions', 'DET', Color(0xFF0076B6), Color(0xFFB0B7BC)),
  'gb':  _Brand('Green Bay Packers', 'GB', Color(0xFF203731), Color(0xFFFFB612)),
  'hou': _Brand('Houston Texans', 'HOU', Color(0xFF03202F), Color(0xFFA71930)),
  'ind': _Brand('Indianapolis Colts', 'IND', Color(0xFF002C5F), Color(0xFFA2AAAD)),
  'jax': _Brand('Jacksonville Jaguars', 'JAX', Color(0xFF006778), Color(0xFFD7A22A)),
  'kc':  _Brand('Kansas City Chiefs', 'KC', Color(0xFFE31837), Color(0xFFF2C800)),
  'lv':  _Brand('Las Vegas Raiders', 'LV', Color(0xFF000000), Color(0xFFA5ACAF)),
  'lac': _Brand('LA Chargers', 'LAC', Color(0xFF0080C6), Color(0xFFFFC20E)),
  'lar': _Brand('LA Rams', 'LAR', Color(0xFF003594), Color(0xFFFFD100)),
  'mia': _Brand('Miami Dolphins', 'MIA', Color(0xFF008E97), Color(0xFFF26A24)),
  'min': _Brand('Minnesota Vikings', 'MIN', Color(0xFF4F2683), Color(0xFFFFC62F)),
  'ne':  _Brand('New England Patriots', 'NE', Color(0xFF002244), Color(0xFFC60C30)),
  'no':  _Brand('New Orleans Saints', 'NO', Color(0xFFD3BC8D), Color(0xFF101820)),
  'nyg': _Brand('New York Giants', 'NYG', Color(0xFF0B2265), Color(0xFFA71930)),
  'nyj': _Brand('New York Jets', 'NYJ', Color(0xFF125740), Color(0xFF000000)),
  'phi': _Brand('Philadelphia Eagles', 'PHI', Color(0xFF004C54), Color(0xFFACC0C6)),
  'pit': _Brand('Pittsburgh Steelers', 'PIT', Color(0xFF101820), Color(0xFFFFB612)),
  'sf':  _Brand('San Francisco 49ers', 'SF', Color(0xFFAA0000), Color(0xFFB3995D)),
  'sea': _Brand('Seattle Seahawks', 'SEA', Color(0xFF002244), Color(0xFF69BE28)),
  'tb':  _Brand('Tampa Bay Buccaneers', 'TB', Color(0xFFD50A0A), Color(0xFF34302B)),
  'ten': _Brand('Tennessee Titans', 'TEN', Color(0xFF0C2340), Color(0xFF4B92DB)),
  'was': _Brand('Washington Commanders', 'WAS', Color(0xFF5A1414), Color(0xFFFFB612)),
};

final Map<String, String> _nflAlias = {
  // add as many as you like
  'ravens':'bal','bal':'bal','baltimore':'bal','baltimoreravens':'bal',
  '49ers':'sf','sanfrancisco':'sf','sanfrancisco49ers':'sf','sf':'sf',
  'raiders':'lv','lasvegas':'lv','lasvegasraiders':'lv','lv':'lv','las':'lv',
  // … (you can continue to expand)
};

/// ======================= NBA/MLB/NHL starter maps =======================
/// Keep these small for now; expand over time.
final Map<String, _Brand> _nba = {
  'lal': _Brand('LA Lakers','LAL', Color(0xFF552583), Color(0xFFFDB927)),
  'bos': _Brand('Boston Celtics','BOS', Color(0xFF008348), Color(0xFFBB9753)),
  'gsw': _Brand('Golden State Warriors','GSW', Color(0xFF1D428A), Color(0xFFFDB927)),
  'mia': _Brand('Miami Heat','MIA', Color(0xFF98002E), Color(0xFFF9A01B)),
  'nyk': _Brand('New York Knicks','NYK', Color(0xFF006BB6), Color(0xFFF58426)),
};

final Map<String, String> _nbaAlias = {
  'lakers':'lal','lal':'lal','losangeleslakers':'lal',
  'celtics':'bos','bos':'bos','bostonceltics':'bos',
  'warriors':'gsw','gsw':'gsw',
  'heat':'mia','mia':'mia',
  'knicks':'nyk','nyk':'nyk',
};

final Map<String, _Brand> _mlb = {
  'nyy': _Brand('New York Yankees','NYY', Color(0xFF0C2340), Color(0xFFC4CED4)),
  'bos': _Brand('Boston Red Sox','BOS', Color(0xFFBD3039), Color(0xFF0D2B56)),
  'lad': _Brand('LA Dodgers','LAD', Color(0xFF005A9C), Color(0xFFD4D4D4)),
  'nym': _Brand('New York Mets','NYM', Color(0xFF002D72), Color(0xFFF56600)),
  'chc': _Brand('Chicago Cubs','CHC', Color(0xFF0E3386), Color(0xFFC41230)),
};

final Map<String, String> _mlbAlias = {
  'yankees':'nyy','nyy':'nyy',
  'redsox':'bos','bostonredsox':'bos','bos':'bos',
  'dodgers':'lad','lad':'lad',
  'mets':'nym','nym':'nym',
  'cubs':'chc','chc':'chc',
};

final Map<String, _Brand> _nhl = {
  'bos': _Brand('Boston Bruins','BOS', Color(0xFFFFB81C), Color(0xFF000000)),
  'nyr': _Brand('New York Rangers','NYR', Color(0xFF0038A8), Color(0xFFCE1126)),
  'tor': _Brand('Toronto Maple Leafs','TOR', Color(0xFF003E7E), Color(0xFFFFFFFF)),
  'chi': _Brand('Chicago Blackhawks','CHI', Color(0xFFD18A00), Color(0xFFCF0A2C)),
  'lak': _Brand('LA Kings','LAK', Color(0xFF111111), Color(0xFFA2AAAD)),
};

final Map<String, String> _nhlAlias = {
  'bruins':'bos','bos':'bos',
  'rangers':'nyr','nyr':'nyr',
  'mapleleafs':'tor','tor':'tor',
  'blackhawks':'chi','chi':'chi',
  'kings':'lak','lak':'lak',
};

/// Fallback gradients per sport when a team isn’t found.
const Map<Sport, (Color, Color)> _sportFallback = {
  Sport.nfl: (Color(0xFF37474F), Color(0xFF263238)),
  Sport.nba: (Color(0xFF283593), Color(0xFF6A1B9A)),
  Sport.mlb: (Color(0xFF0D47A1), Color(0xFFB71C1C)),
  Sport.nhl: (Color(0xFF424242), Color(0xFF9E9E9E)),
  Sport.ncaaf: (Color(0xFF1B5E20), Color(0xFF004D40)),
  Sport.ufc: (Color(0xFFB71C1C), Color(0xFF000000)),
  Sport.boxing: (Color(0xFF1565C0), Color(0xFF880E4F)),
  Sport.unknown: (Color(0xFF455A64), Color(0xFF263238)),
};

TeamBrand resolveBrandFromEncoded(String teamField) {
  final pr = parseSportAndPayload(teamField);
  final sport = pr.sport;
  final token = _norm(pr.payload);

  if (sport == Sport.ufc || sport == Sport.boxing) {
    final (c1, c2) = _sportFallback[sport]!;
    final badge = sport == Sport.ufc ? 'UFC' : 'BOX';
    return TeamBrand(
      sport: sport,
      displayName: pr.payload, // "McGregor vs Diaz (O/U 2.5)"
      badge: badge,
      primary: c1,
      secondary: c2,
      isCombat: true,
    );
  }

  // Try sport-specific dictionaries
  _Brand? b;
  switch (sport) {
    case Sport.nfl:
      b = _nfl[token] ?? _nfl[_nflAlias[token] ?? ''];
      break;
    case Sport.nba:
      b = _nba[token] ?? _nba[_nbaAlias[token] ?? ''];
      break;
    case Sport.mlb:
      b = _mlb[token] ?? _mlb[_mlbAlias[token] ?? ''];
      break;
    case Sport.nhl:
      b = _nhl[token] ?? _nhl[_nhlAlias[token] ?? ''];
      break;
    case Sport.ncaaf:
      b = null; // too many schools — we’ll fallback with sport colors
      break;
    default:
      b = null;
  }

  if (b != null) {
    return TeamBrand(
      sport: sport,
      displayName: b.name,
      badge: b.abbr,
      primary: b.p,
      secondary: b.s,
    );
  }

  // Fallback if team not found (or NCAAF)
  final (c1, c2) = _sportFallback[sport]!;
  final label = sportLabel(sport);
  return TeamBrand(
    sport: sport,
    displayName: pr.payload.isEmpty ? label : pr.payload,
    badge: label,
    primary: c1,
    secondary: c2,
  );
}
