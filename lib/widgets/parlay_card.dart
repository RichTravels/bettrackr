// lib/widgets/parlay_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/parlay.dart';
import '../providers/parlays_provider.dart';

/// --- Minimal odds helpers (self-contained) ---
int decimalToAmerican(double decimal) {
  if (decimal.isNaN || !decimal.isFinite || decimal <= 1.0) return 0;
  if (decimal >= 2.0) {
    return ((decimal - 1.0) * 100).round();
  } else {
    return (-100 / (decimal - 1.0)).round();
  }
}

String formatAmerican(int american) =>
    american > 0 ? '+$american' : american.toString();

String formatDecimal(double decimal) => decimal.toStringAsFixed(2);

class ParlayCard extends StatelessWidget {
  final Parlay parlay;
  const ParlayCard({super.key, required this.parlay});

  void _buzz() => HapticFeedback.lightImpact();
  void _notify(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 900),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final legs = parlay.legs ?? const [];
    final legCount = legs.length;
    final oddsAmerican = formatAmerican(decimalToAmerican(parlay.combinedOdds));
    final oddsDecimal = formatDecimal(parlay.combinedOdds);

    final payout = parlay.amount * parlay.combinedOdds;
    final profit = payout - parlay.amount;

    return Slidable(
      key: ValueKey(parlay.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.60,
        children: [
          SlidableAction(
            onPressed: (_) {
              _buzz();
              context.read<ParlaysProvider>().settle(parlay.id, 'win');
              _notify(context, 'Parlay marked WIN');
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.check,
            label: 'Win',
          ),
          SlidableAction(
            onPressed: (_) {
              _buzz();
              context.read<ParlaysProvider>().settle(parlay.id, 'loss');
              _notify(context, 'Parlay marked LOSS');
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.close,
            label: 'Loss',
          ),
          SlidableAction(
            onPressed: (_) {
              _buzz();
              context.read<ParlaysProvider>().remove(parlay.id);
              _notify(context, 'Parlay deleted');
            },
            backgroundColor: Colors.black54,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: (profit >= 0 ? Colors.green : Colors.red).withOpacity(0.30),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.25 : 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      'Parlay • $legCount legs',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${parlay.amount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Odds / payout row
              Row(
                children: [
                  _Chip(text: oddsAmerican),
                  const SizedBox(width: 8),
                  Text(
                    '($oddsDecimal)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Pays \$${payout.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: profit >= 0 ? Colors.greenAccent : Colors.redAccent,
                    ),
                  ),
                ],
              ),

              // Legs (show first 3; just render a readable label)
              if (legs.isNotEmpty) ...[
                const SizedBox(height: 10),
                ...legs.take(3).map((leg) {
                  // Try a few common fields gracefully; fallback to toString()
                  String label;
                  try {
                    // If leg is a simple Map or object with a 'label' or 'selection' field.
                    final dynamic d = leg;
                    if (d is Map && d['label'] != null) {
                      label = d['label'].toString();
                    } else if (d is Map && d['selection'] != null) {
                      label = d['selection'].toString();
                    } else {
                      label = d.toString();
                    }
                  } catch (_) {
                    label = leg.toString();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        const Icon(Icons.chevron_right, size: 18),
                        Expanded(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                if (legCount > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      '+${legCount - 3} more legs',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: scheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
