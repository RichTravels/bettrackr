import 'package:flutter/material.dart';
import '../models/nfl.dart';

class TeamBrand {
  final String abbr;
  final String displayName;
  final Color primary;
  final Color secondary;
  final LinearGradient gradient;

  TeamBrand({
    required this.abbr,
    required this.displayName,
    required this.primary,
    required this.secondary,
  }) : gradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

final Map<NflTeam, TeamBrand> nflBrands = {
  NflTeam.bills: TeamBrand(
    abbr: "BUF",
    displayName: "Buffalo Bills",
    primary: Color(0xFF00338D),
    secondary: Color(0xFFC60C30),
  ),
  NflTeam.dolphins: TeamBrand(
    abbr: "MIA",
    displayName: "Miami Dolphins",
    primary: Color(0xFF008E97),
    secondary: Color(0xFFF58220),
  ),
  NflTeam.patriots: TeamBrand(
    abbr: "NE",
    displayName: "New England Patriots",
    primary: Color(0xFF002244),
    secondary: Color(0xFFC60C30),
  ),
  NflTeam.jets: TeamBrand(
    abbr: "NYJ",
    displayName: "New York Jets",
    primary: Color(0xFF125740),
    secondary: Color(0xFF000000),
  ),
  NflTeam.ravens: TeamBrand(
    abbr: "BAL",
    displayName: "Baltimore Ravens",
    primary: Color(0xFF241773),
    secondary: Color(0xFFFFB612),
  ),
  NflTeam.bengals: TeamBrand(
    abbr: "CIN",
    displayName: "Cincinnati Bengals",
    primary: Color(0xFFFB4F14),
    secondary: Color(0xFF000000),
  ),
  NflTeam.browns: TeamBrand(
    abbr: "CLE",
    displayName: "Cleveland Browns",
    primary: Color(0xFF311D00),
    secondary: Color(0xFFFB4F14),
  ),
  NflTeam.steelers: TeamBrand(
    abbr: "PIT",
    displayName: "Pittsburgh Steelers",
    primary: Color(0xFF101820),
    secondary: Color(0xFFFFB612),
  ),
  NflTeam.texans: TeamBrand(
    abbr: "HOU",
    displayName: "Houston Texans",
    primary: Color(0xFF03202F),
    secondary: Color(0xFFA71930),
  ),
  NflTeam.colts: TeamBrand(
    abbr: "IND",
    displayName: "Indianapolis Colts",
    primary: Color(0xFF002C5F),
    secondary: Color(0xFFA2AAAD),
  ),
  NflTeam.jaguars: TeamBrand(
    abbr: "JAX",
    displayName: "Jacksonville Jaguars",
    primary: Color(0xFF006778),
    secondary: Color(0xFFD7A22A),
  ),
  NflTeam.titans: TeamBrand(
    abbr: "TEN",
    displayName: "Tennessee Titans",
    primary: Color(0xFF4B92DB),
    secondary: Color(0xFFC8102E),
  ),
  NflTeam.broncos: TeamBrand(
    abbr: "DEN",
    displayName: "Denver Broncos",
    primary: Color(0xFF002244),
    secondary: Color(0xFFFFA500),
  ),
  NflTeam.chiefs: TeamBrand(
    abbr: "KC",
    displayName: "Kansas City Chiefs",
    primary: Color(0xFFE31837),
    secondary: Color(0xFFFFB81C),
  ),
  NflTeam.raiders: TeamBrand(
    abbr: "LV",
    displayName: "Las Vegas Raiders",
    primary: Color(0xFF000000),
    secondary: Color(0xFFA5ACAF),
  ),
  NflTeam.chargers: TeamBrand(
    abbr: "LAC",
    displayName: "Los Angeles Chargers",
    primary: Color(0xFF0080C6),
    secondary: Color(0xFFFFC20E),
  ),
  NflTeam.cowboys: TeamBrand(
    abbr: "DAL",
    displayName: "Dallas Cowboys",
    primary: Color(0xFF041E42),
    secondary: Color(0xFFA5ACAF),
  ),
  NflTeam.giants: TeamBrand(
    abbr: "NYG",
    displayName: "New York Giants",
    primary: Color(0xFF0B2265),
    secondary: Color(0xFFA71930),
  ),
  NflTeam.eagles: TeamBrand(
    abbr: "PHI",
    displayName: "Philadelphia Eagles",
    primary: Color(0xFF004C54),
    secondary: Color(0xFFA5ACAF),
  ),
  NflTeam.commanders: TeamBrand(
    abbr: "WAS",
    displayName: "Washington Commanders",
    primary: Color(0xFF5A1414),
    secondary: Color(0xFFFFB612),
  ),
  NflTeam.bears: TeamBrand(
    abbr: "CHI",
    displayName: "Chicago Bears",
    primary: Color(0xFF0B162A),
    secondary: Color(0xFFC83803),
  ),
  NflTeam.lions: TeamBrand(
    abbr: "DET",
    displayName: "Detroit Lions",
    primary: Color(0xFF0076B6),
    secondary: Color(0xFFA5ACAF),
  ),
  NflTeam.packers: TeamBrand(
    abbr: "GB",
    displayName: "Green Bay Packers",
    primary: Color(0xFF203731),
    secondary: Color(0xFFFFB612),
  ),
  NflTeam.vikings: TeamBrand(
    abbr: "MIN",
    displayName: "Minnesota Vikings",
    primary: Color(0xFF4F2683),
    secondary: Color(0xFFFFB612),
  ),
  NflTeam.falcons: TeamBrand(
    abbr: "ATL",
    displayName: "Atlanta Falcons",
    primary: Color(0xFFA71930),
    secondary: Color(0xFF000000),
  ),
  NflTeam.panthers: TeamBrand(
    abbr: "CAR",
    displayName: "Carolina Panthers",
    primary: Color(0xFF0085CA),
    secondary: Color(0xFF101820),
  ),
  NflTeam.saints: TeamBrand(
    abbr: "NO",
    displayName: "New Orleans Saints",
    primary: Color(0xFFD3BC8D),
    secondary: Color(0xFF101820),
  ),
  NflTeam.buccaneers: TeamBrand(
    abbr: "TB",
    displayName: "Tampa Bay Buccaneers",
    primary: Color(0xFFD50A0A),
    secondary: Color(0xFF34302B),
  ),
  NflTeam.cardinals: TeamBrand(
    abbr: "ARI",
    displayName: "Arizona Cardinals",
    primary: Color(0xFF97233F),
    secondary: Color(0xFF000000),
  ),
  NflTeam.rams: TeamBrand(
    abbr: "LAR",
    displayName: "Los Angeles Rams",
    primary: Color(0xFF003594),
    secondary: Color(0xFFFFD100),
  ),
  NflTeam.sf49ers: TeamBrand(
    abbr: "SF",
    displayName: "San Francisco 49ers",
    primary: Color(0xFFAA0000),
    secondary: Color(0xFFB3995D),
  ),
  NflTeam.seahawks: TeamBrand(
    abbr: "SEA",
    displayName: "Seattle Seahawks",
    primary: Color(0xFF002244),
    secondary: Color(0xFF69BE28),
  ),
};
