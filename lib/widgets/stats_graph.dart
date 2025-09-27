import 'package:flutter/material.dart';

class StatsGraph extends StatelessWidget {
  const StatsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          "📈 Performance Graph",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
