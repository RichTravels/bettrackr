import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';
import '../models/bet.dart';

class PerformanceHeader extends StatelessWidget {
  const PerformanceHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final betsProvider = context.watch<BetsProvider>();
    final activeFilter = betsProvider.activeFilter;
    final bets = betsProvider.bets;

    final totalProfit = _totalProfit(bets);
    final totalStake = _totalStake(bets);
    final totalROI = totalStake > 0 ? (totalProfit / totalStake * 100) : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: Colors.black,
      child: Column(
        children: [
          // --- FILTER TABS ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TopTab(
                label: "Live",
                isSelected: activeFilter == BetFilter.live,
                onTap: () =>
                    context.read<BetsProvider>().setFilter(BetFilter.live),
              ),
              const SizedBox(width: 24),
              _TopTab(
                label: "Settled",
                isSelected: activeFilter == BetFilter.settled,
                onTap: () =>
                    context.read<BetsProvider>().setFilter(BetFilter.settled),
              ),
              const SizedBox(width: 24),
              _TopTab(
                label: "Parlay",
                isSelected: activeFilter == BetFilter.parlay,
                onTap: () =>
                    context.read<BetsProvider>().setFilter(BetFilter.parlay),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- PERFORMANCE METRICS ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _metricCard("Profit", totalProfit.toStringAsFixed(2),
                  color: totalProfit >= 0 ? Colors.green : Colors.red),
              _metricCard("Stake", totalStake.toStringAsFixed(2),
                  color: Colors.blue),
              _metricCard("ROI", "${totalROI.toStringAsFixed(1)}%",
                  color: totalROI >= 0 ? Colors.green : Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _metricCard(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  static double _totalProfit(List bets) {
    double profit = 0;
    for (final b in bets) {
      final stake = b.stake ?? 0;
      final odds = b.odds is int ? b.odds : int.tryParse(b.odds.toString()) ?? 0;

      if (b.result == BetResult.win) {
        if (odds > 0) {
          profit += stake * (odds / 100.0);
        } else {
          profit += stake * (100.0 / odds.abs());
        }
      } else if (b.result == BetResult.loss) {
        profit -= stake;
      }
    }
    return profit;
  }

  static double _totalStake(List bets) {
    double sum = 0;
    for (final b in bets) {
      sum += (b.stake ?? 0);
    }
    return sum;
  }
}

class _TopTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TopTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.amber : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          decoration:
          isSelected ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
