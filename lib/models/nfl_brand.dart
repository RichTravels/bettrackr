// lib/models/nfl_brand.dart
import 'package:flutter/material.dart';
import 'nfl.dart'; // uses NflTeam and nflTeamName (map of enum -> display name)

class TeamBrand {
  final Color primary;
  final Color secondary;
  const TeamBrand(this.primary, this.secondary);
}

String _normalize(String s) =>
    s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');

/// Primary/secondary brand colors keyed by normalized display name.
/// We lookup by enum.name and by display name to be robust to enum key styles.
const Map<String, TeamBrand> _brandByKey = {
  'arizonacardinals': TeamBrand(Color(0xFF97233F), Color(0xFF000000)),
  'atlantafalcons': TeamBrand(Color(0xFFA71930), Color(0xFF000000)),
  'baltimoreravens': TeamBrand(Color(0xFF241773), Color(0xFF9E7C0C)),
  'buffalobills': TeamBrand(Color(0xFF00338D), Color(0xFFC60C30)),
  'carolinapanthers': TeamBrand(Color(0xFF0085CA), Color(0xFF101820)),
  'chicagobears': TeamBrand(Color(0xFF0B162A), Color(0xFFC83803)),
  'cincinnatibengals': TeamBrand(Color(0xFFFB4F14), Color(0xFF000000)),
  'clevelandbrowns': TeamBrand(Color(0xFFFF3C00), Color(0xFF311D00)),
  'dallascowboys': TeamBrand(Color(0xFF041E42), Color(0xFF869397)),
  'denverbroncos': TeamBrand(Color(0xFF002244), Color(0xFFFB4F14)),
  'detroitlions': TeamBrand(Color(0xFF0076B6), Color(0xFFB0B7BC)),
  'greenbaypackers': TeamBrand(Color(0xFF203731), Color(0xFFFFB612)),
  'houstontexans': TeamBrand(Color(0xFF03202F), Color(0xFFA71930)),
  'indianapoliscolts': TeamBrand(Color(0xFF002C5F), Color(0xFFA2AAAD)),
  'jacksonvillejaguars': TeamBrand(Color(0xFF006778), Color(0xFFD7A22A)),
  'kansascitychiefs': TeamBrand(Color(0xFFE31837), Color(0xFFFFB81C)),
  'lasvegasraiders': TeamBrand(Color(0xFF000000), Color(0xFFA5ACAF)),
  'losangeleschargers': TeamBrand(Color(0xFF0080C6), Color(0xFFFFC20E)),
  'losangelesrams': TeamBrand(Color(0xFF003594), Color(0xFFFFA300)),
  'miamidolphins': TeamBrand(Color(0xFF008E97), Color(0xFFF58220)),
  'minnesotavikings': TeamBrand(Color(0xFF4F2683), Color(0xFFFFC62F)),
  'newenglandpatriots': TeamBrand(Color(0xFF002244), Color(0xFFC60C30)),
  'neworleanssaints': TeamBrand(Color(0xFF101820), Color(0xFFD3BC8D)),
  'newyorkgiants': TeamBrand(Color(0xFF0B2265), Color(0xFFA71930)),
  'newyorkjets': TeamBrand(Color(0xFF125740), Color(0xFFFFFFFF)),
  'philadelphiaeagles': TeamBrand(Color(0xFF004C54), Color(0xFFA5ACAF)),
  'pittsburghsteelers': TeamBrand(Color(0xFFFFB612), Color(0xFF101820)),
  'sanfrancisco49ers': TeamBrand(Color(0xFFAA0000), Color(0xFFB3995D)),
  'seattleseahawks': TeamBrand(Color(0xFF002244), Color(0xFF69BE28)),
  'tampabaybuccaneers': TeamBrand(Color(0xFFD50A0A), Color(0xFF34302B)),
  'tennesseetitans': TeamBrand(Color(0xFF0C2340), Color(0xFF4B92DB)),
  'washingtoncommanders': TeamBrand(Color(0xFF5A1414), Color(0xFFFFB612)),
};

TeamBrand brandForTeam(NflTeam t) {
  final enumKey = _normalize(t.name);
  final displayKey = _normalize((nflTeamName[t] ?? t.name));
  return _brandByKey[enumKey] ??
      _brandByKey[displayKey] ??
      const TeamBrand(Colors.grey, Colors.black);
}
