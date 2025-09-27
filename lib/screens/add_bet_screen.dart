import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/bet.dart';
import '../models/sports.dart';
import '../models/nfl.dart';
import '../providers/bets_provider.dart';
import '../utils/odds.dart';

class AddBetScreen extends StatefulWidget {
  @override
  State<AddBetScreen> createState() => _AddBetScreenState();
}

class _AddBetScreenState extends State<AddBetScreen> {
  SportType _sport = SportType.nfl;
  NflTeam? _nflTeam;
  String? _teamText;
  String _betType = "Moneyline";
  final _stakeController = TextEditingController();
  final _oddsAmericanController = TextEditingController();

  void _saveBet() {
    if (_stakeController.text.isEmpty || _oddsAmericanController.text.isEmpty) return;

    final stake = double.tryParse(_stakeController.text) ?? 0.0;
    final oddsAmerican = double.tryParse(_oddsAmericanController.text) ?? -110;
    final oddsDecimal = americanToDecimal(oddsAmerican);

    final bet = Bet(
      id: const Uuid().v4(),
      sport: _sport,
      nflTeam: _sport == SportType.nfl ? _nflTeam : null,
      teamText: _sport != SportType.nfl ? _teamText : null,
      betType: _betType,
      oddsDecimal: oddsDecimal,
      stake: stake,
      date: DateTime.now(),
    );

    Provider.of<BetsProvider>(context, listen: false).addBet(bet);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Bet")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<SportType>(
              value: _sport,
              items: SportType.values
                  .map((s) => DropdownMenuItem(value: s, child: Text(s.name)))
                  .toList(),
              onChanged: (val) => setState(() => _sport = val!),
              decoration: const InputDecoration(labelText: "Sport"),
            ),
            if (_sport == SportType.nfl)
              DropdownButtonFormField<NflTeam>(
                value: _nflTeam,
                items: NflTeam.values
                    .map((t) => DropdownMenuItem(
                  value: t,
                  child: Text(nflTeamName[t]!),
                ))
                    .toList(),
                onChanged: (val) => setState(() => _nflTeam = val),
                decoration: const InputDecoration(labelText: "NFL Team"),
              ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Bet Type"),
              initialValue: _betType,
              onChanged: (val) => setState(() => _betType = val),
            ),
            TextFormField(
              controller: _stakeController,
              decoration: const InputDecoration(labelText: "Stake"),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _oddsAmericanController,
              decoration: const InputDecoration(labelText: "American Odds (-110)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBet,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: const Text("Save", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
