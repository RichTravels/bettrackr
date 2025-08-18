import 'package:flutter/material.dart';
import '../data/nfl_team_colors.dart';
import '../models/nfl.dart'; // <-- needed for NflTeam, teamAbbr, nflTeamName

class TeamBadge extends StatelessWidget {
  final NflTeam team;   // enum, not String
  final double size;
  final bool showAbbr;

  const TeamBadge({
    super.key,
    required this.team,
    this.size = 48,
    this.showAbbr = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = nflTeamColors[team] ?? const TeamColors(Colors.grey, Colors.black);
    final abbr = teamAbbr[team] ?? _fallbackAbbr(team);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.primary,
              border: Border.all(color: colors.secondary.withOpacity(0.95), width: size * 0.08),
              boxShadow: const [BoxShadow(blurRadius: 4, offset: Offset(0,1), spreadRadius: 0.5)],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: -0.6,
              child: Container(
                width: size * 1.1,
                height: size * 0.28,
                decoration: BoxDecoration(
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(size * 0.14),
                ),
              ),
            ),
          ),
          if (showAbbr)
            Center(
              child: Text(
                abbr,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: _bestTextColor(colors.primary),
                  fontSize: size * 0.38,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _fallbackAbbr(NflTeam team) {
    // Use first letters of words from the pretty name, capped at 4 chars.
    final name = nflTeamName[team] ?? team.name;
    final parts = name.split(' ').where((p) => p.isNotEmpty).toList();
    final letters = parts.map((p) => p[0]).join().toUpperCase();
    return letters.length <= 4 ? letters : letters.substring(0, 4);
  }

  Color _bestTextColor(Color bg) =>
      bg.computeLuminance() > 0.35 ? Colors.black : Colors.white;
}
