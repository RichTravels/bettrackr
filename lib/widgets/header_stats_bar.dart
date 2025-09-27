// lib/widgets/header_stats_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';

class HeaderStatsBar extends StatelessWidget {
  const HeaderStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final betsProvider = Provider.of<BetsProvider>(context);

    return Container(
      color: Colors.grey.shade900,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat(
            "Total Bets",
            betsProvider.allBets.length.toString(),
            Colors.blue,
          ),
          _buildStat(
            "Stake",
            "\$${betsProvider.totalStake.toStringAsFixed(2)}",
            Colors.orange,
          ),
          _buildStat(
            "Profit",
            "\$${betsProvider.totalProfit.toStringAsFixed(2)}",
            betsProvider.totalProfit >= 0 ? Colors.green : Colors.red,
          ),
          _buildStat(
            "Live",
            "\$${betsProvider.liveStake.toStringAsFixed(2)}",
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
