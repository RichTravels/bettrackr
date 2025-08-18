import '../utils/odds.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bet.dart';
import '../models/nfl.dart';
import '../widgets/nfl_team_dropdown.dart';
import '../providers/settings_provider.dart';
import '../utils/odds.dart';

class AddBetScreen extends StatefulWidget {
  const AddBetScreen({super.key});

  @override
  State<AddBetScreen> createState() => _AddBetScreenState();
}

class _AddBetScreenState extends State<AddBetScreen> {
  final _formKey = GlobalKey<FormState>();
  NflTeam? _team;
  final _amountCtrl = TextEditingController();
  final _oddsCtrl = TextEditingController(text: '-110'); // default UX
  DateTime _date = DateTime.now();
  String _result = 'push';
  String _status = 'Live';
  final String _sport = 'NFL';

  @override
  void dispose() {
    _amountCtrl.dispose();
    _oddsCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final settings = context.read<SettingsProvider>();
    final fmt = settings.oddsFormat;

    // Parse odds based on current format, store as decimal internally
    late final double decimalOdds;
    if (fmt == OddsFormat.american) {
      final raw = _oddsCtrl.text.trim();
      final cleaned = raw.replaceAll('+', '');
      final withSign = cleaned.startsWith('-') ? cleaned : (raw.startsWith('+') ? cleaned : '-$cleaned');
      final am = int.parse(withSign);
      decimalOdds = americanToDecimal(am);
    } else {
      decimalOdds = double.parse(_oddsCtrl.text.trim());
    }

    final bet = Bet(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      team: _team!,
      amount: double.parse(_amountCtrl.text.trim()),
      odds: decimalOdds, // store decimal
      result: _result,
      sport: _sport,
      date: _date,
      status: _status,
    );

    Navigator.of(context).pop(bet);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final fmt = settings.oddsFormat;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Bet')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Odds format toggle
            SegmentedButton<OddsFormat>(
              segments: const [
                ButtonSegment(value: OddsFormat.american, label: Text('American')),
                ButtonSegment(value: OddsFormat.decimal, label: Text('Decimal')),
              ],
              selected: {fmt},
              onSelectionChanged: (s) => settings.oddsFormat = s.first,
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
            ),
            const SizedBox(height: 12),

            NflTeamDropdown(
              value: _team,
              onChanged: (t) => setState(() => _team = t),
              label: 'NFL Team',
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _amountCtrl,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Enter amount' : null,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _oddsCtrl,
              decoration: InputDecoration(
                labelText: fmt == OddsFormat.american
                    ? 'Odds (e.g., -110 or +105)'
                    : 'Odds (decimal, e.g., 1.91 or 2.05)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: fmt == OddsFormat.american
                  ? const TextInputType.numberWithOptions(signed: true, decimal: false)
                  : const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Enter odds';
                final s = v.trim();
                if (fmt == OddsFormat.american) {
                  final cleaned = s.replaceAll('+', '');
                  final parsed = int.tryParse(cleaned.startsWith('-') ? cleaned : cleaned);
                  if (parsed == null) return 'Use a whole number like -110 or +105';
                  final withSign = s.startsWith('+') || s.startsWith('-')
                      ? parsed
                      : -parsed; // default to negative if no sign
                  if (withSign.abs() < 100) return 'Must be ≤ -100 or ≥ +100';
                  return null;
                } else {
                  final d = double.tryParse(s);
                  if (d == null) return 'Enter a number';
                  if (d <= 1.0) return 'Decimal must be > 1.00';
                  return null;
                }
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: Text('Date: ${_date.toLocal().toString().split(".").first}')),
                TextButton(
                  onPressed: () async {
                    final d = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                      initialDate: _date,
                    );
                    if (d != null) {
                      setState(() =>
                      _date = DateTime(d.year, d.month, d.day, _date.hour, _date.minute));
                    }
                  },
                  child: const Text('Pick date'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _result,
              decoration: const InputDecoration(
                labelText: 'Result',
                border: OutlineInputBorder(),
              ),
              items: const ['win', 'loss', 'push']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _result = v ?? 'push'),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const ['Live', 'Settled']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _status = v ?? 'Live'),
            ),
            const SizedBox(height: 16),

            FilledButton(onPressed: _save, child: const Text('Save Bet')),
          ],
        ),
      ),
    );
  }
}
