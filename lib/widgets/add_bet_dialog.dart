import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/bet.dart';
import '../providers/bets_provider.dart';

class AddBetDialog extends StatefulWidget {
  const AddBetDialog({Key? key}) : super(key: key);

  @override
  State<AddBetDialog> createState() => _AddBetDialogState();
}

class _AddBetDialogState extends State<AddBetDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _teamController = TextEditingController();
  final _sportController = TextEditingController();
  final _stakeController = TextEditingController();
  final _oddsController = TextEditingController();

  bool _isParlay = false; // ✅ Track parlay checkbox

  void _saveBet() {
    if (_formKey.currentState!.validate()) {
      final bet = Bet(
        id: const Uuid().v4(),
        description: _descriptionController.text,
        team: _teamController.text,
        sport: _sportController.text,
        stake: double.tryParse(_stakeController.text) ?? 0,
        odds: double.tryParse(_oddsController.text) ?? 1,
        result: BetResult.pending,
        profit: 0,
        status: BetStatus.live,
        date: DateTime.now(),
        isParlay: _isParlay, // ✅ Save parlay option
      );

      context.read<BetsProvider>().addBet(bet);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Bet"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter description" : null,
              ),
              TextFormField(
                controller: _teamController,
                decoration: const InputDecoration(labelText: "Team"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter team" : null,
              ),
              TextFormField(
                controller: _sportController,
                decoration: const InputDecoration(labelText: "Sport"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter sport" : null,
              ),
              TextFormField(
                controller: _stakeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Stake (\$)"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter stake" : null,
              ),
              TextFormField(
                controller: _oddsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Odds"),
                validator: (value) =>
                value == null || value.isEmpty ? "Enter odds" : null,
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                value: _isParlay,
                onChanged: (val) {
                  setState(() => _isParlay = val ?? false);
                },
                title: const Text("Parlay Bet"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _saveBet,
          child: const Text("Add Bet"),
        ),
      ],
    );
  }
}
