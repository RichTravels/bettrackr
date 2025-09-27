// lib/widgets/football_logo.dart
import 'package:flutter/material.dart';

class FootballLogo extends StatelessWidget {
  final String abbr;
  final Color primary;
  final Color secondary;

  const FootballLogo({
    super.key,
    required this.abbr,
    required this.primary,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // football shape background
            Container(
              width: 42,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.brown.shade700,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
            // football stitches
            Container(
              width: 16,
              height: 2,
              color: Colors.white,
            ),
            // text overlay (team abbreviation)
            Text(
              abbr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
