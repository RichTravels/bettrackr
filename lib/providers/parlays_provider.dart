import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/parlay.dart';

class ParlaysProvider with ChangeNotifier {
  static const _storeKey = 'parlays_store_v1';

  final List<Parlay> _parlays = [];
  List<Parlay> get parlays => List.unmodifiable(_parlays);

  List<Parlay> get liveParlays =>
      _parlays.where((p) => p.status.toLowerCase() == 'live').toList();

  List<Parlay> get settledParlays =>
      _parlays.where((p) => p.status.toLowerCase() == 'settled').toList()
        ..sort((a, b) {
          final ad = a.settledAt ?? a.date;
          final bd = b.settledAt ?? b.date;
          return bd.compareTo(ad);
        });

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    if (raw != null && raw.isNotEmpty) {
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      _parlays
        ..clear()
        ..addAll(list.map((m) => Parlay.fromMap(m)));
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_parlays.map((p) => p.toMap()).toList());
    await prefs.setString(_storeKey, raw);
  }

  Future<void> add(Parlay p) async {
    _parlays.add(p);
    await _save();
    notifyListeners();
  }

  Future<void> remove(String id) async {
    _parlays.removeWhere((p) => p.id == id);
    await _save();
    notifyListeners();
  }

  Future<void> settle(String id, String result) async {
    final i = _parlays.indexWhere((p) => p.id == id);
    if (i < 0) return;
    _parlays[i] = _parlays[i].copyWith(
      status: 'settled',
      result: result,
      settledAt: DateTime.now(),
    );
    await _save();
    notifyListeners();
  }

  double potentialPayout(Parlay p) => p.amount * p.combinedOdds;
  double potentialProfit(Parlay p) => potentialPayout(p) - p.amount;
}
