import 'package:flutter/material.dart';
import '../models/bet.dart';

class StatsScreen extends StatelessWidget {
  final List<Bet> bets;

  const StatsScreen({super.key, required this.bets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          StatsPieChart(),
          SizedBox(height: 16),
          // you can add a profit line chart next iteration
        ],
      ),
    );
  }