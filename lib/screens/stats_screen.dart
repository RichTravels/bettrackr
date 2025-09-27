import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/bets_provider.dart';
import '../models/bet.dart';
import '../utils/effects.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bets = Provider.of<BetsProvider>(context).bets;
    final won = bets.where((b) => b.status == BetStatus.won).length;
    final lost = bets.where((b) => b.status == BetStatus.lost).length;
    final push = bets.where((b) => b.status == BetStatus.push).length;

    int streak = 0;
    for (final b in bets.reversed) {
      if (b.status == BetStatus.won) {
        streak = streak >= 0 ? streak + 1 : 1;
      } else if (b.status == BetStatus.lost) {
        streak = streak <= 0 ? streak - 1 : -1;
      } else {
        break;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (streak >= 3) {
        showHotStreakFire(context, streak: streak);
      } else if (streak <= -3) {
        showColdStreakIce(context, streak: -streak);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", height: 30), // logo here too
            const SizedBox(width: 8),
            const Text("Stats"),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                        value: won.toDouble(),
                        color: Colors.green,
                        title: "Wins"),
                    PieChartSectionData(
                        value: lost.toDouble(),
                        color: Colors.red,
                        title: "Losses"),
                    PieChartSectionData(
                        value: push.toDouble(),
                        color: Colors.orange,
                        title: "Push"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Current Streak: $streak",
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
