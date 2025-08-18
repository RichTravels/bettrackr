// lib/widgets/sportsbook_logo.dart
import 'package:flutter/material.dart';

class SportsbookLogo extends StatelessWidget {
  final bool compact;
  const SportsbookLogo({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Round "BT" badge
        Container(
          width: compact ? 20 : 24,
          height: compact ? 20 : 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                scheme.primary,
                scheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withOpacity(0.35),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'BT',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: scheme.onPrimary,
              fontSize: compact ? 10 : 12,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Wordmark
        RichText(
          text: TextSpan(
            style: TextStyle(
              height: 1.0,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w800,
              fontSize: compact ? 16 : 18,
              color: scheme.onBackground,
            ),
            children: [
              const TextSpan(text: 'Bet'),
              TextSpan(
                text: 'Trackr',
                style: TextStyle(
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
