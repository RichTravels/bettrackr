import 'package:flutter/material.dart';
import '../models/nfl.dart';

/// Simple holder for a team’s primary/secondary brand colors.
class TeamColors {
  final Color primary;
  final Color secondary;
  const TeamColors(this.primary, this.secondary);
}

/// Neutral fallback if we don’t have a mapping.
const TeamColors kNeutralTeam = TeamColors(Color(0xFF9E9E9E), Color(0xFF222222));

/// Brand colors by team. Add more as you need.
/// NOTE: The enum cases must match what you have in lib/models/nfl.dart
const Map<NflTeam, TeamColors> nflTeamColors = {
  NflTeam.bal: TeamColors(Color(0xFF241773), Color(0xFF9E7C0C)), // Ravens
  NflTeam.sf:  TeamColors(Color(0xFFAA0000), Color(0xFFB3995D)), // 49ers
  NflTeam.lv:  TeamColors(Color(0xFF000000), Color(0xFFA5ACAF)), // Raiders
  NflTeam.car: TeamColors(Color(0xFF0085CA), Color(0xFF101820)), // Panthers
  NflTeam.kc:  TeamColors(Color(0xFFE31837), Color(0xFFF2C800)), // Chiefs
  // …add the rest any time; unknown teams will fall back to kNeutralTeam
};

/// Pretty names by team (used in the card title).
const Map<NflTeam, String> nflTeamName = {
  NflTeam.bal: 'Baltimore Ravens',
  NflTeam.sf:  'San Francisco 49ers',
  NflTeam.lv:  'Las Vegas Raiders',
  NflTeam.car: 'Carolina Panthers',
  NflTeam.kc:  'Kansas City Chiefs',
  // …add more names as you fill out the colors map
};
