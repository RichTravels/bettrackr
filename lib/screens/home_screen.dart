import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';
import '../models/bet.dart';
import '../widgets/live_bet_card.dart';
import '../widgets/profit_chart.dart';
import 'add_bet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final betsProvider = Provider.of<BetsProvider>(context);
    final liveBets = betsProvider.bets.where((b) => b.status == BetStatus.live).toList();
    final settledProfit = betsProvider.bets
        .where((b) => b.status != BetStatus.live)
        .fold(0.0, (sum, b) => sum + b.profit);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png", height: 30), // your app logo
            const SizedBox(width: 8),
            const Text("BetTrackr"),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  "Settled Profit: \$${settledProfit.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.green, fontSize: 18),
                ),
                const SizedBox(height: 8),
                ProfitChart(bets: betsProvider.bets), // ✅ fixed
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: liveBets.isEmpty
                ? const Center(
              child: Text("Your bets will appear here",
                  style: TextStyle(color: Colors.white70)),
            )
                : ListView.builder(
              itemCount: liveBets.length,
              itemBuilder: (ctx, i) => LiveBetCard(bet: liveBets[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddBetScreen()),
          );
        },
      ),
    );
  }
}
