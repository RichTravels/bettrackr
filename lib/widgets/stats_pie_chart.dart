import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';

class StatsPieChart extends StatelessWidget {
  const StatsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BetsProvider>(
      builder: (_, bets, __) {
        final c = bets.resultCounts;
        final total = (c.wins + c.losses + c.pushes).clamp(1, 1 << 30);

        final sections = <PieChartSectionData>[
          PieChartSectionData(
            value: c.wins.toDouble(),
            title: '${(c.wins / total * 100).round()}%',
            radius: 60,
          ),
          PieChartSectionData(
            value: c.losses.toDouble(),
            title: '${(c.losses / total * 100).round()}%',
            radius: 60,
          ),
          PieChartSectionData(
            value: c.pushes.toDouble(),
            title: '${(c.pushes / total * 100).round()}%',
            radius: 60,
          ),
        ];

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: PieChart(PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 32,
                sections: sections,
              )),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: const [
                _Legend('Wins'),
                _Legend('Losses'),
                _Legend('Pushes'),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _Legend extends StatelessWidget {
  final String label;
  const _Legend(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 10, height: 10, child: DecoratedBox(decoration: BoxDecoration(color: Colors.black))),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
