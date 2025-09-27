// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/bets_provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_bet_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/nfl_test_screen.dart';
import 'screens/nba_test_screen.dart';

void main() {
  runApp(const BetTrackrApp());
}

class BetTrackrApp extends StatelessWidget {
  const BetTrackrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BetsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BetTrackr',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.greenAccent,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          cardTheme: const CardThemeData(
            color: Color(0xFF1E1E1E),
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        // 🔥 Boot straight into NBA Test screen
        initialRoute: '/nba-test',
        routes: {
          '/': (context) => const HomeScreen(),
          '/add-bet': (context) => AddBetScreen(),
          '/stats': (context) => const StatsScreen(),
          '/nfl-test': (context) => const NflTestScreen(),
          '/nba-test': (context) => const NbaTestScreen(),
        },
      ),
    );
  }
}
