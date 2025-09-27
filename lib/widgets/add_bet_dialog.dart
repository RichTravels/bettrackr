// lib/screens/add_bet_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';
import '../models/bet.dart';
import '../models/nfl.dart';

class AddBetScreen extends StatefulWidget {
  const AddBetScreen({super.key});

  @override
  State<AddBetScreen> createState() => _AddBetScreenState();
}

class _AddBetScreenState extends State<AddBetScreen> {
  final _descriptionController = TextEditingController();
  double _stake = 0.0;
  double _odds = 1.0;
  bool _isParlay = false;
  NflTeam _selectedTeam = NflTeam.patriots;

  void _submit() {
    final newBet = Bet(
      id: DateTime.now().toIso8601String(),
      description: _descriptionController.text,
      team: _selectedTeam,
      stake: _stake,
      odds: _odds,
      isParlay: _isParlay,
      status: BetStatus.live,
      date: DateTime.now(),
    );

    Provider.of<BetsProvider>(context, listen: false).addBet(newBet);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bet")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Stake"),
              keyboardType: TextInputType.number,
              onChanged: (val) => _stake = double.tryParse(val) ?? 0.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Odds"),
              keyboardType: TextInputType.number,
              onChanged: (val) => _odds = double.tryParse(val) ?? 1.0,
            ),
            DropdownButton<NflTeam>(
              value: _selectedTeam,
              items: NflTeam.values
                  .map((team) =>
                  DropdownMenuItem(value: team, child: Text(team.name)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedTeam = val);
              },
            ),
            SwitchListTile(
              title: const Text("Parlay?"),
              value: _isParlay,
              onChanged: (val) => setState(() => _isParlay = val),
            ),
            ElevatedButton(onPressed: _submit, child: const Text("Add Bet")),
          ],
        ),
      ),
    );
  }
}
