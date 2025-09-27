// lib/utils/nba_brands.dart
import 'package:flutter/material.dart';
import '../models/sports.dart'; // ✅ correct path

class TeamBrand {
  final String abbr;
  final String displayName;
  final Color primary;
  final Color secondary;

  const TeamBrand({
    required this.abbr,
    required this.displayName,
    required this.primary,
    required this.secondary,
  });
}

/// NBA teams — abbreviated + 2-tone brand colors
const Map<String, TeamBrand> nbaBrands = {
  "ATL": TeamBrand(
    abbr: "ATL",
    displayName: "Atlanta Hawks",
    primary: Color(0xFFE03A3E),
    secondary: Color(0xFFC1D32F),
  ),
  "BOS": TeamBrand(
    abbr: "BOS",
    displayName: "Boston Celtics",
    primary: Color(0xFF007A33),
    secondary: Color(0xFFBA9653),
  ),
  "BKN": TeamBrand(
    abbr: "BKN",
    displayName: "Brooklyn Nets",
    primary: Color(0xFF000000),
    secondary: Color(0xFFFFFFFF),
  ),
  "CHA": TeamBrand(
    abbr: "CHA",
    displayName: "Charlotte Hornets",
    primary: Color(0xFF1D1160),
    secondary: Color(0xFF00788C),
  ),
  "CHI": TeamBrand(
    abbr: "CHI",
    displayName: "Chicago Bulls",
    primary: Color(0xFFCE1141),
    secondary: Color(0xFF000000),
  ),
  "CLE": TeamBrand(
    abbr: "CLE",
    displayName: "Cleveland Cavaliers",
    primary: Color(0xFF860038),
    secondary: Color(0xFF041E42),
  ),
  "DAL": TeamBrand(
    abbr: "DAL",
    displayName: "Dallas Mavericks",
    primary: Color(0xFF00538C),
    secondary: Color(0xFF002B5E),
  ),
  "DEN": TeamBrand(
    abbr: "DEN",
    displayName: "Denver Nuggets",
    primary: Color(0xFF0E2240),
    secondary: Color(0xFFFEC524),
  ),
  "DET": TeamBrand(
    abbr: "DET",
    displayName: "Detroit Pistons",
    primary: Color(0xFFC8102E),
    secondary: Color(0xFF1D42BA),
  ),
  "GSW": TeamBrand(
    abbr: "GSW",
    displayName: "Golden State Warriors",
    primary: Color(0xFF1D428A),
    secondary: Color(0xFFFDB927),
  ),
  "HOU": TeamBrand(
    abbr: "HOU",
    displayName: "Houston Rockets",
    primary: Color(0xFFCE1141),
    secondary: Color(0xFF000000),
  ),
  "IND": TeamBrand(
    abbr: "IND",
    displayName: "Indiana Pacers",
    primary: Color(0xFF002D62),
    secondary: Color(0xFFFDBB30),
  ),
  "LAC": TeamBrand(
    abbr: "LAC",
    displayName: "Los Angeles Clippers",
    primary: Color(0xFFC8102E),
    secondary: Color(0xFF1D428A),
  ),
  "LAL": TeamBrand(
    abbr: "LAL",
    displayName: "Los Angeles Lakers",
    primary: Color(0xFF552583),
    secondary: Color(0xFFFDB927),
  ),
  "MEM": TeamBrand(
    abbr: "MEM",
    displayName: "Memphis Grizzlies",
    primary: Color(0xFF5D76A9),
    secondary: Color(0xFF12173F),
  ),
  "MIA": TeamBrand(
    abbr: "MIA",
    displayName: "Miami Heat",
    primary: Color(0xFF98002E),
    secondary: Color(0xFFF9A01B),
  ),
  "MIL": TeamBrand(
    abbr: "MIL",
    displayName: "Milwaukee Bucks",
    primary: Color(0xFF00471B),
    secondary: Color(0xFFEEE1C6),
  ),
  "MIN": TeamBrand(
    abbr: "MIN",
    displayName: "Minnesota Timberwolves",
    primary: Color(0xFF0C2340),
    secondary: Color(0xFF236192),
  ),
  "NOP": TeamBrand(
    abbr: "NOP",
    displayName: "New Orleans Pelicans",
    primary: Color(0xFF0C2340),
    secondary: Color(0xFFC8102E),
  ),
  "NYK": TeamBrand(
    abbr: "NYK",
    displayName: "New York Knicks",
    primary: Color(0xFF006BB6),
    secondary: Color(0xFFF58426),
  ),
  "OKC": TeamBrand(
    abbr: "OKC",
    displayName: "Oklahoma City Thunder",
    primary: Color(0xFF007AC1),
    secondary: Color(0xFFF05133),
  ),
  "ORL": TeamBrand(
    abbr: "ORL",
    displayName: "Orlando Magic",
    primary: Color(0xFF0077C0),
    secondary: Color(0xFFC4CED4),
  ),
  "PHI": TeamBrand(
    abbr: "PHI",
    displayName: "Philadelphia 76ers",
    primary: Color(0xFF006BB6),
    secondary: Color(0xFFED174C),
  ),
  "PHX": TeamBrand(
    abbr: "PHX",
    displayName: "Phoenix Suns",
    primary: Color(0xFF1D1160),
    secondary: Color(0xFFE56020),
  ),
  "POR": TeamBrand(
    abbr: "POR",
    displayName: "Portland Trail Blazers",
    primary: Color(0xFFE03A3E),
    secondary: Color(0xFF000000),
  ),
  "SAC": TeamBrand(
    abbr: "SAC",
    displayName: "Sacramento Kings",
    primary: Color(0xFF5A2D81),
    secondary: Color(0xFFA1A1A4),
  ),
  "SAS": TeamBrand(
    abbr: "SAS",
    displayName: "San Antonio Spurs",
    primary: Color(0xFFC4CED4),
    secondary: Color(0xFF000000),
  ),
  "TOR": TeamBrand(
    abbr: "TOR",
    displayName: "Toronto Raptors",
    primary: Color(0xFFCE1141),
    secondary: Color(0xFF000000),
  ),
  "UTA": TeamBrand(
    abbr: "UTA",
    displayName: "Utah Jazz",
    primary: Color(0xFF002B5C),
    secondary: Color(0xFFF9A01B),
  ),
  "WAS": TeamBrand(
    abbr: "WAS",
    displayName: "Washington Wizards",
    primary: Color(0xFF002B5C),
    secondary: Color(0xFFE31837),
  ),
};
