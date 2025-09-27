// lib/widgets/team_logo.dart
import 'package:flutter/material.dart';
import '../models/sports.dart'; // ✅ correct path
import '../utils/nfl_brands.dart' as nfl;
import '../utils/nba_brands.dart' as nba;

/// Generalized Team Logo widget for NFL, NBA, etc.
class TeamLogo extends StatelessWidget {
  final dynamic brand; // can be nfl.TeamBrand or nba.TeamBrand
  final String sportIcon; // path to asset like football.png or basketball.png
  final double size;

  const TeamLogo({
    super.key,
    required this.brand,
    required this.sportIcon,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          sportIcon,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
        Text(
          brand.abbr,
          style: TextStyle(
            fontSize: size * 0.38,
            fontWeight: FontWeight.w900,
            color: brand.primary,
            shadows: [
              Shadow(
                color: brand.secondary,
                offset: const Offset(1.5, 1.5),
                blurRadius: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
