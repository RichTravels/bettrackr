// lib/widgets/add_parlay_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/parlay.dart';
import '../models/nfl.dart';
import '../providers/settings_provider.dart';
import '../utils/odds.dart';

class AddParlayDialog extends StatefulWidget {
  final void Function(Parlay parlay) onAdd;
  const AddParlayDialog({super.key, required this.onAdd});

  @override
  State<AddParlayDialog> createState() => _AddParlayDialogState();
}

class _AddParlayDialogState extends State<AddParlayDialog> {
  final _form = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final List<_LegRow> _rows = [ _LegRow(), _LegRow() ]; // start with 2 legs

  @override
  void dispose() {
    _amountCtrl.dispose();
    for (final r in _rows) {
      r.oddsCtrl.dispose();
    }
    super.dispose();
  }

  double _combinedDecimalOdds(SettingsProvider settings) {
    double product = 1.0;
    for (final r in _rows) {
      final raw = r.oddsCtrl.text.trim();
      if (raw.isEmpty) return 1.0;
      double dec;
      if (settings.oddsFormat == OddsFormat.american) {
        final parsed = int.tryParse(raw.replaceAll('+', ''));
        dec = parsed == null ? 1.0 : americanToDecimal(parsed);
      } else {
        dec = double.tryParse(raw) ?? 1.0;
      }
      product *= dec;
    }
    return product;
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final fmt = settings.oddsFormat;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 40, height: 4, margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Text('Add Parlay', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              // Dynamic leg rows
              for (int i = 0; i < _rows.length; i++) ...[
                _ParlayLegRow(
                  row: _rows[i],
                  fmt: fmt,
                  onRemove: _rows.length > 2
                      ? () => setState(() => _rows.removeAt(i))
                      : null,
                ),
                const SizedBox(height: 8),
              ],

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => setState(() => _rows.add(_LegRow())),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Leg'),
                ),
              ),
              const SizedBox(height: 8),

              // Amount
              TextFormField(
                controller: _amountCtrl,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Stake Amount (\$)',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final x = double.tryParse(v ?? '');
                  if (x == null || x <= 0) return 'Enter a valid amount';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Live preview of combined odds & payout
              Builder(builder: (_) {
                final dec = _combinedDecimalOdds(settings);
                final am = formatAmerican(decimalToAmerican(dec));
                final amt = double.tryParse(_amountCtrl.text) ?? 0.0;
                final payout = amt * dec;
                final profit = payout - amt;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Combined: $am (${dec.toStringAsFixed(3)}x)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Payout: \$${payout.toStringAsFixed(2)}   •   Profit: \$${profit.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text('Add Parlay'),
                      onPressed: () {
                        if (!(_form.currentState?.validate() ?? false)) return;
                        // basic validation on legs
                        if (_rows.any((r) => r.team == null || r.oddsCtrl.text.trim().isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete all legs')),
                          );
                          return;
                        }
                        final legs = <ParlayLeg>[];
                        for (final r in _rows) {
                          final raw = r.oddsCtrl.text.trim();
                          double dec;
                          if (fmt == OddsFormat.american) {
                            final parsed = int.tryParse(raw.replaceAll('+', ''));
                            dec = parsed == null ? 1.0 : americanToDecimal(parsed);
                          } else {
                            dec = double.tryParse(raw) ?? 1.0;
                          }
                          legs.add(ParlayLeg(team: r.team!, odds: dec));
                        }

                        final decCombined = legs.fold<double>(1.0, (p, l) => p * l.odds);
                        final parlay = Parlay(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          sport: 'nfl',
                          legs: legs,
                          amount: double.parse(_amountCtrl.text.trim()),
                          combinedOdds: decCombined,
                          status: 'live',
                          result: null,
                          date: DateTime.now(),
                        );
                        widget.onAdd(parlay);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegRow {
  NflTeam? team;
  final TextEditingController oddsCtrl = TextEditingController();
}

class _ParlayLegRow extends StatelessWidget {
  final _LegRow row;
  final OddsFormat fmt;
  final VoidCallback? onRemove;
  const _ParlayLegRow({required this.row, required this.fmt, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Team
        Expanded(
          flex: 6,
          child: DropdownButtonFormField<NflTeam>(
            value: row.team,
            items: NflTeam.values
                .map((t) => DropdownMenuItem(
              value: t,
              child: Text(nflTeamName[t] ?? t.name),
            ))
                .toList(),
            onChanged: (t) => row.team = t,
            decoration: const InputDecoration(
              labelText: 'Team',
              border: OutlineInputBorder(),
            ),
            validator: (t) => t == null ? 'Team' : null,
          ),
        ),
        const SizedBox(width: 8),
        // Odds
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: row.oddsCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: fmt == OddsFormat.american ? 'Odds (-110)' : 'Odds (1.91)',
              border: const OutlineInputBorder(),
            ),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Odds' : null,
          ),
        ),
        const SizedBox(width: 8),
        // Remove
        if (onRemove != null)
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onRemove,
          ),
      ],
    );
  }
}
