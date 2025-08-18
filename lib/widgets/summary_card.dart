// lib/widgets/summary_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bets_provider.dart';
import '../providers/parlays_provider.dart';
import '../models/bet.dart';
import '../models/parlay.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bets = context.watch<BetsProvider>().settledBets;
    final parlays = context.watch<ParlaysProvider>().settledParlays;

    // Windows
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(const Duration(days: 6)); // 7-day window

    // Helpers
    double profitBet(Bet b) {
      final res = (b.result ?? '').toLowerCase();
      if (res == 'win') return b.amount * b.odds - b.amount;
      if (res == 'loss') return -b.amount;
      return 0.0;
    }

    double profitParlay(Parlay p) {
      final res = (p.result ?? '').toLowerCase();
      if (res == 'win') return p.amount * p.combinedOdds - p.amount;
      if (res == 'loss') return -p.amount;
      return 0.0;
    }

    DateTime settleDayBet(Bet b) => DateTime(
      (b.settledAt ?? b.date).year,
      (b.settledAt ?? b.date).month,
      (b.settledAt ?? b.date).day,
    );
    DateTime settleDayParlay(Parlay p) => DateTime(
      (p.settledAt ?? p.date).year,
      (p.settledAt ?? p.date).month,
      (p.settledAt ?? p.date).day,
    );

    bool inWeek(DateTime d) => !d.isBefore(weekStart) && !d.isAfter(today);

    // Today P/L
    final todaySingles = bets.where((b) => settleDayBet(b) == today);
    final todayParlays = parlays.where((p) => settleDayParlay(p) == today);
    final todayPL = todaySingles.fold<double>(0, (s, b) => s + profitBet(b)) +
        todayParlays.fold<double>(0, (s, p) => s + profitParlay(p));

    // Week P/L
    final weekSingles = bets.where((b) => inWeek(settleDayBet(b)));
    final weekParlays = parlays.where((p) => inWeek(settleDayParlay(p)));
    final weekPL = weekSingles.fold<double>(0, (s, b) => s + profitBet(b)) +
        weekParlays.fold<double>(0, (s, p) => s + profitParlay(p));

    // Win rate and ROI
    final wins = bets.where((b) => (b.result ?? '').toLowerCase() == 'win').length +
        parlays.where((p) => (p.result ?? '').toLowerCase() == 'win').length;
    final losses = bets.where((b) => (b.result ?? '').toLowerCase() == 'loss').length +
        parlays.where((p) => (p.result ?? '').toLowerCase() == 'loss').length;
    final nonPush = wins + losses;
    final winRate = nonPush == 0 ? 0.0 : wins / nonPush;

    final totalStaked = bets.fold<double>(0, (s, b) => s + b.amount) +
        parlays.fold<double>(0, (s, p) => s + p.amount);
    final totalProfit = bets.fold<double>(0, (s, b) => s + profitBet(b)) +
        parlays.fold<double>(0, (s, p) => s + profitParlay(p));
    final roi = totalStaked <= 0 ? 0.0 : totalProfit / totalStaked;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: _MetricTile(
                label: 'Today',
                valueWidget: AnimatedMoney(
                  value: todayPL,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: todayPL >= 0 ? Colors.greenAccent : Colors.redAccent,
                  ),
                ),
                chip: _DeltaChip(amount: todayPL),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricTile(
                label: 'Last 7 Days',
                valueWidget: AnimatedMoney(
                  value: weekPL,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: weekPL >= 0 ? Colors.greenAccent : Colors.redAccent,
                  ),
                ),
                chip: _DeltaChip(amount: weekPL),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricTile(
                label: 'Win Rate / ROI',
                valueWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedPercent(
                      value: winRate,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ROI ${_pct(roi)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurface.withOpacity(isDark ? 0.75 : 0.70),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final Widget valueWidget;
  final Widget? chip;

  const _MetricTile({
    required this.label,
    required this.valueWidget,
    this.chip,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: scheme.onSurface.withOpacity(0.7))),
          const SizedBox(height: 6),
          valueWidget,
          if (chip != null) ...[
            const SizedBox(height: 8),
            chip!,
          ],
        ],
      ),
    );
  }
}

class _DeltaChip extends StatelessWidget {
  final double amount;
  const _DeltaChip({required this.amount});

  @override
  Widget build(BuildContext context) {
    final isUp = amount >= 0;
    final bg = (isUp ? Colors.green : Colors.red).withOpacity(0.16);
    final fg = isUp ? Colors.greenAccent : Colors.redAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Text(
        (isUp ? 'Up ' : 'Down ') + _money(amount.abs()),
        style: TextStyle(
          color: fg,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// ==== Little animated readouts (self-contained) ====

class AnimatedMoney extends StatelessWidget {
  final double value;
  final TextStyle? style;
  final Duration duration;
  final bool signed;

  const AnimatedMoney({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 650),
    this.signed = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        final prefix = signed ? (v >= 0 ? '+' : '-') : '';
        final abs = v.abs().toStringAsFixed(2);
        return Text('$prefix\$$abs', style: style);
      },
    );
  }
}

class AnimatedPercent extends StatelessWidget {
  final double value; // 0..1
  final TextStyle? style;
  final Duration duration;

  const AnimatedPercent({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 650),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return Text(_pct(v), style: style);
      },
    );
  }
}

/// ==== Formatting helpers ====

String _money(double n) => '\$${n.toStringAsFixed(2)}';
String _pct(double r) => '${(r * 100).toStringAsFixed(0)}%';
