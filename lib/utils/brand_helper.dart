import 'package:flutter/material.dart';
import '../models/sports.dart';
import '../models/nfl.dart';
import 'nfl_brands.dart';
import 'nba_brands.dart';
import 'ncaaf_brands.dart';
import 'ncaab_brands.dart';
import 'wnba_brands.dart';
import 'mlb_brands.dart';
import 'nhl_brands.dart';

/// A unified team brand across all sports.
/// Holds abbreviation, colors, and optional logo asset path.
class TeamBrand {
  final String abbr;
  final Color primary;
  final Color secondary;
  final List<Color> gradient;
  final String? logo; // we’ll generate initials w/ sport ball, so asset is optional

  const TeamBrand({
    required this.abbr,
    required this.primary,
    required this.secondary,
    this.logo,
  }) : gradient = [primary, secondary];
}

/// Master brand lookup function.
TeamBrand? brandForTeam(SportType sport, dynamic team) {
  switch (sport) {
    case SportType.nfl:
      return nflBrands[team];
    case SportType.nba:
      return nbaBrands[team];
    case SportType.ncaaf:
      return ncaafBrands[team];
    case SportType.ncaab:
      return ncaabBrands[team];
    case SportType.wnba:
      return wnbaBrands[team];
    case SportType.mlb:
      return mlbBrands[team];
    case SportType.nhl:
      return nhlBrands[team];
    default:
      return null;
  }
}
