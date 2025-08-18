// lib/widgets/parlay_calculator_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../utils/odds.dart';

class ParlayCalculatorDialog extends StatefulWidget {
  const ParlayCalculatorDialog({super.key});

  @override
  State<ParlayCalculatorDialog> createState() => _ParlayCalculatorDialogState();
}

class _ParlayCalculatorDialogState extends State<ParlayCalculatorDialog> {
  final _amountCtrl = TextEditingController();
  final List<TextEditingController> _oddsCtrls = [TextEditingController(), TextEditingController()];

  @override
  void dispose() {
    _amountCtrl.dispose();
    for (final c in _oddsCtrls) c.dispose();
    super.dispose();
  }

  void _addLeg() => setState(() => _oddsCtrls.add(TextEditingController()));
  void _removeLeg(int i) => setState(() => _oddsCtrls.removeAt(i));

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final fmt = settings.oddsFormat;

    double product = 1.0;
    for (final c in _oddsCtrls) {
      final raw = c.text.trim();
      if (raw.isEmpty) continue;
      double dec;
      if (fmt == OddsFormat.american) {
        final parsed = int.tryParse(raw.replaceAll('+', ''));
        dec = parsed == null ? 1.0 : americanToDecimal(parsed);
      } else {
        dec = double.tryParse(raw) ?? 1.0;
      }
      product *= dec;
    }
    final amt = double.tryParse(_amountCtrl.text) ?? 0.0;
    final payout = amt * product;
    final profit = payout - amt;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
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
            Text('Parlay Calculator', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),

            for (int i = 0; i < _oddsCtrls.length; i++) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _oddsCtrls[i],
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: fmt == OddsFormat.american ? 'Leg ${i + 1} Odds (-110)' : 'Leg ${i + 1} Odds (1.91)',
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_oddsCtrls.length > 2)
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => _removeLeg(i),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _addLeg,
                icon: const Icon(Icons.add),
                label: const Text('Add Leg'),
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _amountCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Stake Amount (\$)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),

            // Results
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Combined Odds: ${formatAmerican(decimalToAmerican(product))}  (${product.toStringAsFixed(3)}x)'),
                  Text('Payout: \$${payout.toStringAsFixed(2)}'),
                  Text('Profit: \$${profit.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
