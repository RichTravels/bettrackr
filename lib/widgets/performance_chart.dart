// lib/widgets/performance_chart.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Lightweight, crash-proof performance chart.
/// Pass a list of daily P/L numbers (one per day in the selected window),
/// oldest → newest. Empty list shows the built-in "No results yet" state.
class PerformanceChart extends StatelessWidget {
  const PerformanceChart({
    super.key,
    required this.series,
    this.height = 160,
  });

  /// One value per day (oldest → newest). Can be empty.
  final List<double> series;

  final double height;

  bool get _hasData => series.isNotEmpty && series.any((v) => v != 0);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outline.withOpacity(0.25)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Grid + line
          CustomPaint(
            painter: _ChartGridPainter(
              gridColor: scheme.onSurface.withOpacity(0.12),
            ),
          ),
          if (_hasData)
            CustomPaint(
              painter: _LinePainter(
                values: series,
                lineColor: scheme.primary,
                fillColor: scheme.primary.withOpacity(0.15),
              ),
            )
          else
          // Empty-state label centered
            Center(
              child: Text(
                'No results yet',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.onSurface.withOpacity(0.6)),
              ),
            ),
        ],
      ),
    );
  }
}

class _ChartGridPainter extends CustomPainter {
  _ChartGridPainter({required this.gridColor});
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    // Horizontal grid lines (5)
    final rows = 5;
    for (var i = 0; i <= rows; i++) {
      final y = size.height * (i / rows);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Vertical grid lines (6)
    final cols = 6;
    for (var i = 0; i <= cols; i++) {
      final x = size.width * (i / cols);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ChartGridPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor;
}

class _LinePainter extends CustomPainter {
  _LinePainter({
    required this.values,
    required this.lineColor,
    required this.fillColor,
  });

  final List<double> values;
  final Color lineColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final minV = values.reduce(math.min);
    final maxV = values.reduce(math.max);
    final range = (maxV - minV).abs() < 1e-9 ? 1.0 : (maxV - minV);

    double yFor(double v) {
      // 0 at top, height at bottom (invert so higher P/L is higher line)
      final norm = (v - minV) / range;
      return size.height * (1.0 - norm);
    }

    final n = values.length;
    final dx = n <= 1 ? size.width : size.width / (n - 1);

    final line = Path();
    final fill = Path();

    for (var i = 0; i < n; i++) {
      final x = i * dx;
      final y = yFor(values[i]);
      if (i == 0) {
        line.moveTo(x, y);
        fill.moveTo(x, size.height);
        fill.lineTo(x, y);
      } else {
        line.lineTo(x, y);
        fill.lineTo(x, y);
      }
    }
    // Close fill to bottom-right and back to start
    fill.lineTo(size.width, size.height);
    fill.close();

    final fillPaint = Paint()..color = fillColor;
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(fill, fillPaint);
    canvas.drawPath(line, linePaint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) =>
      oldDelegate.values != values ||
          oldDelegate.lineColor != lineColor ||
          oldDelegate.fillColor != fillColor;
}
