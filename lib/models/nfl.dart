import 'package:flutter/foundation.dart';

/// Canonical enum for all NFL teams.
/// Use these everywhere in code instead of strings.
enum NflTeam {
  arizonaCardinals,
  atlantaFalcons,
  baltimoreRavens,
  buffaloBills,
  carolinaPanthers,
  chicagoBears,
  cincinnatiBengals,
  clevelandBrowns,
  dallasCowboys,
  denverBroncos,
  detroitLions,
  greenBayPackers,
  houstonTexans,
  indianapolisColts,
  jacksonvilleJaguars,
  kansasCityChiefs,
  lasVegasRaiders,
  losAngelesChargers,
  losAngelesRams,
  miamiDolphins,
  minnesotaVikings,
  newEnglandPatriots,
  newOrleansSaints,
  newYorkGiants,
  newYorkJets,
  philadelphiaEagles,
  pittsburghSteelers,
  sanFrancisco49ers,
  seattleSeahawks,
  tampaBayBuccaneers,
  tennesseeTitans,
  washingtonCommanders,
}

/// Pretty display names by enum.
const Map<NflTeam, String> nflTeamName = {
  NflTeam.arizonaCardinals: 'Arizona Cardinals',
  NflTeam.atlantaFalcons: 'Atlanta Falcons',
  NflTeam.baltimoreRavens: 'Baltimore Ravens',
  NflTeam.buffaloBills: 'Buffalo Bills',
  NflTeam.carolinaPanthers: 'Carolina Panthers',
  NflTeam.chicagoBears: 'Chicago Bears',
  NflTeam.cincinnatiBengals: 'Cincinnati Bengals',
  NflTeam.clevelandBrowns: 'Cleveland Browns',
  NflTeam.dallasCowboys: 'Dallas Cowboys',
  NflTeam.denverBroncos: 'Denver Broncos',
  NflTeam.detroitLions: 'Detroit Lions',
  NflTeam.greenBayPackers: 'Green Bay Packers',
  NflTeam.houstonTexans: 'Houston Texans',
  NflTeam.indianapolisColts: 'Indianapolis Colts',
  NflTeam.jacksonvilleJaguars: 'Jacksonville Jaguars',
  NflTeam.kansasCityChiefs: 'Kansas City Chiefs',
  NflTeam.lasVegasRaiders: 'Las Vegas Raiders',
  NflTeam.losAngelesChargers: 'Los Angeles Chargers',
  NflTeam.losAngelesRams: 'Los Angeles Rams',
  NflTeam.miamiDolphins: 'Miami Dolphins',
  NflTeam.minnesotaVikings: 'Minnesota Vikings',
  NflTeam.newEnglandPatriots: 'New England Patriots',
  NflTeam.newOrleansSaints: 'New Orleans Saints',
  NflTeam.newYorkGiants: 'New York Giants',
  NflTeam.newYorkJets: 'New York Jets',
  NflTeam.philadelphiaEagles: 'Philadelphia Eagles',
  NflTeam.pittsburghSteelers: 'Pittsburgh Steelers',
  NflTeam.sanFrancisco49ers: 'San Francisco 49ers',
  NflTeam.seattleSeahawks: 'Seattle Seahawks',
  NflTeam.tampaBayBuccaneers: 'Tampa Bay Buccaneers',
  NflTeam.tennesseeTitans: 'Tennessee Titans',
  NflTeam.washingtonCommanders: 'Washington Commanders',
};

/// Common abbreviations (and aliases) → enum
const Map<String, NflTeam> _abbrToTeam = {
  'ari': NflTeam.arizonaCardinals,
  'atl': NflTeam.atlantaFalcons,
  'bal': NflTeam.baltimoreRavens,
  'buf': NflTeam.buffaloBills,
  'car': NflTeam.carolinaPanthers,
  'chi': NflTeam.chicagoBears,
  'cin': NflTeam.cincinnatiBengals,
  'cle': NflTeam.clevelandBrowns,
  'dal': NflTeam.dallasCowboys,
  'den': NflTeam.denverBroncos,
  'det': NflTeam.detroitLions,
  'gb':  NflTeam.greenBayPackers,
  'hou': NflTeam.houstonTexans,
  'ind': NflTeam.indianapolisColts,
  'jax': NflTeam.jacksonvilleJaguars,
  'kc':  NflTeam.kansasCityChiefs,
  'lv':  NflTeam.lasVegasRaiders,
  'lac': NflTeam.losAngelesChargers,
  'lar': NflTeam.losAngelesRams,
  'mia': NflTeam.miamiDolphins,
  'min': NflTeam.minnesotaVikings,
  'ne':  NflTeam.newEnglandPatriots,
  'no':  NflTeam.newOrleansSaints,
  'nyg': NflTeam.newYorkGiants,
  'nyj': NflTeam.newYorkJets,
  'phi': NflTeam.philadelphiaEagles,
  'pit': NflTeam.pittsburghSteelers,
  'sf':  NflTeam.sanFrancisco49ers,
  'sea': NflTeam.seattleSeahawks,
  'tb':  NflTeam.tampaBayBuccaneers,
  'ten': NflTeam.tennesseeTitans,
  'wsh': NflTeam.washingtonCommanders,
};

/// Parse free-form input like " kc ", "KANSAS CITY CHIEFS", "LAC" → enum.
/// Falls back to [fallback] if nothing matches.
NflTeam parseNflTeam(String raw, {NflTeam fallback = NflTeam.kansasCityChiefs}) {
  final s = raw.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  // Abbreviations
  final hit = _abbrToTeam[s];
  if (hit != null) return hit;

  // Exact match on display name
  for (final e in NflTeam.values) {
    if (nflTeamName[e]!.toLowerCase() == s) return e;
  }

  // Loose contains match (city/nickname)
  for (final e in NflTeam.values) {
    final name = nflTeamName[e]!.toLowerCase();
    if (name.contains(s) || s.contains(name)) return e;
  }

  return fallback;
}

/// Convert enum back to a canonical display name for storage/JSON.
String nflTeamToName(NflTeam team) => nflTeamName[team]!;
// Abbreviations keyed by enum (used by TeamBadge)
const Map<NflTeam, String> teamAbbr = {
  NflTeam.arizonaCardinals: 'ARI',
  NflTeam.atlantaFalcons: 'ATL',
  NflTeam.baltimoreRavens: 'BAL',
  NflTeam.buffaloBills: 'BUF',
  NflTeam.carolinaPanthers: 'CAR',
  NflTeam.chicagoBears: 'CHI',
  NflTeam.cincinnatiBengals: 'CIN',
  NflTeam.clevelandBrowns: 'CLE',
  NflTeam.dallasCowboys: 'DAL',
  NflTeam.denverBroncos: 'DEN',
  NflTeam.detroitLions: 'DET',
  NflTeam.greenBayPackers: 'GB',
  NflTeam.houstonTexans: 'HOU',
  NflTeam.indianapolisColts: 'IND',
  NflTeam.jacksonvilleJaguars: 'JAX',
  NflTeam.kansasCityChiefs: 'KC',
  NflTeam.lasVegasRaiders: 'LV',
  NflTeam.losAngelesChargers: 'LAC',
  NflTeam.losAngelesRams: 'LAR',
  NflTeam.miamiDolphins: 'MIA',
  NflTeam.minnesotaVikings: 'MIN',
  NflTeam.newEnglandPatriots: 'NE',
  NflTeam.newOrleansSaints: 'NO',
  NflTeam.newYorkGiants: 'NYG',
  NflTeam.newYorkJets: 'NYJ',
  NflTeam.philadelphiaEagles: 'PHI',
  NflTeam.pittsburghSteelers: 'PIT',
  NflTeam.sanFrancisco49ers: 'SF',
  NflTeam.seattleSeahawks: 'SEA',
  NflTeam.tampaBayBuccaneers: 'TB',
  NflTeam.tennesseeTitans: 'TEN',
  NflTeam.washingtonCommanders: 'WSH',
};
