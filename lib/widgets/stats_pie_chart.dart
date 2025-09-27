import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../providers/bets_provider.dart';

class StatsPieChart extends StatelessWidget {
  final BetsProvider betsProvider;
  const StatsPieChart({super.key, required this.betsProvider});

  @override
  Widget build(BuildContext context) {
    final counts = betsProvider.resultCounts;
    final total = counts.values.fold<int>(0, (a, b) => a + b);

    if (total == 0) {
      return const Center(
        child: Text("No bets yet", style: TextStyle(color: Colors.white)),
      );
    }

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: counts["win"]!.toDouble(),
            color: Colors.green,
            title: "Wins",
            titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: counts["loss"]!.toDouble(),
            color: Colors.red,
            title: "Losses",
            titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: counts["push"]!.toDouble(),
            color: Colors.orange,
            title: "Push",
            titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          PieChartSectionData(
            value: counts["live"]!.toDouble(),
            color: Colors.blue,
            title: "Live",
            titleStyle: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
