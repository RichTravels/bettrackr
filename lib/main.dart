import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/bets_provider.dart';
import 'screens/home_screen.dart';

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
          scaffoldBackgroundColor: Colors.grey[900],
          primaryColor: Colors.greenAccent,
          colorScheme: ColorScheme.dark(
            primary: Colors.greenAccent,
            secondary: Colors.greenAccent,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
          cardTheme: CardThemeData(
            color: Colors.grey[850],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(color: Colors.white54),
            labelStyle: const TextStyle(color: Colors.greenAccent),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
