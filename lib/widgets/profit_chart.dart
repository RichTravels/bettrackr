import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/bet.dart';

class ProfitChart extends StatelessWidget {
  final List<Bet> bets;

  const ProfitChart({super.key, required this.bets});

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [];
    double cumulative = 0;
    for (int i = 0; i < bets.length; i++) {
      cumulative += bets[i].profit;
      spots.add(FlSpot(i.toDouble(), cumulative));
    }

    if (spots.isEmpty) {
      spots.add(const FlSpot(0, 0));
    }

    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.black,
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.green,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            )
          ],
        ),
      ),
    );
  }
}
