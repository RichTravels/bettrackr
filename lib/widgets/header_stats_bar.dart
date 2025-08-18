import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';

class HeaderStatsBar extends StatelessWidget {
  const HeaderStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bets = context.watch<BetsProvider>();
    final exposure = bets.liveExposure;
    final pl = bets.settledPL;
    final streak = bets.winStreak;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(
            label: "Live Exposure",
            value: "\$${exposure.toStringAsFixed(2)}",
            valueColor: Colors.orange,
          ),
          _StatItem(
            label: "Settled P/L",
            value: "\$${pl.toStringAsFixed(2)}",
            valueColor: pl >= 0 ? Colors.green : Colors.red,
          ),
          _StatItem(
            label: "Win Streak",
            value: streak.toString(),
            valueColor: streak > 0 ? Colors.greenAccent : Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _StatItem({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
