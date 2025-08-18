import 'package:flutter/material.dart';
import '../models/nfl.dart';

class TeamColors {
  final Color primary;
  final Color secondary;
  const TeamColors(this.primary, this.secondary);
}

const Map<NflTeam, TeamColors> nflTeamColors = {
  NflTeam.arizonaCardinals:   TeamColors(Color(0xFF97233F), Color(0xFF000000)),
  NflTeam.atlantaFalcons:     TeamColors(Color(0xFFA71930), Color(0xFF000000)),
  NflTeam.baltimoreRavens:    TeamColors(Color(0xFF241773), Color(0xFF9E7C0C)),
  NflTeam.buffaloBills:       TeamColors(Color(0xFF00338D), Color(0xFFC60C30)),
  NflTeam.carolinaPanthers:   TeamColors(Color(0xFF0085CA), Color(0xFF101820)),
  NflTeam.chicagoBears:       TeamColors(Color(0xFF0B162A), Color(0xFFC83803)),
  NflTeam.cincinnatiBengals:  TeamColors(Color(0xFFFB4F14), Color(0xFF000000)),
  NflTeam.clevelandBrowns:    TeamColors(Color(0xFF311D00), Color(0xFFFF3C00)),
  NflTeam.dallasCowboys:      TeamColors(Color(0xFF002244), Color(0xFF869397)),
  NflTeam.denverBroncos:      TeamColors(Color(0xFF002244), Color(0xFFFFA500)),
  NflTeam.detroitLions:       TeamColors(Color(0xFF0076B6), Color(0xFFB0B7BC)),
  NflTeam.greenBayPackers:    TeamColors(Color(0xFF203731), Color(0xFFFFB612)),
  NflTeam.houstonTexans:      TeamColors(Color(0xFF03202F), Color(0xFFA71930)),
  NflTeam.indianapolisColts:  TeamColors(Color(0xFF002C5F), Color(0xFFA2AAAD)),
  NflTeam.jacksonvilleJaguars:TeamColors(Color(0xFF006778), Color(0xFFD7A22A)),
  NflTeam.kansasCityChiefs:   TeamColors(Color(0xFFE31837), Color(0xFFFFB81C)),
  NflTeam.lasVegasRaiders:    TeamColors(Color(0xFF000000), Color(0xFFA5ACAF)),
  NflTeam.losAngelesChargers: TeamColors(Color(0xFF0080C6), Color(0xFFFFC20E)),
  NflTeam.losAngelesRams:     TeamColors(Color(0xFF003594), Color(0xFFFFD100)),
  NflTeam.miamiDolphins:      TeamColors(Color(0xFF008E97), Color(0xFFF26A24)),
  NflTeam.minnesotaVikings:   TeamColors(Color(0xFF4F2683), Color(0xFFFFB81C)),
  NflTeam.newEnglandPatriots: TeamColors(Color(0xFF002244), Color(0xFFC60C30)),
  NflTeam.newOrleansSaints:   TeamColors(Color(0xFFD3BC8D), Color(0xFF101820)),
  NflTeam.newYorkGiants:      TeamColors(Color(0xFF0B2265), Color(0xFFA71930)),
  NflTeam.newYorkJets:        TeamColors(Color(0xFF125740), Color(0xFF000000)),
  NflTeam.philadelphiaEagles: TeamColors(Color(0xFF004C54), Color(0xFFA5ACAF)),
  NflTeam.pittsburghSteelers: TeamColors(Color(0xFF000000), Color(0xFFFFB612)),
  NflTeam.sanFrancisco49ers:  TeamColors(Color(0xFFAA0000), Color(0xFFB3995D)),
  NflTeam.seattleSeahawks:    TeamColors(Color(0xFF002244), Color(0xFF69BE28)),
  NflTeam.tampaBayBuccaneers: TeamColors(Color(0xFFD50A0A), Color(0xFF0A0A08)),
  NflTeam.tennesseeTitans:    TeamColors(Color(0xFF0C2340), Color(0xFF4B92DB)),
  NflTeam.washingtonCommanders: TeamColors(Color(0xFF5A1414), Color(0xFFFFB612)),
};
