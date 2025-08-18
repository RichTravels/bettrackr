// lib/utils/odds.dart

/// Decimal → American (e.g., 1.91 → -110, 2.50 → +150)
int decimalToAmerican(double d) {
  if (d <= 1.0) return 0; // guard
  if (d >= 2.0) {
    return ((d - 1.0) * 100).round();      // plus odds
  } else {
    return (-(100 / (d - 1.0))).round();   // minus odds
  }
}

/// American → Decimal (e.g., -110 → 1.91, +150 → 2.50)
double americanToDecimal(num a) {
  final v = a.toDouble();
  if (v >= 100) return 1.0 + (v / 100.0);      // +150 → 2.50
  if (v <= -100) return 1.0 + (100.0 / -v);    // -110 → 1.91
  // fallback for malformed values
  return 1.0;
}

/// Pretty formats
String formatAmerican(int a) => a >= 0 ? '+$a' : '$a';
String formatDecimal(double d, {int digits = 2}) => d.toStringAsFixed(digits);

/// Optional helper if you ever read a string like "+150" or "-110".
double americanStringToDecimal(String s) {
  final cleaned = s.trim().replaceAll('+', '');
  final parsed = int.tryParse(cleaned);
  return parsed == null ? 1.0 : americanToDecimal(parsed);
}
