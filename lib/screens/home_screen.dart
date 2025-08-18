import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bets_provider.dart';
import '../widgets/live_bet_card.dart';
import '../widgets/add_bet_dialog.dart';
import '../widgets/header_stats_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final betsProvider = context.watch<BetsProvider>();

    // Lists for each tab
    final allBets = betsProvider.allBets;
    final liveBets = betsProvider.liveBets;
    final settledBets = betsProvider.settledBets;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.asset(
              "assets/logo.png",
              height: 60,
            ),
            const SizedBox(width: 8),
            const Text(
              "BetTrackr",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AddBetDialog(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const HeaderStatsBar(),
          const SizedBox(height: 12),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                _buildBetList(allBets, "No bets yet. Tap + to add one!"),
                _buildBetList(liveBets, "No live bets right now."),
                _buildBetList(settledBets, "No settled bets yet."),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "All",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill),
            label: "Live",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: "Settled",
          ),
        ],
      ),
    );
  }

  Widget _buildBetList(List bets, String emptyMsg) {
    if (bets.isEmpty) {
      return Center(
        child: Text(
          emptyMsg,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      itemCount: bets.length,
      itemBuilder: (ctx, index) {
        final bet = bets[index];
        return LiveBetCard(bet: bet);
      },
    );
  }
}
